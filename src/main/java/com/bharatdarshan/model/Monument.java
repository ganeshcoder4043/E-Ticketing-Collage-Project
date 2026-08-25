package com.bharatdarshan.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Model class representing an ASI Protected Monument.
 * Corresponds to table `monument`.
 */
public class Monument implements Serializable {
    private static final long serialVersionUID = 1L;

    private int mouId;
    private String name;
    private String location;
    private String type;
    private BigDecimal fare;
    private BigDecimal childFare;
    private String specification;
    private long contact;
    private String timings;
    private String city;
    private String state;
    private String imageUrl;
    private String description;

    public Monument() {
    }

    public Monument(int mouId, String name, String location, String type, BigDecimal fare, BigDecimal childFare,
                    String specification, long contact, String timings, String city, String state, 
                    String imageUrl, String description) {
        this.mouId = mouId;
        this.name = name;
        this.location = location;
        this.type = type;
        this.fare = fare;
        this.childFare = childFare;
        this.specification = specification;
        this.contact = contact;
        this.timings = timings;
        this.city = city;
        this.state = state;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    public int getMouId() {
        return mouId;
    }

    public void setMouId(int mouId) {
        this.mouId = mouId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getFare() {
        return fare;
    }

    public void setFare(BigDecimal fare) {
        this.fare = fare;
    }

    public BigDecimal getChildFare() {
        return childFare;
    }

    public void setChildFare(BigDecimal childFare) {
        this.childFare = childFare;
    }

    public String getSpecification() {
        return specification;
    }

    public void setSpecification(String specification) {
        this.specification = specification;
    }

    public long getContact() {
        return contact;
    }

    public void setContact(long contact) {
        this.contact = contact;
    }

    public String getTimings() {
        return timings;
    }

    public void setTimings(String timings) {
        this.timings = timings;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Monument{" +
                "mouId=" + mouId +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                ", type='" + type + '\'' +
                ", fare=" + fare +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                '}';
    }
}
