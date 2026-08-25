# BharatDarshan — ASI Monument E-Ticketing Web Portal

> **IGNOU BCA Final-Year Project**  
> An Online E-Ticketing and Visitor Management Web Portal for the Archaeological Survey of India (ASI).

---

## 1. Project Overview

**BharatDarshan** is a complete, enterprise-grade e-ticketing web application for Indian heritage tourism. It enables citizens and foreign tourists to browse, search, and filter centrally protected monuments, book digital entry tickets, select visiting time slots (Forenoon/Afternoon), simulate secure multi-channel payments, obtain printable government-standard e-tickets with barcode/QR styling, and manage or cancel bookings with automated refund calculations.

### Key Architectural Highlights
- **Architecture**: Classic Model 2 / Model-View-Controller (MVC) Pattern.
- **Frontend**: Semantic HTML5, Pure CSS3 (Tricolor ASI heritage theme, `@media print` physical A4 stylesheet).
- **Strict Zero-JavaScript Constraint**: 100% compliant — No `<script>` tags, no client-side JavaScript, no AJAX/fetch. All interactions (search filtering, date picking, multi-step booking, CSS tab switching, cancellation confirmation) are handled via pure HTML forms (`POST`/`GET`) and server-side Servlet routing.
- **Backend**: Core Java (JDK 17+), Jakarta Servlets (`jakarta.servlet.*`), JSP 3.1, JSTL 3.0.
- **Database Access**: Pure JDBC with `java.sql.PreparedStatement` (SQL injection immune) and externalized `db.properties`.
- **Target Server**: Apache Tomcat 10.1+ (Jakarta EE 10).

---

## 2. Directory Structure

```
BharatDarshan/
├── pom.xml                                  # Maven project configuration
├── README.md                                # Project setup and viva guide
├── sql/
│   └── schema.sql                           # MySQL DDL script + 12+ ASI monuments & test seed data
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── bharatdarshan/
│       │           ├── model/               # Model (POJO) Layer
│       │           │   ├── User.java
│       │           │   ├── LoginDetails.java
│       │           │   ├── Monument.java
│       │           │   ├── TourBooking.java
│       │           │   ├── PaymentMode.java
│       │           │   ├── PaymentDetails.java
│       │           │   └── BookingCancellation.java
│       │           ├── dao/                 # Data Access Object (DAO) Layer
│       │           │   ├── UserDAO.java
│       │           │   ├── MonumentDAO.java
│       │           │   ├── BookingDAO.java
│       │           │   ├── PaymentDAO.java
│       │           │   └── CancellationDAO.java
│       │           ├── servlet/             # Controller (Servlet) Layer
│       │           │   ├── HomeServlet.java
│       │           │   ├── MonumentServlet.java
│       │           │   ├── AuthServlet.java
│       │           │   ├── BookTicketServlet.java
│       │           │   ├── PaymentServlet.java
│       │           │   ├── TicketServlet.java
│       │           │   ├── MyBookingsServlet.java
│       │           │   └── CancelBookingServlet.java
│       │           └── util/                # Utilities & Security Filters
│       │               ├── DBConnection.java
│       │               └── AuthFilter.java
│       ├── resources/
│       │   └── db.properties                # Database connection credentials
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml                  # Deployment descriptor
│           │   └── views/                   # JSP Views
│           │       ├── common/
│           │       │   ├── header.jsp
│           │       │   └── footer.jsp
│           │       ├── home.jsp
│           │       ├── monuments.jsp
│           │       ├── monument-detail.jsp
│           │       ├── login.jsp
│           │       ├── register.jsp
│           │       ├── book-ticket.jsp
│           │       ├── payment.jsp
│           │       ├── booking-confirmation.jsp
│           │       ├── e-ticket.jsp
│           │       ├── my-bookings.jsp
│           │       └── cancel-booking.jsp
│           └── static/
│               └── css/
│                   └── style.css            # Pure CSS styles & @media print A4 layout
└── target/
    └── BharatDarshan.war                    # Compiled, deployable web archive
```

---

## 3. Database Setup (MySQL)

### Step 1: Open MySQL Command Line or MySQL Workbench
Log into your MySQL instance:
```bash
mysql -u root -p
```

### Step 2: Import the Database Schema & Seed Data
Run the `schema.sql` script located in the `sql/` directory:
```sql
SOURCE D:/clg project/sql/schema.sql;
```
*(Or copy and execute the full contents of `sql/schema.sql` inside MySQL Workbench / phpMyAdmin).*

This will create the database `bharatdarshan_db` along with 7 relational tables:
1. `user` — Citizen and tourist profile records.
2. `login_details` — 1:1 Authentication credentials.
3. `monument` — Protected heritage monument directory (Taj Mahal, Qutub Minar, Red Fort, Ajanta Caves, Konark, Hampi, Khajuraho, Modhera, etc.).
4. `tour_booking_details` — E-ticket reservations with slots and passenger counts.
5. `payment_mode` — Selected payment method (`CREDIT_CARD`, `DEBIT_CARD`, `NET_BANKING`, `CASH`).
6. `payment_details` — Transaction records with masked card details.
7. `booking_cancellation` — Cancellation records with 20% deduction and 80% refund calculation.

### Step 3: Configure Database Credentials
Edit `src/main/resources/db.properties` with your MySQL username and password:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/bharatdarshan_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8
db.username=root
db.password=YOUR_MYSQL_PASSWORD
```

---

## 4. Build & Deployment Instructions

### Prerequisites
- **Java Development Kit (JDK)**: Version 17 or Version 21.
- **Apache Maven**: Version 3.8+.
- **Apache Tomcat**: Version 10.1+ (Jakarta EE 10).

### Option A: Build and Deploy using Maven (Command Line)

1. Open terminal inside the project directory:
   ```bash
   cd "D:\clg project"
   ```

2. Compile and package the WAR file:
   ```bash
   mvn clean package
   ```

3. Copy the generated `target/BharatDarshan.war` into your Tomcat `webapps/` folder:
   ```bash
   # Windows PowerShell example:
   Copy-Item "target/BharatDarshan.war" "C:\apache-tomcat-10.1.x\webapps\"
   ```

4. Start Tomcat:
   ```bash
   C:\apache-tomcat-10.1.x\bin\startup.bat
   ```

5. Open your browser and navigate to:
   ```
   http://localhost:8080/BharatDarshan/
   ```

---

### Option B: Run in Eclipse IDE for Java EE Developers

1. Open Eclipse &rarr; **File** &rarr; **Import...** &rarr; **Existing Maven Projects**.
2. Browse to `D:\clg project` and click **Finish**.
3. Right-click the `BharatDarshan` project &rarr; **Run As** &rarr; **Run on Server**.
4. Select **Apache Tomcat v10.1** and click **Finish**.

---

### Option C: Run in IntelliJ IDEA Ultimate

1. Open `D:\clg project` as a Maven project.
2. Add a new **Run/Debug Configuration** &rarr; **Tomcat Server** &rarr; **Local**.
3. Under the **Deployment** tab, click **+** &rarr; **Artifact** &rarr; select `BharatDarshan:war`.
4. Set Application Context to `/BharatDarshan`.
5. Click **Run**.

---

## 5. Demo Test Accounts for Viva / Evaluation

Pre-seeded test credentials ready to use:

| Email | Password | Role / Account Type |
|---|---|---|
| `rahul.sharma@example.com` | `Admin@123` | Registered Citizen (Has pre-seeded Taj Mahal booking) |
| `priya.patel@example.com` | `Priya@123` | Registered Citizen |

*(New users can also register instantly on the portal via the `/register` screen).*

---

## 6. Functional Testing Guide (User Journey)

1. **Home & Search (`/home`)**:
   - Filter by State (e.g. `Delhi`, `Uttar Pradesh`, `Maharashtra`) or Monument Type (`Fort`, `World Heritage`, `Temple`).
2. **Monument Details (`/monument-detail?id=1`)**:
   - Inspect architectural specifications, visiting hours, circle contact, and adult/child fare breakdown.
3. **Booking (`/book-ticket?mouId=1`)**:
   - Pick a visit date (calendar constrained to future dates), select time slot (`Forenoon` / `Afternoon`), specify number of adults and children.
4. **Payment Options (`/payment`)**:
   - Test payment method switching (Credit Card, Debit Card, Net Banking, Cash at Counter) using pure CSS interactivity.
5. **Printable E-Ticket (`/e-ticket?id=1001`)**:
   - View the official ASI-formatted E-Ticket with simulated barcode & QR security box.
   - Press <kbd>Ctrl + P</kbd> in your browser to verify the `@media print` clean A4 layout.
6. **Cancellation & Refund (`/my-bookings` &rarr; `/cancel-booking?id=1001`)**:
   - Review the automatic 20% cancellation deduction and 80% refund calculation.
   - Confirm cancellation to update booking status and record refund in the database.

---

## 7. Viva / Exam Technical Questions & Answers

### Q1: What design pattern is used in this project?
> **Answer**: The project strictly implements the **Model-View-Controller (MVC / Model 2)** architecture:
> - **Model**: POJOs (`User.java`, `Monument.java`, `TourBooking.java`, etc.) representing database entities.
> - **View**: JSP pages styled with pure CSS rendering data sent by controllers.
> - **Controller**: Java Servlets (`HomeServlet`, `MonumentServlet`, `BookTicketServlet`, `PaymentServlet`, etc.) handling request logic, validation, session management, and routing.
> - **DAO**: Data Access Objects (`UserDAO`, `MonumentDAO`, `BookingDAO`, `PaymentDAO`, `CancellationDAO`) encapsulating JDBC queries.

### Q2: How is the "Strict Zero-JavaScript" constraint achieved?
> **Answer**: All client-server interactions use standard HTML `<form>` submissions with `POST` and `GET` methods followed by server-side redirects (`response.sendRedirect`) and forwards (`RequestDispatcher.forward`). Dynamic UI states (such as payment mode selection) are achieved using **pure CSS3 techniques** (`:checked` pseudo-class and sibling selectors) without any JavaScript or `<script>` tags.

### Q3: How is SQL Injection prevented?
> **Answer**: All SQL operations in the DAO layer exclusively use `java.sql.PreparedStatement` with parameterized placeholders (`?`). No SQL strings are concatenated with user input.

### Q4: How is database connection lifecycle managed?
> **Answer**: `DBConnection.java` uses `java.sql.DriverManager` reading configuration dynamically from `db.properties` via `ClassLoader.getResourceAsStream()`. All database resources (`ResultSet`, `PreparedStatement`, `Connection`) are closed using `AutoCloseable` helper methods in `finally` blocks to prevent connection leaks.
