package com.bharatdarshan.servlet;

/*
import com.bharatdarshan.dao.MonumentDAO;
import com.bharatdarshan.model.Monument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

*/
/**
 * Controller servlet for Monument Catalog, Search, Filter, and Monument Detail screens.
 *//*

@WebServlet(name = "MonumentServlet", urlPatterns = {"/monuments", "/monument-detail"})
public class MonumentServlet extends HttpServlet {

    private MonumentDAO monumentDAO;

    @Override
    public void init() throws ServletException {
        monumentDAO = new MonumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();

        if ("/monument-detail".equals(servletPath)) {
            handleMonumentDetail(request, response);
        } else {
            handleMonumentCatalog(request, response);
        }
    }

    */
/**
     * Handles filtered monument catalog and search.
     *//*

    private void handleMonumentCatalog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("q");
        String state = request.getParameter("state");
        String type = request.getParameter("type");
        String maxPriceStr = request.getParameter("maxPrice");

        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr.trim());
            } catch (NumberFormatException ignored) {
            }
        }

        List<Monument> monuments;
        boolean hasFilter = (query != null && !query.trim().isEmpty()) ||
                            (state != null && !state.trim().isEmpty() && !"ALL".equalsIgnoreCase(state)) ||
                            (type != null && !type.trim().isEmpty() && !"ALL".equalsIgnoreCase(type)) ||
                            (maxPrice != null);

        if (hasFilter) {
            monuments = monumentDAO.searchAndFilter(query, state, type, maxPrice);
        } else {
            monuments = monumentDAO.getAllMonuments();
        }

        List<String> states = monumentDAO.getDistinctStates();
        List<String> types = monumentDAO.getDistinctTypes();

        request.setAttribute("monuments", monuments);
        request.setAttribute("states", states);
        request.setAttribute("types", types);
        request.setAttribute("paramQuery", query);
        request.setAttribute("paramState", state);
        request.setAttribute("paramType", type);
        request.setAttribute("paramMaxPrice", maxPriceStr);
        request.setAttribute("resultCount", monuments.size());

        request.getRequestDispatcher("/WEB-INF/views/monuments.jsp").forward(request, response);
    }

    */
/**
     * Handles single monument detailed view.
     *//*

    private void handleMonumentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/monuments");
            return;
        }

        try {
            int mouId = Integer.parseInt(idStr.trim());
            Monument monument = monumentDAO.getMonumentById(mouId);

            if (monument == null) {
                request.setAttribute("errorMessage", "The requested monument was not found.");
                request.getRequestDispatcher("/WEB-INF/views/monuments.jsp").forward(request, response);
                return;
            }

            request.setAttribute("monument", monument);
            request.getRequestDispatcher("/WEB-INF/views/monument-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/monuments");
        }
    }
}
*/



// 🔴 YAHA SE COPY KAREIN 🔴


import com.bharatdarshan.dao.MonumentDAO;
import com.bharatdarshan.model.Monument;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "MonumentServlet", urlPatterns = {"/monuments", "/monument-detail"})
public class MonumentServlet extends HttpServlet {

    private MonumentDAO monumentDAO;

    @Override
    public void init() throws ServletException {
        monumentDAO = new MonumentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();

        if ("/monument-detail".equals(servletPath)) {
            handleMonumentDetail(request, response);
        } else {
            handleMonumentCatalog(request, response);
        }
    }

    // ✅ FIX IMAGE PATH - SIRF YEH METHOD ADD KAREIN (1)
    private String fixImagePath(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) return "static/images/default.jpg";
        if (imageUrl.startsWith("C:/") || imageUrl.startsWith("C:\\")) {
            String filename = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
            if (filename.contains("\\")) filename = filename.substring(filename.lastIndexOf("\\") + 1);
            return "static/images/" + filename;
        }
        return imageUrl;
    }

    private void handleMonumentCatalog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("q");
        String state = request.getParameter("state");
        String type = request.getParameter("type");
        String maxPriceStr = request.getParameter("maxPrice");

        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr.trim());
            } catch (NumberFormatException ignored) {
            }
        }

        List<Monument> monuments;
        boolean hasFilter = (query != null && !query.trim().isEmpty()) ||
                (state != null && !state.trim().isEmpty() && !"ALL".equalsIgnoreCase(state)) ||
                (type != null && !type.trim().isEmpty() && !"ALL".equalsIgnoreCase(type)) ||
                (maxPrice != null);

        if (hasFilter) {
            monuments = monumentDAO.searchAndFilter(query, state, type, maxPrice);
        } else {
            monuments = monumentDAO.getAllMonuments();
        }

        // ✅ YEH 1 LINE ADD KAREIN (2)
        for (Monument m : monuments) m.setImageUrl(fixImagePath(m.getImageUrl()));

        List<String> states = monumentDAO.getDistinctStates();
        List<String> types = monumentDAO.getDistinctTypes();

        request.setAttribute("monuments", monuments);
        request.setAttribute("states", states);
        request.setAttribute("types", types);
        request.setAttribute("paramQuery", query);
        request.setAttribute("paramState", state);
        request.setAttribute("paramType", type);
        request.setAttribute("paramMaxPrice", maxPriceStr);
        request.setAttribute("resultCount", monuments.size());

        request.getRequestDispatcher("/WEB-INF/views/monuments.jsp").forward(request, response);
    }

    private void handleMonumentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/monuments");
            return;
        }

        try {
            int mouId = Integer.parseInt(idStr.trim());
            Monument monument = monumentDAO.getMonumentById(mouId);

            if (monument == null) {
                request.setAttribute("errorMessage", "The requested monument was not found.");
                request.getRequestDispatcher("/WEB-INF/views/monuments.jsp").forward(request, response);
                return;
            }

            // ✅ YEH 1 LINE ADD KAREIN (3)
            monument.setImageUrl(fixImagePath(monument.getImageUrl()));

            request.setAttribute("monument", monument);
            request.getRequestDispatcher("/WEB-INF/views/monument-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/monuments");
        }
    }
}