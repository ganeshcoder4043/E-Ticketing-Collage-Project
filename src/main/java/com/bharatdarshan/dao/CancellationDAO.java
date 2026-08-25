package com.bharatdarshan.dao;

import com.bharatdarshan.model.BookingCancellation;
import com.bharatdarshan.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Ticket Cancellations and refund processing.
 */
public class CancellationDAO {

    /**
     * Records a ticket cancellation and updates booking status in an atomic transaction.
     * @param cancellation Cancellation details with calculated deduction & refund amounts
     * @return Generated ticket_cancel_id or -1 on failure
     */
    public int processCancellation(BookingCancellation cancellation) {
        String insertSql = "INSERT INTO `booking_cancellation` " +
                           "(ticket_id, user_id, cancel_date, cancel_reason, deducted_amount, refund_amount) " +
                           "VALUES (?, ?, ?, ?, ?, ?)";
        String updateBookingSql = "UPDATE `tour_booking_details` SET status = 2, cancel_request = 2, booking_remarks = 'Cancelled by User' WHERE booking_id = ?";

        Connection conn = null;
        PreparedStatement psInsert = null;
        PreparedStatement psUpdate = null;
        ResultSet rsKeys = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1. Insert cancellation record
            psInsert = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            psInsert.setInt(1, cancellation.getTicketId());
            psInsert.setInt(2, cancellation.getUserId());
            psInsert.setDate(3, cancellation.getCancelDate());
            psInsert.setString(4, cancellation.getCancelReason());
            psInsert.setBigDecimal(5, cancellation.getDeductedAmount());
            psInsert.setBigDecimal(6, cancellation.getRefundAmount());
            psInsert.executeUpdate();

            rsKeys = psInsert.getGeneratedKeys();
            int cancelId = -1;
            if (rsKeys.next()) {
                cancelId = rsKeys.getInt(1);
            } else {
                conn.rollback();
                return -1;
            }

            // 2. Update booking status
            psUpdate = conn.prepareStatement(updateBookingSql);
            psUpdate.setInt(1, cancellation.getTicketId());
            psUpdate.executeUpdate();

            conn.commit();
            return cancelId;

        } catch (SQLException e) {
            System.err.println("[CancellationDAO] Error processing cancellation: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return -1;
        } finally {
            DBConnection.close(rsKeys, psInsert, psUpdate, conn);
        }
    }

    /**
     * Retrieves cancellation record for a specific ticket.
     */
    public BookingCancellation getCancellationByTicketId(int ticketId) {
        String sql = "SELECT * FROM `booking_cancellation` WHERE ticket_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, ticketId);
            rs = ps.executeQuery();
            if (rs.next()) {
                BookingCancellation c = new BookingCancellation();
                c.setTicketCancelId(rs.getInt("ticket_cancel_id"));
                c.setTicketId(rs.getInt("ticket_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setCancelDate(rs.getDate("cancel_date"));
                c.setCancelReason(rs.getString("cancel_reason"));
                c.setDeductedAmount(rs.getBigDecimal("deducted_amount"));
                c.setRefundAmount(rs.getBigDecimal("refund_amount"));
                return c;
            }
        } catch (SQLException e) {
            System.err.println("[CancellationDAO] Error getting cancellation by ticket ID: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Retrieves all cancellations made by a specific user.
     */
    public List<BookingCancellation> getCancellationsByUserId(int userId) {
        List<BookingCancellation> list = new ArrayList<>();
        String sql = "SELECT * FROM `booking_cancellation` WHERE user_id = ? ORDER BY cancel_date DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                BookingCancellation c = new BookingCancellation();
                c.setTicketCancelId(rs.getInt("ticket_cancel_id"));
                c.setTicketId(rs.getInt("ticket_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setCancelDate(rs.getDate("cancel_date"));
                c.setCancelReason(rs.getString("cancel_reason"));
                c.setDeductedAmount(rs.getBigDecimal("deducted_amount"));
                c.setRefundAmount(rs.getBigDecimal("refund_amount"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println("[CancellationDAO] Error fetching user cancellations: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }
}
