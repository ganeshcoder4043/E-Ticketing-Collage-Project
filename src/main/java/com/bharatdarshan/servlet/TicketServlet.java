package com.bharatdarshan.servlet;

import com.bharatdarshan.dao.BookingDAO;
import com.bharatdarshan.model.TourBooking;
import com.bharatdarshan.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller servlet for generating printable E-Ticket view.
 */
@WebServlet(name = "TicketServlet", urlPatterns = {"/e-ticket"})
public class TicketServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-bookings");
            return;
        }

        try {
            int bookingId = Integer.parseInt(idStr.trim());
            TourBooking booking = bookingDAO.getBookingById(bookingId);

            if (booking == null) {
                request.setAttribute("errorMessage", "Ticket not found.");
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            // Security check: ensure ticket belongs to logged-in user
            if (booking.getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/views/e-ticket.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-bookings");
        }
    }
}
