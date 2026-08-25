package com.bharatdarshan.dao;

import com.bharatdarshan.model.Monument;
import com.bharatdarshan.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Monument operations.
 * Implements pure JDBC querying and multi-criteria search/filtering.
 */
public class MonumentDAO {

    /**
     * Maps current ResultSet row to a Monument object.
     */
    private Monument mapResultSetToMonument(ResultSet rs) throws SQLException {
        Monument monument = new Monument();
        monument.setMouId(rs.getInt("mou_id"));
        monument.setName(rs.getString("name"));
        monument.setLocation(rs.getString("location"));
        monument.setType(rs.getString("type"));
        monument.setFare(rs.getBigDecimal("fare"));
        monument.setChildFare(rs.getBigDecimal("child_fare"));
        monument.setSpecification(rs.getString("specification"));
        monument.setContact(rs.getLong("contact"));
        monument.setTimings(rs.getString("timings"));
        monument.setCity(rs.getString("city"));
        monument.setState(rs.getString("state"));
        monument.setImageUrl(rs.getString("image_url"));
        monument.setDescription(rs.getString("description"));
        return monument;
    }

    /**
     * Retrieves all monuments from the database.
     */
    public List<Monument> getAllMonuments() {
        List<Monument> list = new ArrayList<>();
        String sql = "SELECT * FROM `monument` ORDER BY name ASC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToMonument(rs));
            }
        } catch (SQLException e) {
            System.err.println("[MonumentDAO] Error fetching all monuments: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Retrieves a single monument by its ID.
     */
    public Monument getMonumentById(int mouId) {
        String sql = "SELECT * FROM `monument` WHERE mou_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, mouId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToMonument(rs);
            }
        } catch (SQLException e) {
            System.err.println("[MonumentDAO] Error getting monument by ID: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Retrieves featured monuments for the home page.
     */
    public List<Monument> getFeaturedMonuments(int limit) {
        List<Monument> list = new ArrayList<>();
        String sql = "SELECT * FROM `monument` ORDER BY mou_id ASC LIMIT ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToMonument(rs));
            }
        } catch (SQLException e) {
            System.err.println("[MonumentDAO] Error fetching featured monuments: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Multi-criteria search and filter method.
     * @param query Free text search (name, location, city, state, description)
     * @param state State filter (optional)
     * @param type Monument type/category filter (optional)
     * @param maxPrice Maximum fare filter (optional)
     * @return List of matching monuments
     */
    public List<Monument> searchAndFilter(String query, String state, String type, Double maxPrice) {
        List<Monument> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM `monument` WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (LOWER(name) LIKE ? OR LOWER(location) LIKE ? OR LOWER(city) LIKE ? OR LOWER(state) LIKE ? OR LOWER(specification) LIKE ?) ");
            String wild = "%" + query.trim().toLowerCase() + "%";
            params.add(wild);
            params.add(wild);
            params.add(wild);
            params.add(wild);
            params.add(wild);
        }

        if (state != null && !state.trim().isEmpty() && !"ALL".equalsIgnoreCase(state.trim())) {
            sql.append("AND state = ? ");
            params.add(state.trim());
        }

        if (type != null && !type.trim().isEmpty() && !"ALL".equalsIgnoreCase(type.trim())) {
            sql.append("AND type = ? ");
            params.add(type.trim());
        }

        if (maxPrice != null && maxPrice > 0) {
            sql.append("AND fare <= ? ");
            params.add(BigDecimal.valueOf(maxPrice));
        }

        sql.append("ORDER BY name ASC");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToMonument(rs));
            }
        } catch (SQLException e) {
            System.err.println("[MonumentDAO] Error filtering monuments: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Gets all distinct states where monuments are located.
     */
    public List<String> getDistinctStates() {
        List<String> states = new ArrayList<>();
        String sql = "SELECT DISTINCT state FROM `monument` WHERE state IS NOT NULL AND state <> '' ORDER BY state ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                states.add(rs.getString("state"));
            }
        } catch (SQLException e) {
            System.err.println("[MonumentDAO] Error fetching states: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return states;
    }

    /**
     * Gets all distinct monument types.
     */
    public List<String> getDistinctTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT type FROM `monument` WHERE type IS NOT NULL AND type <> '' ORDER BY type ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                types.add(rs.getString("type"));
            }
        } catch (SQLException e) {
            System.err.println("[MonumentDAO] Error fetching types: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return types;
    }

    // MonumentDAO.java mein yeh method add karein

    /**
     * Get total monument count (for admin dashboard)
     */
    public int getMonumentCount() {
        String sql = "SELECT COUNT(*) FROM monument";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("[MonumentDAO] Error getting monument count: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return 0;
    }
}
