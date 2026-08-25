package com.bharatdarshan.util;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Authentication Filter to protect sensitive customer endpoints.
 * Redirects unauthenticated requests to login page with friendly message.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {
        "/book-ticket",
        "/payment",
        "/process-payment",
        "/my-bookings",
        "/cancel-booking",
        "/e-ticket"
})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if (isLoggedIn) {
            // User is authenticated, proceed
            chain.doFilter(request, response);
        } else {
            // Preserve requested URL for post-login redirect
            String requestURI = httpRequest.getRequestURI();
            String queryString = httpRequest.getQueryString();
            String targetUrl = requestURI + (queryString != null ? "?" + queryString : "");

            HttpSession newSession = httpRequest.getSession(true);
            newSession.setAttribute("authMessage", "Please log in or register to access this booking feature.");
            newSession.setAttribute("redirectUrl", targetUrl);

            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
    }
}
