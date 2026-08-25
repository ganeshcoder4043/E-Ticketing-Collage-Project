package com.bharatdarshan.servlet;

import com.bharatdarshan.dao.MonumentDAO;
import com.bharatdarshan.model.Monument;
import com.bharatdarshan.model.TourBooking;
import com.bharatdarshan.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.UUID;

/**
 * Controller servlet for Booking step 1: Visitor details, Date selection, and Fare calculation.
 */
@WebServlet(name = "BookTicketServlet", urlPatterns = {"/book-ticket"})
public class BookTicketServlet extends HttpServlet {

    private MonumentDAO monumentDAO;

    @Override
    public void init() throws ServletException {
        monumentDAO = new MonumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mouIdStr = request.getParameter("mouId");
        if (mouIdStr == null || mouIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/monuments");
            return;
        }

        try {
            int mouId = Integer.parseInt(mouIdStr.trim());
            Monument monument = monumentDAO.getMonumentById(mouId);

            if (monument == null) {
                response.sendRedirect(request.getContextPath() + "/monuments");
                return;
            }

            // Set minimum selectable date to today
            LocalDate today = LocalDate.now();
            request.setAttribute("minDate", today.toString());
            request.setAttribute("maxDate", today.plusMonths(3).toString());
            request.setAttribute("monument", monument);

            request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/monuments");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String mouIdStr = request.getParameter("mouId");
        String tourDateStr = request.getParameter("tourDate");
        String departureTime = request.getParameter("departureTime");
        String adultStr = request.getParameter("adult");
        String childStr = request.getParameter("child");
        String contactName = request.getParameter("contactName");
        String contactPhone = request.getParameter("contactPhone");
        String terms = request.getParameter("terms");

        int mouId = 0;
        try {
            mouId = Integer.parseInt(mouIdStr != null ? mouIdStr.trim() : "0");
        } catch (NumberFormatException ignored) {}

        Monument monument = monumentDAO.getMonumentById(mouId);
        if (monument == null) {
            response.sendRedirect(request.getContextPath() + "/monuments");
            return;
        }

        // Keep values for form reload on error
        request.setAttribute("monument", monument);
        request.setAttribute("minDate", LocalDate.now().toString());
        request.setAttribute("maxDate", LocalDate.now().plusMonths(3).toString());
        request.setAttribute("selectedDate", tourDateStr);
        request.setAttribute("selectedTime", departureTime);
        request.setAttribute("selectedAdult", adultStr);
        request.setAttribute("selectedChild", childStr);
        request.setAttribute("contactName", contactName);
        request.setAttribute("contactPhone", contactPhone);

        // Server validations
        if (tourDateStr == null || tourDateStr.trim().isEmpty() ||
            departureTime == null || departureTime.trim().isEmpty() ||
            contactName == null || contactName.trim().isEmpty() ||
            contactPhone == null || contactPhone.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Please provide all required booking details.");
            request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);
            return;
        }

        if (terms == null) {
            request.setAttribute("errorMessage", "You must accept the ASI monument visiting terms & conditions.");
            request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);
            return;
        }

        Date tourDate;
        try {
            tourDate = Date.valueOf(tourDateStr.trim());
            if (tourDate.toLocalDate().isBefore(LocalDate.now())) {
                request.setAttribute("errorMessage", "Visit date cannot be in the past. Please select a valid upcoming date.");
                request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);
                return;
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid visit date format.");
            request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);
            return;
        }

        int adult = 1;
        int child = 0;
        try {
            adult = Integer.parseInt(adultStr != null ? adultStr.trim() : "1");
            child = Integer.parseInt(childStr != null ? childStr.trim() : "0");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Visitor counts must be valid numbers.");
            request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);
            return;
        }

        if (adult < 1) {
            request.setAttribute("errorMessage", "At least 1 adult visitor is required for a ticket reservation.");
            request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);
            return;
        }

        if (adult + child > 20) {
            request.setAttribute("errorMessage", "Maximum 20 visitors allowed per booking. For group tours, contact ASI circle office.");
            request.getRequestDispatcher("/WEB-INF/views/book-ticket.jsp").forward(request, response);
            return;
        }

        // Calculate Total Amount
        BigDecimal adultFareTotal = monument.getFare().multiply(BigDecimal.valueOf(adult));
        BigDecimal childFareTotal = monument.getChildFare().multiply(BigDecimal.valueOf(child));
        BigDecimal grandTotal = adultFareTotal.add(childFareTotal);

        // Prepare Pending Booking in Session
        TourBooking pendingBooking = new TourBooking();
        pendingBooking.setUserId(user.getId());
        pendingBooking.setMouId(monument.getMouId());
        pendingBooking.setSessionId("ASI-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        pendingBooking.setAdult(adult);
        pendingBooking.setChild(child);
        pendingBooking.setTourDate(tourDate);
        pendingBooking.setDepartureTime(departureTime);
        pendingBooking.setTotalAmount(grandTotal);
        pendingBooking.setContactPersonDetails(contactName.trim() + " (" + contactPhone.trim() + ")");
        pendingBooking.setTerms("Accepted ASI Guidelines");
        pendingBooking.setMonument(monument);
        pendingBooking.setUser(user);

        session.setAttribute("pendingBooking", pendingBooking);

        response.sendRedirect(request.getContextPath() + "/payment");
    }
}
