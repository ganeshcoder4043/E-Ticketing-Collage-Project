package com.bharatdarshan.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * Database Connection Utility using standard JDBC DriverManager.
 * Reads connection settings dynamically from db.properties in the classpath.
 */
public class DBConnection {

    private static String url;
    private static String username;
    private static String password;
    private static String driver;

    static {
        loadProperties();
    }

    private static void loadProperties() {
        Properties props = new Properties();
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
                driver = props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                url = props.getProperty("db.url", "jdbc:mysql://localhost:3306/bharatdarshan_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
                username = props.getProperty("db.username", "root");
                password = props.getProperty("db.password", "root");
            } else {
                // Fallback defaults
                driver = "com.mysql.cj.jdbc.Driver";
                url = "jdbc:mysql://localhost:3306/bharatdarshan_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                username = "root";
                password = "root";
            }
            Class.forName(driver);
        } catch (Exception e) {
            System.err.println("[DBConnection] Failed to load db.properties or JDBC Driver: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Obtains a new database connection.
     * @return Connection object
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        try {
            if (driver != null) {
                Class.forName(driver);
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found: " + driver, e);
        }
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * Safely closes AutoCloseable database resources (Connection, Statement, ResultSet).
     * @param resources AutoCloseable items to close
     */
    public static void close(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            if (res != null) {
                try {
                    res.close();
                } catch (Exception ignored) {
                }
            }
        }
    }
}
