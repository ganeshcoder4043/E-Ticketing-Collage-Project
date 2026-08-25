package com.bharatdarshan.servlet;

import com.bharatdarshan.dao.BookingDAO;
import com.bharatdarshan.dao.CancellationDAO;
import com.bharatdarshan.model.BookingCancellation;
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
import java.math.RoundingMode;
import java.sql.Date;
import java.time.LocalDate;

/**
 * Controller servlet for handling Ticket Cancellations and refund processing.
 */
@WebServlet(name = "CancelBookingServlet", urlPatterns = {"/cancel-booking"})
public class CancelBookingServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private CancellationDAO cancellationDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
        cancellationDAO = new CancellationDAO();
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

            if (booking == null || booking.getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            if (booking.getStatus() != 1) {
                session.setAttribute("flashError", "This ticket is already cancelled or expired.");
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            // Calculate standard 20% cancellation deduction and 80% refund
            BigDecimal totalAmount = booking.getTotalAmount();
            BigDecimal deductedAmount = totalAmount.multiply(new BigDecimal("0.20")).setScale(2, RoundingMode.HALF_UP);
            BigDecimal refundAmount = totalAmount.subtract(deductedAmount);

            request.setAttribute("booking", booking);
            request.setAttribute("deductedAmount", deductedAmount);
            request.setAttribute("refundAmount", refundAmount);

            request.getRequestDispatcher("/WEB-INF/views/cancel-booking.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-bookings");
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

        String bookingIdStr = request.getParameter("bookingId");
        String cancelReason = request.getParameter("cancelReason");
        String confirmCancel = request.getParameter("confirmCancel");

        if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-bookings");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr.trim());
            TourBooking booking = bookingDAO.getBookingById(bookingId);

            if (booking == null || booking.getUserId() != user.getId() || booking.getStatus() != 1) {
                response.sendRedirect(request.getContextPath() + "/my-bookings");
                return;
            }

            if (confirmCancel == null) {
                request.setAttribute("errorMessage", "Please check the confirmation box to proceed with cancellation.");
                doGet(request, response);
                return;
            }

            if (cancelReason == null || cancelReason.trim().isEmpty()) {
                cancelReason = "Personal reasons / Change of travel plans";
            }

            // Calculation
            BigDecimal totalAmount = booking.getTotalAmount();
            BigDecimal deductedAmount = totalAmount.multiply(new BigDecimal("0.20")).setScale(2, RoundingMode.HALF_UP);
            BigDecimal refundAmount = totalAmount.subtract(deductedAmount);

            BookingCancellation cancellation = new BookingCancellation(
                    bookingId,
                    user.getId(),
                    Date.valueOf(LocalDate.now()),
                    cancelReason.trim(),
                    deductedAmount,
                    refundAmount
            );

            int cancelId = cancellationDAO.processCancellation(cancellation);

            if (cancelId > 0) {
                session.setAttribute("flashSuccess", "Ticket #" + bookingId + " has been successfully cancelled. Refund of ₹" + refundAmount + " initiated.");
            } else {
                session.setAttribute("flashError", "Failed to cancel ticket due to a database error. Please try again.");
            }

            response.sendRedirect(request.getContextPath() + "/my-bookings");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/my-bookings");
        }
    }
}
