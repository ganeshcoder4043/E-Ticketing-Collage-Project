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

/**
 * Controller servlet for User Authentication (Login, Register, Logout).
 * Implements strict server-side validation.
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/login":
                // If user is already logged in, redirect to home
                if (isLoggedIn(request)) {
                    response.sendRedirect(request.getContextPath() + "/home");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                break;

            case "/register":
                if (isLoggedIn(request)) {
                    response.sendRedirect(request.getContextPath() + "/home");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                break;

            case "/logout":
                handleLogout(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/home");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/login".equals(path)) {
            handleLogin(request, response);
        } else if ("/register".equals(path)) {
            handleRegister(request, response);
        } else {
            doGet(request, response);
        }
    }

    /**
     * Authenticates user credentials.
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email and Password are required.");
            request.setAttribute("enteredEmail", email);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.validateLogin(email.trim(), password);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getFullName());

            // Check if there was an intended redirect URL before login
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            session.removeAttribute("redirectUrl");
            session.removeAttribute("authMessage");

            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid Email or Password. Please check your credentials.");
            request.setAttribute("enteredEmail", email);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    /**
     * Validates input and creates a new user account.
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String contactStr = request.getParameter("contact");
        String dobStr = request.getParameter("dob");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Retain form inputs in case of validation failure
        request.setAttribute("firstName", firstName);
        request.setAttribute("lastName", lastName);
        request.setAttribute("gender", gender);
        request.setAttribute("email", email);
        request.setAttribute("contact", contactStr);
        request.setAttribute("dob", dobStr);

        // Server-side validation
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            contactStr == null || contactStr.trim().isEmpty() ||
            dobStr == null || dobStr.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required. Please fill in all details.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match. Please re-enter.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        long contact;
        try {
            contact = Long.parseLong(contactStr.trim());
            if (contactStr.trim().length() < 10) {
                request.setAttribute("errorMessage", "Please enter a valid 10-digit mobile number.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Mobile number must contain digits only.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        Date dob;
        try {
            dob = Date.valueOf(dobStr.trim());
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid Date of Birth format (YYYY-MM-DD expected).");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.isEmailRegistered(email.trim())) {
            request.setAttribute("errorMessage", "Email is already registered. Please log in or use another email.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(firstName.trim(), lastName.trim(), gender.trim(), email.trim(), contact, dob);
        int userId = userDAO.registerUser(newUser, password);

        if (userId > 0) {
            newUser.setId(userId);
            HttpSession session = request.getSession(true);
            session.setAttribute("user", newUser);
            session.setAttribute("userId", newUser.getId());
            session.setAttribute("userName", newUser.getFullName());
            session.setAttribute("flashSuccess", "Registration successful! Welcome to BharatDarshan.");

            String redirectUrl = (String) session.getAttribute("redirectUrl");
            session.removeAttribute("redirectUrl");
            session.removeAttribute("authMessage");

            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("errorMessage", "Registration failed due to a database error. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }

    /**
     * Terminates the user session.
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/home");
    }

    private boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }
}
