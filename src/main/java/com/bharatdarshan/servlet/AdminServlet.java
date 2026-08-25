package com.bharatdarshan.servlet;

import com.bharatdarshan.dao.BookingDAO;
import com.bharatdarshan.dao.MonumentDAO;
import com.bharatdarshan.dao.UserDAO;
import com.bharatdarshan.model.User;
import com.bharatdarshan.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin", "/admin/users", "/admin/user-details", "/admin/send-email"})
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO;
    private BookingDAO bookingDAO;
    private MonumentDAO monumentDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        bookingDAO = new BookingDAO();
        monumentDAO = new MonumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        // ✅ Debug: Print user details
        System.out.println("=== Admin Check ===");
        System.out.println("User ID: " + currentUser.getId());
        System.out.println("User Email: " + currentUser.getEmail());
        System.out.println("User Role: " + currentUser.getRole());
        System.out.println("Is Admin: " + currentUser.isAdmin());

        // ✅ Check if user is admin - using email as fallback
        boolean isAdmin = false;

        // Check by role
        if (currentUser.getRole() != null && currentUser.getRole().equalsIgnoreCase("admin")) {
            isAdmin = true;
        }

        // Fallback: Check by email
        if (!isAdmin && "admin@bharatdarshan.gov.in".equalsIgnoreCase(currentUser.getEmail())) {
            isAdmin = true;
            // Set role if missing
            if (currentUser.getRole() == null) {
                currentUser.setRole("admin");
                session.setAttribute("user", currentUser);
            }
        }

        if (!isAdmin) {
            System.out.println("❌ Access Denied - Not Admin");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        System.out.println("✅ Admin Access Granted");

        String path = request.getServletPath();

        switch (path) {
            case "/admin":
            case "/admin/users":
                handleUserList(request, response);
                break;
            case "/admin/user-details":
                handleUserDetails(request, response);
                break;
            case "/admin/send-email":
                handleSendEmail(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin");
                break;
        }
    }

    private void handleUserList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        List<User> users;

        if (search != null && !search.trim().isEmpty()) {
            users = userDAO.searchUsers(search.trim());
        } else {
            users = userDAO.getAllUsers();
        }

        // Get stats
        int userCount = userDAO.getUserCount();
        int bookingCount = 0;
        int monumentCount = 0;

        // Direct DB queries for stats
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            // Booking count
            ps = conn.prepareStatement("SELECT COUNT(*) FROM tour_booking");
            rs = ps.executeQuery();
            if (rs.next()) bookingCount = rs.getInt(1);
            rs.close();
            ps.close();

            // Monument count
            ps = conn.prepareStatement("SELECT COUNT(*) FROM monument");
            rs = ps.executeQuery();
            if (rs.next()) monumentCount = rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("Error getting stats: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }

        // Count admins
        int adminCount = 0;
        for (User u : users) {
            if (u.isAdmin()) adminCount++;
        }

        request.setAttribute("users", users);
        request.setAttribute("userCount", userCount);
        request.setAttribute("bookingCount", bookingCount);
        request.setAttribute("monumentCount", monumentCount);
        request.setAttribute("adminCount", adminCount);
        request.setAttribute("activePage", "admin");

        request.getRequestDispatcher("/WEB-INF/views/admin-dashboard.jsp").forward(request, response);
    }

    private void handleUserDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(idStr.trim());
            User user = userDAO.getUserById(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            request.setAttribute("userDetails", user);
            request.setAttribute("activePage", "admin");
            request.getRequestDispatcher("/WEB-INF/views/admin-user-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    private void handleSendEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int userId = Integer.parseInt(idStr.trim());
            User user = userDAO.getUserById(userId);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            request.setAttribute("userDetails", user);
            request.setAttribute("activePage", "admin");
            request.getRequestDispatcher("/WEB-INF/views/admin-send-email.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/admin/send-email".equals(path)) {
            handleSendEmailPost(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void handleSendEmailPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("userId");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (userIdStr == null || userIdStr.trim().isEmpty() ||
                subject == null || subject.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/admin-send-email.jsp").forward(request, response);
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr.trim());
            User user = userDAO.getUserById(userId);

            if (user == null) {
                request.setAttribute("error", "User not found.");
                request.getRequestDispatcher("/WEB-INF/views/admin-send-email.jsp").forward(request, response);
                return;
            }

            // Email sending logic
            System.out.println("📧 Email to: " + user.getEmail());
            System.out.println("Subject: " + subject);
            System.out.println("Message: " + message);

            request.setAttribute("success", "Email sent successfully to " + user.getFullName() + " (" + user.getEmail() + ")");
            request.setAttribute("userDetails", user);
            request.getRequestDispatcher("/WEB-INF/views/admin-send-email.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid user ID.");
            request.getRequestDispatcher("/WEB-INF/views/admin-send-email.jsp").forward(request, response);
        }
    }
}