package com.bharatdarshan.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Model class representing transaction payment details.
 * Corresponds to table `payment_details`.
 */
public class PaymentDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    private int paymentId;
    private int paymentModeId;
    private String cardNumber; // Masked e.g. XXXX-XXXX-XXXX-1234
    private String cardHolderName;
    private String expiryDate;
    private String ccvNo;
    private String transactionStatus;
    private Timestamp paymentDate;

    public PaymentDetails() {
    }

    public PaymentDetails(int paymentId, int paymentModeId, String cardNumber, String cardHolderName, 
                          String expiryDate, String ccvNo, String transactionStatus, Timestamp paymentDate) {
        this.paymentId = paymentId;
        this.paymentModeId = paymentModeId;
        this.cardNumber = cardNumber;
        this.cardHolderName = cardHolderName;
        this.expiryDate = expiryDate;
        this.ccvNo = ccvNo;
        this.transactionStatus = transactionStatus;
        this.paymentDate = paymentDate;
    }

    public PaymentDetails(int paymentModeId, String cardNumber, String cardHolderName, 
                          String expiryDate, String ccvNo, String transactionStatus) {
        this.paymentModeId = paymentModeId;
        this.cardNumber = cardNumber;
        this.cardHolderName = cardHolderName;
        this.expiryDate = expiryDate;
        this.ccvNo = ccvNo;
        this.transactionStatus = transactionStatus;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getPaymentModeId() {
        return paymentModeId;
    }

    public void setPaymentModeId(int paymentModeId) {
        this.paymentModeId = paymentModeId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardHolderName() {
        return cardHolderName;
    }

    public void setCardHolderName(String cardHolderName) {
        this.cardHolderName = cardHolderName;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCcvNo() {
        return ccvNo;
    }

    public void setCcvNo(String ccvNo) {
        this.ccvNo = ccvNo;
    }

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    @Override
    public String toString() {
        return "PaymentDetails{" +
                "paymentId=" + paymentId +
                ", paymentModeId=" + paymentModeId +
                ", cardNumber='" + cardNumber + '\'' +
                ", transactionStatus='" + transactionStatus + '\'' +
                '}';
    }
}
