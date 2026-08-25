package com.bharatdarshan.dao;

import com.bharatdarshan.model.User;
import com.bharatdarshan.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User and LoginDetails operations.
 * Implements pure JDBC with PreparedStatements and transaction management.
 */
public class UserDAO {

    /**
     * Registers a new user and creates their login credentials atomically.
     * @param user User profile details
     * @param password Plaintext password
     * @return Generated User ID if successful, or -1 on failure
     */
    public int registerUser(User user, String password) {
        String insertUserSql = "INSERT INTO `user` (first_name, last_name, gender, email, contact, dob) VALUES (?, ?, ?, ?, ?, ?)";
        String insertLoginSql = "INSERT INTO `login_details` (user_id, email, password, forgot_password_flag) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psLogin = null;
        ResultSet rsKeys = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Begin transaction

            psUser = conn.prepareStatement(insertUserSql, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getFirstName());
            psUser.setString(2, user.getLastName());
            psUser.setString(3, user.getGender());
            psUser.setString(4, user.getEmail().trim().toLowerCase());
            psUser.setLong(5, user.getContact());
            psUser.setDate(6, user.getDob());

            int affectedRows = psUser.executeUpdate();
            if (affectedRows == 0) {
                conn.rollback();
                return -1;
            }

            rsKeys = psUser.getGeneratedKeys();
            int userId = -1;
            if (rsKeys.next()) {
                userId = rsKeys.getInt(1);
            } else {
                conn.rollback();
                return -1;
            }

            psLogin = conn.prepareStatement(insertLoginSql);
            psLogin.setInt(1, userId);
            psLogin.setString(2, user.getEmail().trim().toLowerCase());
            psLogin.setString(3, password);
            psLogin.setBoolean(4, false);
            psLogin.executeUpdate();

            conn.commit(); // Commit transaction
            return userId;

        } catch (SQLException e) {
            System.err.println("[UserDAO] Error registering user: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return -1;
        } finally {
            DBConnection.close(rsKeys, psUser, psLogin, conn);
        }
    }

    /**
     * Authenticates user against credentials.
     * @param email User email
     * @param password Password
     * @return User object on success, or null on invalid credentials
     */
    public User validateLogin(String email, String password) {
        String sql = "SELECT u.id, u.first_name, u.last_name, u.gender, u.email, u.contact, u.dob, u.created_at " +
                     "FROM `user` u " +
                     "JOIN `login_details` l ON u.id = l.user_id " +
                     "WHERE LOWER(u.email) = ? AND l.password = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim().toLowerCase());
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                user.setContact(rs.getLong("contact"));
                user.setDob(rs.getDate("dob"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error during login validation: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Retrieves user by ID.
     */
    public User getUserById(int id) {
        String sql = "SELECT id, first_name, last_name, gender, email, contact, dob, created_at FROM `user` WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                user.setContact(rs.getLong("contact"));
                user.setDob(rs.getDate("dob"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error getting user by ID: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Checks if an email is already registered in the system.
     */
    public boolean isEmailRegistered(String email) {
        String sql = "SELECT id FROM `user` WHERE LOWER(email) = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim().toLowerCase());
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error checking email uniqueness: " + e.getMessage());
            return false;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    /**
     * Updates user password.
     */
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE `login_details` l " +
                     "JOIN `user` u ON l.user_id = u.id " +
                     "SET l.password = ?, l.forgot_password_flag = FALSE " +
                     "WHERE LOWER(u.email) = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email.trim().toLowerCase());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error updating password: " + e.getMessage());
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    // UserDAO.java mein yeh method add karein

    /**
     * Updates user profile details.
     * @param user User object with updated details
     * @return true if update successful, false otherwise
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE `user` SET first_name = ?, last_name = ?, gender = ?, email = ?, contact = ?, dob = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getGender());
            ps.setString(4, user.getEmail());
            ps.setLong(5, user.getContact());
            ps.setDate(6, user.getDob());
            ps.setInt(7, user.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error updating user: " + e.getMessage());
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Updates user password.
     * @param userId User ID
     * @param newPassword New password
     * @return true if update successful, false otherwise
     */
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE `login_details` SET password = ? WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error updating password: " + e.getMessage());
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Get user's current password for verification
     */
    public String getPasswordByUserId(int userId) {
        String sql = "SELECT password FROM `login_details` WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("password");
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error getting password: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    // ✅ Add these methods to UserDAO.java

    /**
     * Get all users (for admin panel)
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM `user` ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error fetching all users: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return users;
    }

    /**
     * Search users by name or email
     */
    public List<User> searchUsers(String keyword) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM `user` WHERE LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(email) LIKE ? ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            String searchTerm = "%" + keyword.toLowerCase() + "%";
            ps.setString(1, searchTerm);
            ps.setString(2, searchTerm);
            ps.setString(3, searchTerm);
            rs = ps.executeQuery();
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error searching users: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return users;
    }

    /**
     * Get user count
     */
    public int getUserCount() {
        String sql = "SELECT COUNT(*) FROM `user`";
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
            System.err.println("[UserDAO] Error getting user count: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return 0;
    }

    /**
     * Update user role (admin/user)
     */
    public boolean updateUserRole(int userId, String role) {
        String sql = "UPDATE `user` SET role = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, role);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[UserDAO] Error updating user role: " + e.getMessage());
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Map ResultSet to User object
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setGender(rs.getString("gender"));
        user.setEmail(rs.getString("email"));
        user.setContact(rs.getLong("contact"));
        user.setDob(rs.getDate("dob"));
        user.setCreatedAt(rs.getTimestamp("created_at"));

        // ✅ Add role mapping
        try {
            user.setRole(rs.getString("role"));
        } catch (SQLException e) {
            user.setRole("user"); // default if column doesn't exist
        }

        return user;
    }
}
