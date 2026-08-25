package com.bharatdarshan.servlet;

import com.bharatdarshan.dao.UserDAO;
import com.bharatdarshan.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile", "/update-profile"})
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Refresh user data from database
        User updatedUser = userDAO.getUserById(user.getId());
        if (updatedUser != null) {
            session.setAttribute("user", updatedUser);
            request.setAttribute("user", updatedUser);
        } else {
            request.setAttribute("user", user);
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            handleUpdateProfile(request, response, session);
        } else if ("change-password".equals(action)) {
            handleChangePassword(request, response, session);
        } else {
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        User currentUser = (User) session.getAttribute("user");

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String contactStr = request.getParameter("contact");
        String dobStr = request.getParameter("dob");

        // Validation
        if (firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                contactStr == null || contactStr.trim().isEmpty() ||
                dobStr == null || dobStr.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        long contact;
        try {
            contact = Long.parseLong(contactStr.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid contact number.");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        Date dob;
        try {
            dob = Date.valueOf(dobStr.trim());
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format. Use YYYY-MM-DD.");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Check if email is being changed and if it's already taken
        if (!email.equalsIgnoreCase(currentUser.getEmail())) {
            if (userDAO.isEmailRegistered(email.trim())) {
                request.setAttribute("error", "Email is already registered by another user.");
                request.setAttribute("user", currentUser);
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                return;
            }
        }

        User updatedUser = new User();
        updatedUser.setId(currentUser.getId());
        updatedUser.setFirstName(firstName.trim());
        updatedUser.setLastName(lastName.trim());
        updatedUser.setGender(gender.trim());
        updatedUser.setEmail(email.trim());
        updatedUser.setContact(contact);
        updatedUser.setDob(dob);
        updatedUser.setCreatedAt(currentUser.getCreatedAt());

        boolean success = userDAO.updateUser(updatedUser);

        if (success) {
            session.setAttribute("user", updatedUser);
            session.setAttribute("userName", updatedUser.getFullName());
            request.setAttribute("success", "Profile updated successfully!");
            request.setAttribute("user", updatedUser);
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
            request.setAttribute("user", currentUser);
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {

        User currentUser = (User) session.getAttribute("user");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (oldPassword == null || oldPassword.trim().isEmpty() ||
                newPassword == null || newPassword.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {

            request.setAttribute("error", "All password fields are required.");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Get current password from database
        String currentPassword = userDAO.getPasswordByUserId(currentUser.getId());

        if (currentPassword == null || !currentPassword.equals(oldPassword.trim())) {
            request.setAttribute("error", "Current password is incorrect!");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match!");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long!");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        boolean success = userDAO.updatePassword(currentUser.getId(), newPassword.trim());

        if (success) {
            request.setAttribute("success", "Password changed successfully!");
        } else {
            request.setAttribute("error", "Failed to change password. Please try again.");
        }

        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
}