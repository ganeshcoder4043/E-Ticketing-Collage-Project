package com.bharatdarshan.dao;

import com.bharatdarshan.model.Monument;
import com.bharatdarshan.model.PaymentDetails;
import com.bharatdarshan.model.PaymentMode;
import com.bharatdarshan.model.TourBooking;
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
 * Data Access Object for Tour Booking reservations.
 */
public class BookingDAO {

    /**
     * Creates a new booking record in `tour_booking_details`.
     * @param booking TourBooking object
     * @return Generated booking_id or -1 on failure
     */
    public int createBooking(TourBooking booking) {
        String sql = "INSERT INTO `tour_booking_details` " +
                     "(user_id, mou_id, session_id, child, adult, tour_date, departure_time, total_amount, " +
                     "booking_remarks, status, cancel_request, contact_person_details, terms) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rsKeys = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getMouId());
            ps.setString(3, booking.getSessionId());
            ps.setInt(4, booking.getChild());
            ps.setInt(5, booking.getAdult());
            ps.setDate(6, booking.getTourDate());
            ps.setString(7, booking.getDepartureTime());
            ps.setBigDecimal(8, booking.getTotalAmount());
            ps.setString(9, booking.getBookingRemarks() != null ? booking.getBookingRemarks() : "Confirmed E-Ticket");
            ps.setInt(10, booking.getStatus() > 0 ? booking.getStatus() : 1);
            ps.setInt(11, booking.getCancelRequest());
            ps.setString(12, booking.getContactPersonDetails());
            ps.setString(13, booking.getTerms() != null ? booking.getTerms() : "Accepted ASI Guidelines");

            int affected = ps.executeUpdate();
            if (affected > 0) {
                rsKeys = ps.getGeneratedKeys();
                if (rsKeys.next()) {
                    return rsKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("[BookingDAO] Error creating booking: " + e.getMessage());
        } finally {
            DBConnection.close(rsKeys, ps, conn);
        }
        return -1;
    }

    /**
     * Retrieves full booking details by ID including joined Monument, User, and Payment info.
     */
    public TourBooking getBookingById(int bookingId) {
        String sql = "SELECT b.*, " +
                     "m.name AS mou_name, m.location AS mou_location, m.type AS mou_type, m.fare AS mou_fare, " +
                     "m.child_fare AS mou_child_fare, m.city AS mou_city, m.state AS mou_state, m.timings AS mou_timings, m.image_url AS mou_image, " +
                     "u.first_name, u.last_name, u.email, u.contact " +
                     "FROM `tour_booking_details` b " +
                     "JOIN `monument` m ON b.mou_id = m.mou_id " +
                     "JOIN `user` u ON b.user_id = u.id " +
                     "WHERE b.booking_id = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bookingId);
            rs = ps.executeQuery();
            if (rs.next()) {
                TourBooking booking = mapResultSetToBooking(rs);

                // Monument details
                Monument m = new Monument();
                m.setMouId(rs.getInt("mou_id"));
                m.setName(rs.getString("mou_name"));
                m.setLocation(rs.getString("mou_location"));
                m.setType(rs.getString("mou_type"));
                m.setFare(rs.getBigDecimal("mou_fare"));
                m.setChildFare(rs.getBigDecimal("mou_child_fare"));
                m.setCity(rs.getString("mou_city"));
                m.setState(rs.getString("mou_state"));
                m.setTimings(rs.getString("mou_timings"));
                m.setImageUrl(rs.getString("mou_image"));
                booking.setMonument(m);

                // User details
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setFirstName(rs.getString("first_name"));
                u.setLastName(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setContact(rs.getLong("contact"));
                booking.setUser(u);

                // Load payment info if exists
                PaymentDAO paymentDAO = new PaymentDAO();
                PaymentMode pm = paymentDAO.getPaymentModeByBookingId(bookingId);
                if (pm != null) {
                    booking.setPaymentMode(pm);
                    PaymentDetails pd = paymentDAO.getPaymentDetailsByPaymentModeId(pm.getPaymentModeId());
                    booking.setPaymentDetails(pd);
                }

                return booking;
            }
        } catch (SQLException e) {
            System.err.println("[BookingDAO] Error getting booking by ID: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Retrieves all bookings made by a specific user.
     */
    public List<TourBooking> getBookingsByUserId(int userId) {
        List<TourBooking> list = new ArrayList<>();
        String sql = "SELECT b.*, " +
                     "m.name AS mou_name, m.location AS mou_location, m.type AS mou_type, m.fare AS mou_fare, " +
                     "m.city AS mou_city, m.state AS mou_state, m.image_url AS mou_image " +
                     "FROM `tour_booking_details` b " +
                     "JOIN `monument` m ON b.mou_id = m.mou_id " +
                     "WHERE b.user_id = ? " +
                     "ORDER BY b.booking_date DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                TourBooking booking = mapResultSetToBooking(rs);

                Monument m = new Monument();
                m.setMouId(rs.getInt("mou_id"));
                m.setName(rs.getString("mou_name"));
                m.setLocation(rs.getString("mou_location"));
                m.setType(rs.getString("mou_type"));
                m.setFare(rs.getBigDecimal("mou_fare"));
                m.setCity(rs.getString("mou_city"));
                m.setState(rs.getString("mou_state"));
                m.setImageUrl(rs.getString("mou_image"));
                booking.setMonument(m);

                list.add(booking);
            }
        } catch (SQLException e) {
            System.err.println("[BookingDAO] Error fetching user bookings: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Updates booking status (e.g. Cancelled).
     */
    public boolean updateBookingStatus(int bookingId, int status, int cancelRequest) {
        String sql = "UPDATE `tour_booking_details` SET status = ?, cancel_request = ?, booking_remarks = 'Cancelled' WHERE booking_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, cancelRequest);
            ps.setInt(3, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[BookingDAO] Error updating booking status: " + e.getMessage());
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    private TourBooking mapResultSetToBooking(ResultSet rs) throws SQLException {
        TourBooking booking = new TourBooking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setMouId(rs.getInt("mou_id"));
        booking.setSessionId(rs.getString("session_id"));
        booking.setChild(rs.getInt("child"));
        booking.setAdult(rs.getInt("adult"));
        booking.setTourDate(rs.getDate("tour_date"));
        booking.setDepartureTime(rs.getString("departure_time"));
        booking.setTotalAmount(rs.getBigDecimal("total_amount"));
        booking.setBookingRemarks(rs.getString("booking_remarks"));
        booking.setStatus(rs.getInt("status"));
        booking.setCancelRequest(rs.getInt("cancel_request"));
        booking.setContactPersonDetails(rs.getString("contact_person_details"));
        booking.setTerms(rs.getString("terms"));
        booking.setBookingDate(rs.getTimestamp("booking_date"));
        return booking;
    }
}
