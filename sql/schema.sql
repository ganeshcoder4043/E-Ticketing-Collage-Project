-- ====================================================================
-- BharatDarshan — Archaeological Survey of India (ASI) E-Ticketing Portal
-- Database Schema (MySQL) & Seed Data
-- ====================================================================

CREATE DATABASE IF NOT EXISTS `bharatdarshan_db` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `bharatdarshan_db`;

-- Drop existing tables in reverse foreign key order
DROP TABLE IF EXISTS `booking_cancellation`;
DROP TABLE IF EXISTS `payment_details`;
DROP TABLE IF EXISTS `payment_mode`;
DROP TABLE IF EXISTS `tour_booking_details`;
DROP TABLE IF EXISTS `monument`;
DROP TABLE IF EXISTS `login_details`;
DROP TABLE IF EXISTS `user`;

-- --------------------------------------------------------------------
-- 1. Table: user
-- Stores personal and demographic details of registered citizens/tourists
-- --------------------------------------------------------------------
CREATE TABLE `user` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL,
    `gender` VARCHAR(1) NOT NULL, -- 'M', 'F', 'O'
    `email` VARCHAR(50) NOT NULL UNIQUE,
    `contact` BIGINT NOT NULL,
    `dob` DATE NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 2. Table: login_details
-- 1:1 Authentication details for registered users
-- --------------------------------------------------------------------
CREATE TABLE `login_details` (
    `user_id` INT PRIMARY KEY,
    `email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `forgot_password_flag` BOOLEAN DEFAULT FALSE,
    CONSTRAINT `fk_login_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 3. Table: monument
-- Master repository of ASI Protected Monuments and Heritage Sites
-- --------------------------------------------------------------------
CREATE TABLE `monument` (
    `mou_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `location` VARCHAR(100) NOT NULL,
    `type` VARCHAR(50) NOT NULL, -- 'World Heritage', 'Fort', 'Temple', 'Mausoleum', 'Cave', 'Palace'
    `fare` DECIMAL(10,2) NOT NULL,
    `child_fare` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `specification` VARCHAR(255) NOT NULL,
    `contact` BIGINT NOT NULL,
    `timings` VARCHAR(100) NOT NULL DEFAULT '06:00 AM - 06:00 PM (Sunrise to Sunset)',
    `city` VARCHAR(50) NOT NULL,
    `state` VARCHAR(50) NOT NULL,
    `image_url` VARCHAR(255) DEFAULT '',
    `description` TEXT
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 4. Table: tour_booking_details (Ticket Booking)
-- Stores ticket booking reservations
-- --------------------------------------------------------------------
CREATE TABLE `tour_booking_details` (
    `booking_id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `mou_id` INT NOT NULL,
    `session_id` VARCHAR(50) NOT NULL,
    `child` INT NOT NULL DEFAULT 0,
    `adult` INT NOT NULL DEFAULT 1,
    `tour_date` DATE NOT NULL,
    `departure_time` VARCHAR(50) NOT NULL, -- 'Forenoon (06:00 AM - 12:00 PM)', 'Afternoon (12:00 PM - 06:00 PM)'
    `total_amount` DECIMAL(10,2) NOT NULL,
    `booking_remarks` VARCHAR(255) DEFAULT 'Confirmed',
    `status` INT NOT NULL DEFAULT 1, -- 1: Active/Confirmed, 2: Cancelled, 3: Completed
    `cancel_request` INT NOT NULL DEFAULT 0, -- 0: No, 1: Requested, 2: Cancelled
    `contact_person_details` VARCHAR(255) NOT NULL,
    `terms` VARCHAR(255) NOT NULL DEFAULT 'Accepted ASI Guidelines',
    `booking_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user`(`id`),
    CONSTRAINT `fk_booking_monument` FOREIGN KEY (`mou_id`) 
        REFERENCES `monument`(`mou_id`)
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 5. Table: payment_mode
-- Payment mode selection linked to booking
-- --------------------------------------------------------------------
CREATE TABLE `payment_mode` (
    `payment_mode_id` INT AUTO_INCREMENT PRIMARY KEY,
    `booking_id` INT NOT NULL,
    `mode` ENUM('CASH','CREDIT_CARD','DEBIT_CARD','NET_BANKING') NOT NULL,
    CONSTRAINT `fk_paymode_booking` FOREIGN KEY (`booking_id`) 
        REFERENCES `tour_booking_details`(`booking_id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 6. Table: payment_details
-- Transaction records and masked payment details
-- --------------------------------------------------------------------
CREATE TABLE `payment_details` (
    `payment_id` INT AUTO_INCREMENT PRIMARY KEY,
    `payment_mode_id` INT NOT NULL,
    `card_number` VARCHAR(19), -- e.g. 'XXXX-XXXX-XXXX-4589'
    `card_holder_name` VARCHAR(50),
    `expiry_date` VARCHAR(7), -- MM/YYYY
    `ccv_no` VARCHAR(4),
    `transaction_status` VARCHAR(20) DEFAULT 'SUCCESS',
    `payment_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_paydetails_mode` FOREIGN KEY (`payment_mode_id`) 
        REFERENCES `payment_mode`(`payment_mode_id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------------------
-- 7. Table: booking_cancellation
-- Records of cancelled tickets with refund calculations
-- --------------------------------------------------------------------
CREATE TABLE `booking_cancellation` (
    `ticket_cancel_id` INT AUTO_INCREMENT PRIMARY KEY,
    `ticket_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `cancel_date` DATE NOT NULL,
    `cancel_reason` VARCHAR(255) NOT NULL,
    `deducted_amount` DECIMAL(10,2) NOT NULL,
    `refund_amount` DECIMAL(10,2) NOT NULL,
    CONSTRAINT `fk_cancel_ticket` FOREIGN KEY (`ticket_id`) 
        REFERENCES `tour_booking_details`(`booking_id`),
    CONSTRAINT `fk_cancel_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user`(`id`)
) ENGINE=InnoDB;

-- ====================================================================
-- SEED DATA INSERTION
-- ====================================================================

-- Demo User 1 (Password: Admin@123)
INSERT INTO `user` (`id`, `first_name`, `last_name`, `gender`, `email`, `contact`, `dob`) VALUES
(1, 'Rahul', 'Sharma', 'M', 'rahul.sharma@example.com', 9876543210, '1998-05-15'),
(2, 'Priya', 'Patel', 'F', 'priya.patel@example.com', 9812345678, '2001-11-20');

INSERT INTO `login_details` (`user_id`, `email`, `password`, `forgot_password_flag`) VALUES
(1, 'rahul.sharma@example.com', 'Admin@123', FALSE),
(2, 'priya.patel@example.com', 'Priya@123', FALSE);

-- Iconic ASI Monuments Seed Data
INSERT INTO `monument` (`mou_id`, `name`, `location`, `type`, `fare`, `child_fare`, `specification`, `contact`, `timings`, `city`, `state`, `image_url`, `description`) VALUES
(1, 'Taj Mahal', 'Dharmapuri, Forest Colony, Tajganj', 'World Heritage', 50.00, 0.00, 'Mughal Architecture, White Marble Wonder', 9156223304, '06:00 AM - 06:30 PM (Closed Fridays)', 'Agra', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800&auto=format&fit=crop&q=80', 'An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of the Mughal emperor Shah Jahan in memory of his favourite wife Mumtaz Mahal. It is the jewel of Muslim art in India and one of the universally admired masterpieces of the world heritage.'),

(2, 'Qutub Minar', 'Mehrauli', 'World Heritage', 40.00, 0.00, 'Minaret, Indo-Islamic Architecture', 9111266438, '07:00 AM - 05:00 PM Daily', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1585136917122-384aa94c0384?w=800&auto=format&fit=crop&q=80', 'A 73-metre tall minaret of red sandstone and marble, constructed in 1192 by Qutb-ud-din Aibak. The surrounding archaeological area contains funerary buildings, the Alai Darwaza Gate, and the famous 4th-century rust-resistant Iron Pillar.'),

(3, 'Red Fort (Lal Qila)', 'Netaji Subhash Marg, Lal Qila, Chandni Chowk', 'Fort', 35.00, 0.00, 'Mughal Fortress, Red Sandstone Citadel', 9111232777, '09:30 AM - 04:30 PM (Closed Mondays)', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1598324789736-4861f89564a0?w=800&auto=format&fit=crop&q=80', 'The historic fort in Old Delhi that served as the main residence of the Mughal Emperors for nearly 200 years. Every year on India\'s Independence Day, the Prime Minister hoists the Indian Tricolour at the fort\'s main gate.'),

(4, 'Sun Temple Konark', 'Konark, Puri District', 'World Heritage', 40.00, 0.00, 'Kalinga Architecture, 13th Century Chariot', 9167582368, '06:00 AM - 08:00 PM Daily', 'Konark', 'Odisha', 'https://images.unsplash.com/photo-1609137144822-473d328ec862?w=800&auto=format&fit=crop&q=80', 'A 13th-century CE Sun temple at Konark about 35 km northeast of Puri. Dedicated to the Hindu Sun God Surya, what remains of the temple complex has the appearance of a 100-foot high chariot with immense wheels and horses, all carved from stone.'),

(5, 'Ajanta Caves', 'Ajanta Caves Road', 'Cave', 40.00, 0.00, 'Buddhist Rock-cut Cave Monuments', 9124382442, '09:00 AM - 05:00 PM (Closed Mondays)', 'Aurangabad', 'Maharashtra', 'https://images.unsplash.com/photo-1609946850231-50e50b86a512?w=800&auto=format&fit=crop&q=80', 'Approximately 30 rock-cut Buddhist cave monuments dating from the 2nd century BCE to about 480 CE. The caves include masterpieces of Buddhist religious art and cave fresco paintings considered among the finest surviving examples of ancient Indian art.'),

(6, 'Hampi Monuments', 'Hampi, Vijayanagara District', 'World Heritage', 40.00, 0.00, 'Vijayanagara Empire Ruins & Stone Chariot', 9183942413, '06:00 AM - 06:00 PM Daily', 'Hampi', 'Karnataka', 'https://images.unsplash.com/photo-1600100397608-f010f4438fa4?w=800&auto=format&fit=crop&q=80', 'The austere, grandiose site of Hampi was the last capital of the great Hindu Kingdom of Vijayanagar. Its fabulously rich princes built Dravidian temples and palaces which won the admiration of travelers between the 14th and 16th centuries.'),

(7, 'Khajuraho Group of Monuments', 'Khajuraho, Chhatarpur District', 'Temple', 40.00, 0.00, 'Nagara Architecture, Chandela Dynasty Temples', 9176862740, '06:00 AM - 06:00 PM Daily', 'Khajuraho', 'Madhya Pradesh', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'A group of Hindu and Jain temples in Chhatarpur district. Built between 885 CE and 1000 CE by the Chandela dynasty, they are famous for their nagara-style architectural symbolism and intricate sculptural carvings.'),

(8, 'Fatehpur Sikri', 'Fatehpur Sikri, Agra District', 'World Heritage', 50.00, 0.00, 'Mughal Imperial City, Buland Darwaza', 9156132824, '06:00 AM - 06:00 PM Daily', 'Fatehpur Sikri', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?w=800&auto=format&fit=crop&q=80', 'Built during the second half of the 16th century by Emperor Akbar, Fatehpur Sikri (the City of Victory) was the capital of the Mughal Empire for only some 10 years. The complex includes the colossal Buland Darwaza and Jama Masjid.'),

(9, 'Elephanta Caves', 'Gharapuri Island, Mumbai Harbour', 'Cave', 40.00, 0.00, 'Rock-cut Trimurti Shiva Sculpture', 9122220440, '09:00 AM - 05:30 PM (Closed Mondays)', 'Mumbai', 'Maharashtra', 'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=800&auto=format&fit=crop&q=80', 'A collection of cave temples predominantly dedicated to the Hindu god Shiva, located on Elephanta Island in Mumbai Harbour. The rock cut sculptures of the Trimurti Sadashiva are celebrated worldwide for their sculptural grandeur.'),

(10, 'Golconda Fort', 'Ibrahim Bagh', 'Fort', 25.00, 0.00, 'Medieval Citadel & Acoustic Architecture', 9140235124, '09:00 AM - 05:30 PM Daily', 'Hyderabad', 'Telangana', 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?w=800&auto=format&fit=crop&q=80', 'A fortified citadel and early capital of the Qutb Shahi dynasty. It is famous for its ingenious acoustic system where a hand clap at the entrance can be clearly heard at the top of the pavilion a kilometre away.'),

(11, 'Mahabalipuram Group of Monuments', 'Shore Temple, Mahabalipuram', 'Temple', 40.00, 0.00, 'Pallava Dynasty Rock Relievos & Shore Temple', 9144274432, '06:00 AM - 06:00 PM Daily', 'Mahabalipuram', 'Tamil Nadu', 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=800&auto=format&fit=crop&q=80', 'This group of sanctuaries, founded by the Pallava kings, was carved out of rock along the Coromandel coast in the 7th and 8th centuries. It is known especially for its rathas, mandapas, and giant open-air reliefs such as Descent of the Ganges.'),

(12, 'Sun Temple Modhera', 'Mehsana District', 'Temple', 25.00, 0.00, 'Solanki Architecture & Stepwell Surya Kund', 9127622220, '07:00 AM - 06:00 PM Daily', 'Modhera', 'Gujarat', 'https://images.unsplash.com/photo-1621252179027-94459d278660?w=800&auto=format&fit=crop&q=80', 'Built in 1026-27 CE during the reign of Bhima I of the Chaulukya dynasty, the temple complex features a grand Sabha Mandapa, Gudha Mandapa, and a monumental stepped reservoir (Surya Kund) decorated with small shrines.');

-- Sample Tour Booking & Payment Seed Data
INSERT INTO `tour_booking_details` (`booking_id`, `user_id`, `mou_id`, `session_id`, `child`, `adult`, `tour_date`, `departure_time`, `total_amount`, `booking_remarks`, `status`, `cancel_request`, `contact_person_details`, `terms`, `booking_date`) VALUES
(1001, 1, 1, 'SESS_DEMO_001', 0, 2, '2026-09-10', 'Forenoon (06:00 AM - 12:00 PM)', 100.00, 'Confirmed E-Ticket', 1, 0, 'Rahul Sharma (+91 9876543210)', 'Accepted ASI Guidelines', '2026-08-20 14:30:00');

INSERT INTO `payment_mode` (`payment_mode_id`, `booking_id`, `mode`) VALUES
(501, 1001, 'CREDIT_CARD');

INSERT INTO `payment_details` (`payment_id`, `payment_mode_id`, `card_number`, `card_holder_name`, `expiry_date`, `ccv_no`, `transaction_status`, `payment_date`) VALUES
(901, 501, 'XXXX-XXXX-XXXX-4589', 'Rahul Sharma', '09/2028', '***', 'SUCCESS', '2026-08-20 14:32:00');
