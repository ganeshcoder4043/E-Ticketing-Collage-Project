package com.bharatdarshan.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Model class representing a User entity.
 * Corresponds to table `user`.
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String firstName;
    private String lastName;
    private String gender;
    private String email;
    private long contact;
    private Date dob;
    private Timestamp createdAt;

    public User() {
    }

    public User(int id, String firstName, String lastName, String gender, String email, long contact, Date dob) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.contact = contact;
        this.dob = dob;
    }

    public User(String firstName, String lastName, String gender, String email, long contact, Date dob) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.contact = contact;
        this.dob = dob;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFullName() {
        return (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public long getContact() {
        return contact;
    }

    public void setContact(long contact) {
        this.contact = contact;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", contact=" + contact +
                ", dob=" + dob +
                '}';
    }
}
