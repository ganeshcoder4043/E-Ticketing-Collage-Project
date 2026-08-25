package com.bharatdarshan.servlet;

import com.bharatdarshan.dao.BookingDAO;
import com.bharatdarshan.dao.PaymentDAO;
import com.bharatdarshan.model.PaymentDetails;
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
 * Controller servlet for Payment Selection, Card Input, and Order Finalization.
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment", "/process-payment"})
public class PaymentServlet extends HttpServlet {

    private BookingDAO bookingDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        TourBooking pendingBooking = (session != null) ? (TourBooking) session.getAttribute("pendingBooking") : null;

        if (pendingBooking == null) {
            response.sendRedirect(request.getContextPath() + "/monuments");
            return;
        }

        request.setAttribute("booking", pendingBooking);
        request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        TourBooking pendingBooking = (session != null) ? (TourBooking) session.getAttribute("pendingBooking") : null;
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (pendingBooking == null || user == null) {
            response.sendRedirect(request.getContextPath() + "/monuments");
            return;
        }

        String paymentMode = request.getParameter("paymentMode");
        if (paymentMode == null || paymentMode.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please select a payment mode.");
            request.setAttribute("booking", pendingBooking);
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
            return;
        }

        PaymentDetails paymentDetails = null;

        if ("CREDIT_CARD".equals(paymentMode) || "DEBIT_CARD".equals(paymentMode)) {
            String cardNumber = request.getParameter("cardNumber");
            String cardHolderName = request.getParameter("cardHolderName");
            String expiryDate = request.getParameter("expiryDate");
            String ccvNo = request.getParameter("ccvNo");

            if (cardNumber == null || cardNumber.trim().isEmpty() ||
                cardHolderName == null || cardHolderName.trim().isEmpty() ||
                expiryDate == null || expiryDate.trim().isEmpty() ||
                ccvNo == null || ccvNo.trim().isEmpty()) {

                request.setAttribute("errorMessage", "Please enter complete card details for payment.");
                request.setAttribute("booking", pendingBooking);
                request.setAttribute("selectedMode", paymentMode);
                request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
                return;
            }

            // Clean card number and mask for demo safety
            String rawCard = cardNumber.replaceAll("\\s+", "").replaceAll("-", "");
            String maskedCard = (rawCard.length() >= 4)
                    ? "XXXX-XXXX-XXXX-" + rawCard.substring(rawCard.length() - 4)
                    : "XXXX-XXXX-XXXX-0000";

            paymentDetails = new PaymentDetails();
            paymentDetails.setCardNumber(maskedCard);
            paymentDetails.setCardHolderName(cardHolderName.trim());
            paymentDetails.setExpiryDate(expiryDate.trim());
            paymentDetails.setCcvNo("***"); // Masked for security
            paymentDetails.setTransactionStatus("SUCCESS");

        } else if ("NET_BANKING".equals(paymentMode)) {
            String bankName = request.getParameter("bankName");
            if (bankName == null || bankName.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please select your bank for Net Banking.");
                request.setAttribute("booking", pendingBooking);
                request.setAttribute("selectedMode", paymentMode);
                request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
                return;
            }

            paymentDetails = new PaymentDetails();
            paymentDetails.setCardNumber("NETBANK-" + bankName);
            paymentDetails.setCardHolderName(user.getFullName());
            paymentDetails.setExpiryDate("N/A");
            paymentDetails.setCcvNo("N/A");
            paymentDetails.setTransactionStatus("SUCCESS");

        } else {
            // CASH or Counter/UPI Payment
            paymentDetails = new PaymentDetails();
            paymentDetails.setCardNumber("CASH-COUNTER");
            paymentDetails.setCardHolderName(user.getFullName());
            paymentDetails.setExpiryDate("N/A");
            paymentDetails.setCcvNo("N/A");
            paymentDetails.setTransactionStatus("PENDING_VERIFICATION");
        }

        // Persist Booking
        int bookingId = bookingDAO.createBooking(pendingBooking);

        if (bookingId > 0) {
            // Persist Payment
            paymentDAO.processPayment(bookingId, paymentMode, paymentDetails);

            // Fetch fully populated booking
            TourBooking confirmedBooking = bookingDAO.getBookingById(bookingId);

            // Clear pending booking from session
            session.removeAttribute("pendingBooking");

            // Set confirmed booking for view
            request.setAttribute("confirmedBooking", confirmedBooking);
            request.getRequestDispatcher("/WEB-INF/views/booking-confirmation.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Unable to complete booking due to a server error. Please try again.");
            request.setAttribute("booking", pendingBooking);
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
        }
    }
}
