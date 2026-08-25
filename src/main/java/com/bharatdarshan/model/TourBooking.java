package com.bharatdarshan.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Model class representing a Ticket Booking reservation.
 * Corresponds to table `tour_booking_details`.
 */
public class TourBooking implements Serializable {
    private static final long serialVersionUID = 1L;

    private int bookingId;
    private int userId;
    private int mouId;
    private String sessionId;
    private int child;
    private int adult;
    private Date tourDate;
    private String departureTime;
    private BigDecimal totalAmount;
    private String bookingRemarks;
    private int status; // 1: Active/Confirmed, 2: Cancelled, 3: Completed
    private int cancelRequest; // 0: No, 1: Requested, 2: Cancelled
    private String contactPersonDetails;
    private String terms;
    private Timestamp bookingDate;

    // Joined Monument & Payment details for convenience in views
    private Monument monument;
    private PaymentMode paymentMode;
    private PaymentDetails paymentDetails;
    private User user;

    public TourBooking() {
    }

    public TourBooking(int bookingId, int userId, int mouId, String sessionId, int child, int adult, 
                       Date tourDate, String departureTime, BigDecimal totalAmount, String bookingRemarks, 
                       int status, int cancelRequest, String contactPersonDetails, String terms, 
                       Timestamp bookingDate) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.mouId = mouId;
        this.sessionId = sessionId;
        this.child = child;
        this.adult = adult;
        this.tourDate = tourDate;
        this.departureTime = departureTime;
        this.totalAmount = totalAmount;
        this.bookingRemarks = bookingRemarks;
        this.status = status;
        this.cancelRequest = cancelRequest;
        this.contactPersonDetails = contactPersonDetails;
        this.terms = terms;
        this.bookingDate = bookingDate;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMouId() {
        return mouId;
    }

    public void setMouId(int mouId) {
        this.mouId = mouId;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public int getChild() {
        return child;
    }

    public void setChild(int child) {
        this.child = child;
    }

    public int getAdult() {
        return adult;
    }

    public void setAdult(int adult) {
        this.adult = adult;
    }

    public int getTotalTickets() {
        return adult + child;
    }

    public Date getTourDate() {
        return tourDate;
    }

    public void setTourDate(Date tourDate) {
        this.tourDate = tourDate;
    }

    public String getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(String departureTime) {
        this.departureTime = departureTime;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getBookingRemarks() {
        return bookingRemarks;
    }

    public void setBookingRemarks(String bookingRemarks) {
        this.bookingRemarks = bookingRemarks;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatusDescription() {
        if (status == 1) return "CONFIRMED";
        if (status == 2) return "CANCELLED";
        if (status == 3) return "COMPLETED";
        return "UNKNOWN";
    }

    public int getCancelRequest() {
        return cancelRequest;
    }

    public void setCancelRequest(int cancelRequest) {
        this.cancelRequest = cancelRequest;
    }

    public String getContactPersonDetails() {
        return contactPersonDetails;
    }

    public void setContactPersonDetails(String contactPersonDetails) {
        this.contactPersonDetails = contactPersonDetails;
    }

    public String getTerms() {
        return terms;
    }

    public void setTerms(String terms) {
        this.terms = terms;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Monument getMonument() {
        return monument;
    }

    public void setMonument(Monument monument) {
        this.monument = monument;
    }

    public PaymentMode getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(PaymentMode paymentMode) {
        this.paymentMode = paymentMode;
    }

    public PaymentDetails getPaymentDetails() {
        return paymentDetails;
    }

    public void setPaymentDetails(PaymentDetails paymentDetails) {
        this.paymentDetails = paymentDetails;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "TourBooking{" +
                "bookingId=" + bookingId +
                ", userId=" + userId +
                ", mouId=" + mouId +
                ", tourDate=" + tourDate +
                ", totalAmount=" + totalAmount +
                ", status=" + status +
                '}';
    }
}
