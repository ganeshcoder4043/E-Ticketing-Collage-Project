package com.bharatdarshan.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

/**
 * Model class representing a ticket cancellation record.
 * Corresponds to table `booking_cancellation`.
 */
public class BookingCancellation implements Serializable {
    private static final long serialVersionUID = 1L;

    private int ticketCancelId;
    private int ticketId;
    private int userId;
    private Date cancelDate;
    private String cancelReason;
    private BigDecimal deductedAmount;
    private BigDecimal refundAmount;

    // Joined object references
    private TourBooking booking;

    public BookingCancellation() {
    }

    public BookingCancellation(int ticketCancelId, int ticketId, int userId, Date cancelDate, 
                               String cancelReason, BigDecimal deductedAmount, BigDecimal refundAmount) {
        this.ticketCancelId = ticketCancelId;
        this.ticketId = ticketId;
        this.userId = userId;
        this.cancelDate = cancelDate;
        this.cancelReason = cancelReason;
        this.deductedAmount = deductedAmount;
        this.refundAmount = refundAmount;
    }

    public BookingCancellation(int ticketId, int userId, Date cancelDate, 
                               String cancelReason, BigDecimal deductedAmount, BigDecimal refundAmount) {
        this.ticketId = ticketId;
        this.userId = userId;
        this.cancelDate = cancelDate;
        this.cancelReason = cancelReason;
        this.deductedAmount = deductedAmount;
        this.refundAmount = refundAmount;
    }

    public int getTicketCancelId() {
        return ticketCancelId;
    }

    public void setTicketCancelId(int ticketCancelId) {
        this.ticketCancelId = ticketCancelId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getCancelDate() {
        return cancelDate;
    }

    public void setCancelDate(Date cancelDate) {
        this.cancelDate = cancelDate;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public BigDecimal getDeductedAmount() {
        return deductedAmount;
    }

    public void setDeductedAmount(BigDecimal deductedAmount) {
        this.deductedAmount = deductedAmount;
    }

    public BigDecimal getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(BigDecimal refundAmount) {
        this.refundAmount = refundAmount;
    }

    public TourBooking getBooking() {
        return booking;
    }

    public void setBooking(TourBooking booking) {
        this.booking = booking;
    }

    @Override
    public String toString() {
        return "BookingCancellation{" +
                "ticketCancelId=" + ticketCancelId +
                ", ticketId=" + ticketId +
                ", cancelDate=" + cancelDate +
                ", deductedAmount=" + deductedAmount +
                ", refundAmount=" + refundAmount +
                '}';
    }
}
