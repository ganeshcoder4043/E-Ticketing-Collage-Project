package com.bharatdarshan.servlet;

import com.bharatdarshan.dao.MonumentDAO;
import com.bharatdarshan.model.Monument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller servlet for Home / Landing page.
 * Loads featured monuments, states, and categories.
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    private MonumentDAO monumentDAO;

    @Override
    public void init() throws ServletException {
        monumentDAO = new MonumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Monument> featuredList = monumentDAO.getFeaturedMonuments(6);
        List<String> states = monumentDAO.getDistinctStates();
        List<String> types = monumentDAO.getDistinctTypes();

        request.setAttribute("featuredMonuments", featuredList);
        request.setAttribute("states", states);
        request.setAttribute("types", types);

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
