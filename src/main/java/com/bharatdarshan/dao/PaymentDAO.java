package com.bharatdarshan.dao;

import com.bharatdarshan.model.PaymentDetails;
import com.bharatdarshan.model.PaymentMode;
import com.bharatdarshan.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Data Access Object for Payment operations.
 * Handles payment modes and transaction details.
 */
public class PaymentDAO {

    /**
     * Records payment mode and payment transaction details atomically.
     * @param bookingId Linked booking ID
     * @param mode Payment mode string (CREDIT_CARD, DEBIT_CARD, NET_BANKING, CASH)
     * @param details Card/Transaction details (can be null/empty for Cash/NetBanking)
     * @return payment_id generated or -1 on failure
     */
    public int processPayment(int bookingId, String mode, PaymentDetails details) {
        String insertModeSql = "INSERT INTO `payment_mode` (booking_id, mode) VALUES (?, ?)";
        String insertDetailsSql = "INSERT INTO `payment_details` (payment_mode_id, card_number, card_holder_name, expiry_date, ccv_no, transaction_status) VALUES (?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement psMode = null;
        PreparedStatement psDetails = null;
        ResultSet rsKeysMode = null;
        ResultSet rsKeysDetails = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            psMode = conn.prepareStatement(insertModeSql, Statement.RETURN_GENERATED_KEYS);
            psMode.setInt(1, bookingId);
            psMode.setString(2, mode);
            psMode.executeUpdate();

            rsKeysMode = psMode.getGeneratedKeys();
            int paymentModeId = -1;
            if (rsKeysMode.next()) {
                paymentModeId = rsKeysMode.getInt(1);
            } else {
                conn.rollback();
                return -1;
            }

            psDetails = conn.prepareStatement(insertDetailsSql, Statement.RETURN_GENERATED_KEYS);
            psDetails.setInt(1, paymentModeId);

            if (details != null) {
                psDetails.setString(2, details.getCardNumber());
                psDetails.setString(3, details.getCardHolderName());
                psDetails.setString(4, details.getExpiryDate());
                psDetails.setString(5, details.getCcvNo());
                psDetails.setString(6, details.getTransactionStatus() != null ? details.getTransactionStatus() : "SUCCESS");
            } else {
                psDetails.setString(2, "N/A");
                psDetails.setString(3, "N/A");
                psDetails.setString(4, "N/A");
                psDetails.setString(5, "N/A");
                psDetails.setString(6, "SUCCESS");
            }
            psDetails.executeUpdate();

            rsKeysDetails = psDetails.getGeneratedKeys();
            int paymentId = -1;
            if (rsKeysDetails.next()) {
                paymentId = rsKeysDetails.getInt(1);
            }

            conn.commit();
            return paymentId;

        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error recording payment: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return -1;
        } finally {
            DBConnection.close(rsKeysDetails, rsKeysMode, psDetails, psMode, conn);
        }
    }

    /**
     * Gets PaymentMode by Booking ID.
     */
    public PaymentMode getPaymentModeByBookingId(int bookingId) {
        String sql = "SELECT payment_mode_id, booking_id, mode FROM `payment_mode` WHERE booking_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new PaymentMode(
                        rs.getInt("payment_mode_id"),
                        rs.getInt("booking_id"),
                        rs.getString("mode")
                );
            }
        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error fetching payment mode: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Gets PaymentDetails by Payment Mode ID.
     */
    public PaymentDetails getPaymentDetailsByPaymentModeId(int paymentModeId) {
        String sql = "SELECT * FROM `payment_details` WHERE payment_mode_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, paymentModeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new PaymentDetails(
                        rs.getInt("payment_id"),
                        rs.getInt("payment_mode_id"),
                        rs.getString("card_number"),
                        rs.getString("card_holder_name"),
                        rs.getString("expiry_date"),
                        rs.getString("ccv_no"),
                        rs.getString("transaction_status"),
                        rs.getTimestamp("payment_date")
                );
            }
        } catch (SQLException e) {
            System.err.println("[PaymentDAO] Error fetching payment details: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }
}
