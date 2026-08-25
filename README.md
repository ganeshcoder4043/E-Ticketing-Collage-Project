# BharatDarshan – ASI Monument E-Ticketing Web Portal

## 1. Project Overview

BharatDarshan is a web-based E-Ticketing and Visitor Management System developed for the Archaeological Survey of India (ASI). The application enables users to browse monuments, book tickets online, make payments, download e-tickets, and manage bookings. The system helps reduce long queues and promotes digital tourism services.

### Objectives
- Provide online ticket booking for monuments.
- Reduce manual ticketing processes.
- Improve visitor experience.
- Support Digital India initiatives.
- Maintain booking and payment records efficiently.

---

## 2. Features

### User Features
- User Registration & Login
- Browse Monuments
- Search & Filter Monuments
- View Monument Details
- Online Ticket Booking
- Multiple Payment Options
- Download E-Ticket
- View Booking History
- Cancel Bookings
- Profile Management

### Admin Features
- Admin Dashboard
- User Management
- Monument Management
- Booking Monitoring
- Email Notifications
- Reports & Statistics

---

## 3. Technology Stack

| Layer | Technology |
|---------|------------|
| Frontend | HTML5, CSS3, JSP |
| Backend | Java, Servlets |
| Database | MySQL |
| Server | Apache Tomcat |
| Build Tool | Maven |
| IDE | Eclipse / IntelliJ IDEA |
| Version Control | Git & GitHub |

---

## 4. MVC Architecture

The application follows the Model-View-Controller (MVC) architecture.

### Model Layer
Contains:
- Java POJO Classes
- DAO Classes
- Database Connectivity Classes

Examples:
- User.java
- Monument.java
- Booking.java
- Payment.java

### View Layer
Contains JSP pages for displaying data.

Examples:
- home.jsp
- login.jsp
- register.jsp
- monument.jsp
- booking.jsp
- payment.jsp

### Controller Layer
Contains Servlets that process requests and responses.

Examples:
- HomeServlet
- LoginServlet
- BookingServlet
- PaymentServlet
- AdminServlet

### MVC Flow

Browser → JSP Form → Servlet Controller → DAO Layer → MySQL Database

Database → DAO Layer → Servlet Controller → JSP View → Browser

---

## 5. Database Schema

### Tables Used

### User
Stores user information.

| Column |
|----------|
| user_id |
| first_name |
| last_name |
| email |
| mobile |
| dob |
| gender |

### Login_Details
Stores authentication details.

| Column |
|----------|
| login_id |
| user_id |
| email |
| password |

### Monument
Stores monument information.

| Column |
|----------|
| monument_id |
| monument_name |
| city |
| state |
| monument_type |
| entry_fee |

### Tour_Booking_Details
Stores booking information.

| Column |
|----------|
| booking_id |
| user_id |
| monument_id |
| visit_date |
| slot |
| adults |
| children |

### Payment_Details
Stores payment records.

| Column |
|----------|
| payment_id |
| booking_id |
| amount |
| payment_mode |
| payment_date |

### Booking_Cancellation
Stores cancellation records.

| Column |
|----------|
| cancellation_id |
| booking_id |
| refund_amount |
| cancellation_date |

---

## 6. Installation Steps

### Prerequisites

- Java JDK 17+
- MySQL 8+
- Apache Tomcat 10+
- Maven 3+
- Eclipse / IntelliJ IDEA

### Step 1: Clone Repository

```bash
git clone https://github.com/your-username/BharatDarshan.git
cd BharatDarshan
```

### Step 2: Create Database

```sql
CREATE DATABASE bharatdarshan;
```

Import SQL file into MySQL.

### Step 3: Configure Database

Update database credentials:

```properties
db.url=jdbc:mysql://localhost:3306/bharatdarshan
db.username=root
db.password=yourpassword
```

### Step 4: Build Project

```bash
mvn clean package
```

### Step 5: Deploy WAR

Copy generated WAR file into Tomcat webapps folder.

```bash
target/BharatDarshan.war
```

### Step 6: Start Tomcat

```bash
startup.bat
```

### Step 7: Access Application

```text
http://localhost:8080/BharatDarshan
```

---

## 7. API Endpoints

### Authentication

| Method | Endpoint |
|----------|------------|
| GET | /login |
| POST | /login |
| GET | /register |
| POST | /register |
| GET | /logout |

### Monument

| Method | Endpoint |
|----------|------------|
| GET | /home |
| GET | /monuments |
| GET | /monument-detail |

### Booking

| Method | Endpoint |
|----------|------------|
| GET | /book-ticket |
| POST | /book-ticket |
| GET | /my-bookings |

### Payment

| Method | Endpoint |
|----------|------------|
| GET | /payment |
| POST | /payment |

### Ticket

| Method | Endpoint |
|----------|------------|
| GET | /e-ticket |

### Cancellation

| Method | Endpoint |
|----------|------------|
| GET | /cancel-booking |
| POST | /cancel-booking |

### Profile

| Method | Endpoint |
|----------|------------|
| GET | /profile |
| POST | /update-profile |

### Admin

| Method | Endpoint |
|----------|------------|
| GET | /admin |
| GET | /admin/users |
| GET | /admin/bookings |
| POST | /admin/send-email |

---

## 8. Project Structure

```text
BharatDarshan
│
├── src
│   ├── main
│   │   ├── java
│   │   │   ├── model
│   │   │   ├── dao
│   │   │   ├── servlet
│   │   │   └── util
│   │   │
│   │   ├── resources
│   │   │   └── db.properties
│   │   │
│   │   └── webapp
│   │       ├── css
│   │       ├── images
│   │       ├── js
│   │       ├── WEB-INF
│   │       └── jsp
│
├── sql
│   └── schema.sql
│
├── pom.xml
│
├── README.md
│
└── target
    └── BharatDarshan.war
```

---

## Author

**Ganesh Kumar**

IGNOU BCA Final Year Project

BharatDarshan – ASI Monument E-Ticketing Web Portal