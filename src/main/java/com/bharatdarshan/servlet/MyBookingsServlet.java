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
import java.util.List;

/**
 * Controller servlet for displaying customer booking history and status.
 */
@WebServlet(name = "MyBookingsServlet", urlPatterns = {"/my-bookings"})
public class MyBookingsServlet extends HttpServlet {

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

        List<TourBooking> bookings = bookingDAO.getBookingsByUserId(user.getId());
        request.setAttribute("bookings", bookings);

        request.getRequestDispatcher("/WEB-INF/views/my-bookings.jsp").forward(request, response);
    }
}
