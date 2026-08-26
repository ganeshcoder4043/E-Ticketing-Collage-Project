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
 * Reads connection settings dynamically from environment variables (Render)
 * or db.properties (Local).
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
        // ✅ FIRST: Check Environment Variables (Render)
        String envUrl = System.getenv("DB_URL");
        String envUsername = System.getenv("DB_USERNAME");
        String envPassword = System.getenv("DB_PASSWORD");

        if (envUrl != null && envUsername != null && envPassword != null) {
            url = envUrl;
            username = envUsername;
            password = envPassword;
            driver = "com.mysql.cj.jdbc.Driver";
            System.out.println("✅ Using Render environment variables for database connection");
            return;
        }

        // Fallback: Load from db.properties (Local)
        Properties props = new Properties();
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
                driver = props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                url = props.getProperty("db.url", "jdbc:mysql://localhost:3306/bharatdarshan_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
                username = props.getProperty("db.username", "root");
                password = props.getProperty("db.password", "root");
                System.out.println("✅ Using local db.properties for database connection");
            } else {
                // Fallback defaults
                driver = "com.mysql.cj.jdbc.Driver";
                url = "jdbc:mysql://localhost:3306/bharatdarshan_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                username = "root";
                password = "root";
                System.out.println("⚠️ Using default database configuration");
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