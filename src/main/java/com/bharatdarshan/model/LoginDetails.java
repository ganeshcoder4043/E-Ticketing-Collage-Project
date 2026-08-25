package com.bharatdarshan.model;

import java.io.Serializable;

/**
 * Model class representing authentication credentials.
 * Corresponds to table `login_details`.
 */
public class LoginDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId;
    private String email;
    private String password;
    private boolean forgotPasswordFlag;

    public LoginDetails() {
    }

    public LoginDetails(int userId, String email, String password, boolean forgotPasswordFlag) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.forgotPasswordFlag = forgotPasswordFlag;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isForgotPasswordFlag() {
        return forgotPasswordFlag;
    }

    public void setForgotPasswordFlag(boolean forgotPasswordFlag) {
        this.forgotPasswordFlag = forgotPasswordFlag;
    }

    @Override
    public String toString() {
        return "LoginDetails{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", forgotPasswordFlag=" + forgotPasswordFlag +
                '}';
    }
}
