package com.bharatdarshan.model;

import java.io.Serializable;

/**
 * Model class representing Payment Mode.
 * Corresponds to table `payment_mode`.
 */
public class PaymentMode implements Serializable {
    private static final long serialVersionUID = 1L;

    private int paymentModeId;
    private int bookingId;
    private String mode; // 'CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'NET_BANKING'

    public PaymentMode() {
    }

    public PaymentMode(int paymentModeId, int bookingId, String mode) {
        this.paymentModeId = paymentModeId;
        this.bookingId = bookingId;
        this.mode = mode;
    }

    public PaymentMode(int bookingId, String mode) {
        this.bookingId = bookingId;
        this.mode = mode;
    }

    public int getPaymentModeId() {
        return paymentModeId;
    }

    public void setPaymentModeId(int paymentModeId) {
        this.paymentModeId = paymentModeId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getFormattedMode() {
        if (mode == null) return "Unknown";
        switch (mode) {
            case "CREDIT_CARD": return "Credit Card";
            case "DEBIT_CARD": return "Debit Card";
            case "NET_BANKING": return "Net Banking";
            case "CASH": return "Cash Counter / UPI";
            default: return mode;
        }
    }

    @Override
    public String toString() {
        return "PaymentMode{" +
                "paymentModeId=" + paymentModeId +
                ", bookingId=" + bookingId +
                ", mode='" + mode + '\'' +
                '}';
    }
}
