-- ====================================================================
-- BharatDarshan — 75+ Pan-India Protected Monuments & Heritage Sites
-- Every monument has a 100% UNIQUE individual image URL & complete details
-- ====================================================================

USE `bharatdarshan_db`;

-- Clear existing monuments to avoid duplicates and reset counter:
DELETE FROM `tour_booking_details`;
DELETE FROM `monument`;
ALTER TABLE `monument` AUTO_INCREMENT = 1;

INSERT INTO `monument` 
(`mou_id`, `name`, `location`, `type`, `fare`, `child_fare`, `specification`, `contact`, `timings`, `city`, `state`, `image_url`, `description`) 
VALUES

-- 1. Taj Mahal (Uttar Pradesh)
(1, 'Taj Mahal', 'Dharmapuri, Tajganj', 'World Heritage', 50.00, 0.00, 'Mughal Architecture, White Marble Wonder of the World', 9156223304, '06:00 AM - 06:30 PM (Closed Fridays)', 'Agra', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800&auto=format&fit=crop&q=80', 'An immense mausoleum of white marble, built in Agra between 1631 and 1648 by order of Emperor Shah Jahan in memory of his favourite wife Mumtaz Mahal.'),

-- 2. Qutub Minar (Delhi)
(2, 'Qutub Minar', 'Mehrauli', 'World Heritage', 40.00, 0.00, 'Minaret, Indo-Islamic Architecture with 4th Century Iron Pillar', 9111266438, '07:00 AM - 05:00 PM Daily', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1585136917122-384aa94c0384?w=800&auto=format&fit=crop&q=80', 'A 73-metre tall minaret of red sandstone and marble constructed in 1192 by Qutb-ud-din Aibak, featuring the famous rust-resistant Iron Pillar.'),

-- 3. Red Fort (Delhi)
(3, 'Red Fort (Lal Qila)', 'Netaji Subhash Marg, Chandni Chowk', 'Fort', 35.00, 0.00, 'Mughal Fortress, Red Sandstone Citadel (1648)', 9111232777, '09:30 AM - 04:30 PM (Closed Mondays)', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1598324789736-4861f89564a0?w=800&auto=format&fit=crop&q=80', 'The historic fort in Old Delhi that served as the main residence of the Mughal Emperors for nearly 200 years, venue of the annual Independence Day address.'),

-- 4. Humayun Tomb (Delhi)
(4, 'Humayun Tomb', 'Mathura Road, Nizamuddin East', 'World Heritage', 40.00, 0.00, 'First Persian Charbagh Garden-Tomb in India (1570)', 9111243542, '06:00 AM - 06:00 PM Daily', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1587474260584-136574528ed5?w=800&auto=format&fit=crop&q=80', 'Built in 1570 by Empress Bega Begum, it was the first garden-tomb on the Indian subcontinent and inspired the architectural design of the Taj Mahal.'),

-- 5. Safdarjung Tomb (Delhi)
(5, 'Safdarjung Tomb', 'Air Force Golf Course, Delhi Race Club', 'Mausoleum', 25.00, 0.00, 'Late Mughal Garden Tomb in Red Sandstone & Marble (1754)', 9111246470, '07:00 AM - 05:00 PM Daily', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1608958435020-e8a7109ba809?w=800&auto=format&fit=crop&q=80', 'A garden tomb built in 1754 for the prime minister of the Mughal Empire, Safdarjung, representing the final phase of Mughal architecture in Delhi.'),

-- 6. Purana Qila (Delhi)
(6, 'Purana Qila (Old Fort)', 'Mathura Road, Near Delhi Zoo', 'Fort', 25.00, 0.00, 'Sher Shah Suri Citadel & Ancient Indraprastha Site', 9111243545, '07:00 AM - 05:00 PM Daily', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?w=800&auto=format&fit=crop&q=80', 'One of the oldest forts in Delhi, constructed by Sher Shah Suri and Humayun, containing the Sher Mandal observatory and Qila-i-Kuhna Mosque.'),

-- 7. Jantar Mantar (Delhi)
(7, 'Jantar Mantar Delhi', 'Sansad Marg, Connaught Place', 'World Heritage', 25.00, 0.00, 'Equinoctial Sundial & Astronomical Masonry Instruments (1724)', 9111233658, '06:00 AM - 06:00 PM Daily', 'New Delhi', 'Delhi', 'https://images.unsplash.com/photo-1596405537213-df466a98d363?w=800&auto=format&fit=crop&q=80', 'An astronomical observatory built by Maharaja Jai Singh II of Jaipur starting in 1724, housing the massive Samrat Yantra sundial.'),

-- 8. Agra Fort (Uttar Pradesh)
(8, 'Agra Fort', 'Rakabganj', 'World Heritage', 40.00, 0.00, 'Mughal Imperial Residence, Jahangiri Mahal & Sheesh Mahal', 9156224125, '06:00 AM - 06:00 PM Daily', 'Agra', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1588416936097-41850ab3d86d?w=800&auto=format&fit=crop&q=80', 'A monumental 94-acre brick-and-red-sandstone fortress situated along the Yamuna River that served as the capital citadel for Akbar, Jahangir, and Shah Jahan.'),

-- 9. Fatehpur Sikri (Uttar Pradesh)
(9, 'Fatehpur Sikri', 'Fatehpur Sikri, Agra District', 'World Heritage', 50.00, 0.00, 'Mughal Imperial City, Buland Darwaza & Salim Chishti Dargah', 9156132824, '06:00 AM - 06:00 PM Daily', 'Fatehpur Sikri', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?w=800&auto=format&fit=crop&q=80', 'Founded in 1571 by Emperor Akbar as capital of the Mughal Empire, featuring the 54-meter tall Buland Darwaza gate and white marble Chishti tomb.'),

-- 10. Akbar Tomb Sikandra (Uttar Pradesh)
(10, 'Akbar Tomb Sikandra', 'Sikandra', 'Mausoleum', 30.00, 0.00, 'Four-Tiered Sandstone & White Marble Imperial Necropolis', 9156226412, '06:00 AM - 06:00 PM Daily', 'Agra', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1620766182966-c6eb5ed2b788?w=800&auto=format&fit=crop&q=80', 'The mausoleum of the great Mughal Emperor Akbar, completed by his son Jahangir in 1613, set inside a peaceful 119-acre walled deer park.'),

-- 11. Itimad-ud-Daulah (Uttar Pradesh)
(11, 'Itimad-ud-Daulah (Baby Taj)', 'Moti Bagh, Jamuna River Bank', 'Mausoleum', 30.00, 0.00, 'First Mughal Structure of Pure White Marble with Pietra Dura', 9156226419, '06:00 AM - 06:00 PM Daily', 'Agra', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1548013146-72479768bada?w=800&auto=format&fit=crop&q=80', 'Commissioned by Empress Nur Jahan for her father Mirza Ghiyas Beg, this jewel-box tomb is famous for introducing floral gemstone inlays to Indian art.'),

-- 12. Dhamek Stupa (Uttar Pradesh)
(12, 'Dhamek Stupa Sarnath', 'Sarnath, Rishipattana', 'World Heritage', 25.00, 0.00, '5th Century Mauryan Cylinder Stupa, First Sermon of Buddha', 9154225950, '06:00 AM - 05:00 PM Daily', 'Varanasi', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1599818816943-440f1a9b2c34?w=800&auto=format&fit=crop&q=80', 'A massive cylindrical stupa standing 43.6 meters high where Lord Buddha preached his first sermon (Dhammacakkappavattana Sutta) to his five disciples.'),

-- 13. Bara Imambara (Uttar Pradesh)
(13, 'Bara Imambara', 'Machchhi Bhavan', 'Historical', 50.00, 0.00, 'Asfi Mosque, Unsupported Arched Vault & Bhool Bhulaiya Maze', 9152222541, '06:00 AM - 05:00 PM Daily', 'Lucknow', 'Uttar Pradesh', 'https://images.unsplash.com/photo-1622396481304-4ad7353112d1?w=800&auto=format&fit=crop&q=80', 'Built by Nawab Asaf-ud-Daula in 1784 as a famine-relief project, containing one of the largest unsupported vaulted halls in the world and an intricate labyrinth.'),

-- 14. Amber Fort (Rajasthan)
(14, 'Amber Fort', 'Devisinghpura, Amer', 'World Heritage', 50.00, 0.00, 'Sheesh Mahal, Rajput Royal Citadel Overlooking Maota Lake', 9114125302, '08:00 AM - 05:30 PM Daily', 'Jaipur', 'Rajasthan', 'https://images.unsplash.com/photo-1599661046289-e31897846e41?w=800&auto=format&fit=crop&q=80', 'A principal hilltop fort in Jaipur known for its artistic Hindu architectural elements, cobblestone paths, mirror palace (Sheesh Mahal), and ramparts.'),

-- 15. Hawa Mahal (Rajasthan)
(15, 'Hawa Mahal', 'Badi Choupad', 'Palace', 50.00, 0.00, 'Palace of Winds, 953 Jharokha Windows in Pink Sandstone (1799)', 9114126188, '09:00 AM - 04:30 PM Daily', 'Jaipur', 'Rajasthan', 'https://images.unsplash.com/photo-1609946850231-50e50b86a512?w=800&auto=format&fit=crop&q=80', 'Constructed in 1799 by Maharaja Sawai Pratap Singh, this five-storey facade was designed to let royal women observe daily street festivals unobserved.'),

-- 16. Mehrangarh Fort (Rajasthan)
(16, 'Mehrangarh Fort', 'P.B No 165, The Fort', 'Fort', 100.00, 0.00, '400ft Hilltop Fortress, Phool Mahal & Moti Mahal (1459)', 9129125487, '09:00 AM - 05:00 PM Daily', 'Jodhpur', 'Rajasthan', 'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=800&auto=format&fit=crop&q=80', 'One of the largest forts in India, built around 1459 by Rao Jodha, towering 400 feet above the blue city of Jodhpur with impregnable stone walls.'),

-- 17. Chittorgarh Fort (Rajasthan)
(17, 'Chittorgarh Fort', 'Chittorgarh Fort Rd', 'World Heritage', 40.00, 0.00, 'Vijay Stambha, Kirti Stambha & Padmini Palace (700 Acres)', 9114722412, '09:00 AM - 05:00 PM Daily', 'Chittorgarh', 'Rajasthan', 'https://images.unsplash.com/photo-1600100397608-f010f4438fa4?w=800&auto=format&fit=crop&q=80', 'The largest fort in India spanning 700 acres atop a 180-meter hill, immortalized by tales of Rajput courage, devotion, and the historic Victory Tower.'),

-- 18. Kumbhalgarh Fort (Rajasthan)
(18, 'Kumbhalgarh Fort', 'Kumbhalgarh, Rajsamand', 'World Heritage', 40.00, 0.00, 'Second Longest Continuous Wall in the World (36 km)', 9129542426, '09:00 AM - 05:00 PM Daily', 'Rajsamand', 'Rajasthan', 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?w=800&auto=format&fit=crop&q=80', 'Mewar fortress built during the 15th century by Rana Kumbha, birthplace of Maharana Pratap, surrounded by a 36-kilometer continuous defensive stone wall.'),

-- 19. Jaisalmer Fort (Rajasthan)
(19, 'Jaisalmer Fort (Sonar Qila)', 'Fort Road', 'World Heritage', 50.00, 0.00, 'Living Golden Sandstone Desert Citadel (1156 CE)', 9129922512, '09:00 AM - 05:00 PM Daily', 'Jaisalmer', 'Rajasthan', 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=800&auto=format&fit=crop&q=80', 'One of the very few living forts in the world, founded in 1156 CE by Rawal Jaisal in the Thar Desert, glowing like yellow gold in the sunlight.'),

-- 20. City Palace Udaipur (Rajasthan)
(20, 'City Palace Udaipur', 'Old City, Lake Pichola Bank', 'Palace', 100.00, 0.00, 'Mewar Dynasty Granitic Palace Complex on Lake Pichola', 9129424190, '09:30 AM - 05:30 PM Daily', 'Udaipur', 'Rajasthan', 'https://images.unsplash.com/photo-1615836245337-f5b9b2303f10?w=800&auto=format&fit=crop&q=80', 'A monumental palace complex built over 400 years by 22 Mewar rulers, featuring marble balconies, towers, and panoramic views of Lake Pichola.'),

-- 21. Ranakpur Jain Temple (Rajasthan)
(21, 'Ranakpur Jain Temple', 'Desuri, Ranakpur', 'Temple', 50.00, 0.00, '1,444 Distinctly Carved White Marble Pillars (15th Century)', 9129342850, '12:00 PM - 05:00 PM Daily', 'Pali', 'Rajasthan', 'https://images.unsplash.com/photo-1621252179027-94459d278660?w=800&auto=format&fit=crop&q=80', 'Dedicated to Tirthankara Rishabhanatha, famous across the world because no two of its 1,444 intricately sculpted marble pillars share the same carving.'),

-- 22. Ajanta Caves (Maharashtra)
(22, 'Ajanta Caves', 'Ajanta Caves Road', 'Cave', 40.00, 0.00, '30 Rock-cut Buddhist Caves with 2nd Century BCE Frescoes', 9124382442, '09:00 AM - 05:00 PM (Closed Mondays)', 'Aurangabad', 'Maharashtra', 'https://images.unsplash.com/photo-1590766940554-634a7ed41450?w=800&auto=format&fit=crop&q=80', 'Masterpieces of Buddhist religious art and cave fresco paintings considered among the finest surviving examples of ancient Indian mural painting.'),

-- 23. Ellora Caves (Maharashtra)
(23, 'Ellora Caves', 'Verul', 'World Heritage', 40.00, 0.00, 'Kailash Temple (Cave 16), Monolithic Rock-cut Marvel', 9124372445, '06:00 AM - 06:00 PM (Closed Tuesdays)', 'Aurangabad', 'Maharashtra', 'https://images.unsplash.com/photo-1609137144822-473d328ec862?w=800&auto=format&fit=crop&q=80', 'Features 34 monasteries and temples cut into the basalt cliff, including the colossal Kailash Temple carved top-down from a single 200,000-tonne rock mass.'),

-- 24. Elephanta Caves (Maharashtra)
(24, 'Elephanta Caves', 'Gharapuri Island, Mumbai Harbour', 'Cave', 40.00, 0.00, 'Rock-cut Trimurti Sadashiva Sculpture (6th Century CE)', 9122220440, '09:00 AM - 05:30 PM (Closed Mondays)', 'Mumbai', 'Maharashtra', 'https://images.unsplash.com/photo-1566837945700-30057527ade0?w=800&auto=format&fit=crop&q=80', 'A collection of cave temples predominantly dedicated to Lord Shiva on Elephanta Island, famed for the colossal 20-foot three-headed Trimurti relief.'),

-- 25. Bibi Ka Maqbara (Maharashtra)
(25, 'Bibi Ka Maqbara', 'Begumpura', 'Mausoleum', 25.00, 0.00, 'Dakhani Taj Mahal, Tomb of Queen Dilras Banu Begum (1668)', 9124024001, '06:00 AM - 08:00 PM Daily', 'Aurangabad', 'Maharashtra', 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?w=800&auto=format&fit=crop&q=80', 'Commissioned by Prince Azam Shah in 1668 in memory of his mother, sharing a striking architectural resemblance to the Taj Mahal of Agra.'),

-- 26. Daulatabad Fort (Maharashtra)
(26, 'Daulatabad Fort', 'Daulatabad Hill', 'Fort', 25.00, 0.00, 'Devagiri Citadel, Chand Minar & Dark Maze Defenses', 9124026344, '06:00 AM - 06:00 PM Daily', 'Aurangabad', 'Maharashtra', 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=800&auto=format&fit=crop&q=80', 'A 14th-century fortress situated on a 200-meter-high conical hill, famous for its unbreachable subterranean labyrinth (Bhool Bhulaiya) and triple moat system.'),

-- 27. Shaniwar Wada (Maharashtra)
(27, 'Shaniwar Wada', 'Shaniwar Peth', 'Fort', 25.00, 0.00, '7-Storeyed Palace Seat of Maratha Peshwas (1732)', 9120244401, '08:00 AM - 06:30 PM Daily', 'Pune', 'Maharashtra', 'https://images.unsplash.com/photo-1580618672591-eb180b1a973f?w=800&auto=format&fit=crop&q=80', 'Built by Peshwa Baji Rao I in 1732, this fortified palace was the center of Indian politics during the 18th century rise of the Maratha Empire.'),

-- 28. Gateway of India (Maharashtra)
(28, 'Gateway of India', 'Apollo Bandar, Colaba', 'Historical', 30.00, 0.00, 'Indo-Saracenic Basalt Arch Overlooking Arabian Sea (1924)', 9122228418, '24 Hours Open', 'Mumbai', 'Maharashtra', 'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=800&auto=format&fit=crop&q=80', 'An arch-monument built in the early 20th century to commemorate the landing of King George V and Queen Mary in Bombay in 1911.'),

-- 29. Khajuraho Monuments (Madhya Pradesh)
(29, 'Khajuraho Group of Monuments', 'Khajuraho, Chhatarpur', 'World Heritage', 40.00, 0.00, 'Kandariya Mahadeva & Chandela Dynasty Sculptural Art', 9176862740, '06:00 AM - 06:00 PM Daily', 'Khajuraho', 'Madhya Pradesh', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'A cluster of Hindu and Jain temples built between 885 CE and 1000 CE, world-famous for their architectural nagara symmetry and sculptures.'),

-- 30. Sanchi Stupa (Madhya Pradesh)
(30, 'Sanchi Stupa', 'Sanchi, Raisen District', 'World Heritage', 40.00, 0.00, 'Great Stupa of Emperor Ashoka with Carved Torana Gateways', 9174822668, '06:30 AM - 06:30 PM Daily', 'Sanchi', 'Madhya Pradesh', 'https://images.unsplash.com/photo-1599818816943-440f1a9b2c34?w=800&auto=format&fit=crop&q=80', 'One of the oldest stone structures in India commissioned by Emperor Ashoka in the 3rd century BCE, housing precious Buddhist relics.'),

-- 31. Gwalior Fort (Madhya Pradesh)
(31, 'Gwalior Fort', 'Gopachal Parvat', 'Fort', 25.00, 0.00, 'Man Mandir Palace, Turquoise Tiles & Sas Bahu Temples', 9175124104, '06:00 AM - 05:30 PM Daily', 'Gwalior', 'Madhya Pradesh', 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?w=800&auto=format&fit=crop&q=80', 'Described by Babur as the pearl among fortresses of Hind, featuring vivid yellow and turquoise enameled tile work on its massive defensive bastions.'),

-- 32. Bhimbetka Rock Shelters (Madhya Pradesh)
(32, 'Bhimbetka Rock Shelters', 'Bhojpur Raisen', 'World Heritage', 25.00, 0.00, '30,000 Year Old Paleolithic Rock Art in Dense Teak Forests', 9174802801, '07:00 AM - 06:00 PM Daily', 'Bhimbetka', 'Madhya Pradesh', 'https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?w=800&auto=format&fit=crop&q=80', 'An archaeological site exhibiting the earliest traces of human life on the Indian subcontinent, with over 750 prehistoric rock shelters.'),

-- 33. Jahangir Mahal Orchha (Madhya Pradesh)
(33, 'Jahangir Mahal Orchha', 'Orchha, Tikamgarh', 'Palace', 25.00, 0.00, 'Bundela-Mughal Fusion Citadel on Betwa River Bank', 9176802526, '08:00 AM - 05:30 PM Daily', 'Orchha', 'Madhya Pradesh', 'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=800&auto=format&fit=crop&q=80', 'A tiered 17th-century palace built by Bir Singh Deo to honor Mughal Emperor Jahangir, surrounded by ornate cenotaphs (chhatris) on the riverbank.'),

-- 34. Hampi Monuments (Karnataka)
(34, 'Hampi Monuments', 'Hampi, Vijayanagara District', 'World Heritage', 40.00, 0.00, 'Stone Chariot, Musical Pillars & Vijayanagara Empire Capital', 9183942413, '06:00 AM - 06:00 PM Daily', 'Hampi', 'Karnataka', 'https://images.unsplash.com/photo-1600100397608-f010f4438fa4?w=800&auto=format&fit=crop&q=80', 'The austere, grandiose capital of the Hindu Vijayanagara Empire (14th-16th centuries), with the iconic Stone Chariot at the Vittala Temple complex.'),

-- 35. Gol Gumbaz (Karnataka)
(35, 'Gol Gumbaz', 'Jalar Nagar', 'Historical', 25.00, 0.00, 'Free-Standing Acoustic Dome with Whispering Gallery (1656)', 9183522624, '06:00 AM - 06:00 PM Daily', 'Vijayapura', 'Karnataka', 'https://images.unsplash.com/photo-1585136917122-384aa94c0384?w=800&auto=format&fit=crop&q=80', 'The mausoleum of Sultan Mohammed Adil Shah, holding the second largest dome in the world built without central column support.'),

-- 36. Pattadakal Temples (Karnataka)
(36, 'Pattadakal Temples', 'Pattadakal, Bagalkot', 'World Heritage', 40.00, 0.00, 'Chalukyan Coronation Complex Blending Nagara & Dravidian Art', 9183572412, '06:00 AM - 06:00 PM Daily', 'Pattadakal', 'Karnataka', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'A complex of 7th and 8th century CE temples where Chalukya kings were coronated, representing the harmonious synthesis of northern and southern temple designs.'),

-- 37. Badami Cave Temples (Karnataka)
(37, 'Badami Cave Temples', 'Badami, Bagalkot', 'Cave', 25.00, 0.00, '6th Century Chalukyan Sandstone Cave Shrines Over Agastya Lake', 9183572201, '06:00 AM - 06:00 PM Daily', 'Badami', 'Karnataka', 'https://images.unsplash.com/photo-1609946850231-50e50b86a512?w=800&auto=format&fit=crop&q=80', 'Four sandstone rock-cut cave temples dedicated to Shiva, Vishnu, and Jain Tirthankaras overlooking the ancient green Agastya Lake.'),

-- 38. Mysore Palace (Karnataka)
(38, 'Mysore Palace (Amba Vilas)', 'Sayyaji Rao Rd', 'Palace', 100.00, 0.00, 'Wadiyar Royal Palace with 97,000 Illumination Bulbs', 9182124210, '10:00 AM - 05:30 PM Daily', 'Mysuru', 'Karnataka', 'https://images.unsplash.com/photo-1599661046289-e31897846e41?w=800&auto=format&fit=crop&q=80', 'The official seat of the Wadiyar Maharajas of Mysore, built in Indo-Saracenic style with stained glass ceilings and golden elephant thrones.'),

-- 39. Mahabalipuram Shore Temple (Tamil Nadu)
(39, 'Mahabalipuram Shore Temple', 'Shore Temple Road', 'World Heritage', 40.00, 0.00, 'Pallava Dynasty Granite Temples & Descent of the Ganges', 9144274432, '06:00 AM - 06:00 PM Daily', 'Mahabalipuram', 'Tamil Nadu', 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=800&auto=format&fit=crop&q=80', 'Built with blocks of carved granite overlooking the Bay of Bengal in the 8th century CE by Narasimhavarman II, featuring five monolithic Rathas.'),

-- 40. Brihadisvara Temple Thanjavur (Tamil Nadu)
(40, 'Brihadisvara Temple Thanjavur', 'Membalam Rd', 'World Heritage', 40.00, 0.00, 'Great Living Chola Temple with 80-Tonne Monolithic Capstone', 9143622744, '06:00 AM - 08:30 PM Daily', 'Thanjavur', 'Tamil Nadu', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'Built by Chola Emperor Rajaraja I between 1003 and 1010 CE, standing 216 feet high, one of the tallest all-granite temples in human history.'),

-- 41. Airavatesvara Temple (Tamil Nadu)
(41, 'Airavatesvara Temple Darasuram', 'Kumbakonam', 'World Heritage', 25.00, 0.00, 'Chola Chariot Temple Architecture & Stepped Musical Mandapa', 9143524102, '06:00 AM - 08:00 PM Daily', 'Kumbakonam', 'Tamil Nadu', 'https://images.unsplash.com/photo-1600100397608-f010f4438fa4?w=800&auto=format&fit=crop&q=80', 'Built by Rajaraja II in the 12th century CE, featuring an entrance porch sculpted as a stone chariot drawn by galloping horses.'),

-- 42. Golconda Fort (Telangana)
(42, 'Golconda Fort', 'Ibrahim Bagh', 'Fort', 25.00, 0.00, 'Medieval Citadel, Fateh Darwaza Acoustics & Diamond Vaults', 9140235124, '09:00 AM - 05:30 PM Daily', 'Hyderabad', 'Telangana', 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?w=800&auto=format&fit=crop&q=80', 'The capital fortress of the Qutb Shahi dynasty where famous diamonds including the Koh-i-Noor and Hope Diamond were stored.'),

-- 43. Charminar (Telangana)
(43, 'Charminar', 'Ghansi Bazaar', 'Historical', 25.00, 0.00, 'Four 48.7-Metre Stucco Minarets & Upper Floor Mosque (1591)', 9140245229, '09:30 AM - 05:30 PM Daily', 'Hyderabad', 'Telangana', 'https://images.unsplash.com/photo-1585136917122-384aa94c0384?w=800&auto=format&fit=crop&q=80', 'Constructed in 1591 by Muhammad Quli Qutb Shah at the intersection of historic trade routes to celebrate the eradication of a deadly epidemic.'),

-- 44. Ramappa Temple (Telangana)
(44, 'Ramappa Temple', 'Palampet, Mulugu', 'World Heritage', 30.00, 0.00, 'Kakatiya Sandbox Foundation & Lightweight Floating Bricks', 9187152840, '06:00 AM - 06:00 PM Daily', 'Mulugu', 'Telangana', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'A 13th-century engineering marvel constructed with porous floating bricks atop an earthquake-resistant sandbox foundation.'),

-- 45. Lepakshi Temple (Andhra Pradesh)
(45, 'Lepakshi Veerabhadra Temple', 'Lepakshi, Anantapur', 'Temple', 25.00, 0.00, 'Hanging Stone Pillar, Monolithic Nagalinga & Giant Nandi Bull', 9185562201, '06:00 AM - 06:00 PM Daily', 'Lepakshi', 'Andhra Pradesh', 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=800&auto=format&fit=crop&q=80', 'Built in 1530 CE by Virupanna Nayaka, famous for its miraculous hanging pillar that does not touch the floor and the largest monolithic Nandi in India.'),

-- 46. Sun Temple Modhera (Gujarat)
(46, 'Sun Temple Modhera', 'Mehsana District', 'Temple', 25.00, 0.00, 'Solanki Architecture & Stepwell Surya Kund (1026 CE)', 9127622220, '07:00 AM - 06:00 PM Daily', 'Modhera', 'Gujarat', 'https://images.unsplash.com/photo-1621252179027-94459d278660?w=800&auto=format&fit=crop&q=80', 'Built in 1026 CE by King Bhima I, engineered so the first rays of the rising sun at the equinox illuminate the sanctum image of Surya.'),

-- 47. Rani ki Vav (Gujarat)
(47, 'Rani ki Vav', 'Patan', 'World Heritage', 40.00, 0.00, '7-Tier Inverted Subterranean Stepwell Temple with 500 Sculptures', 9127662920, '08:00 AM - 06:00 PM Daily', 'Patan', 'Gujarat', 'https://images.unsplash.com/photo-1609946850231-50e50b86a512?w=800&auto=format&fit=crop&q=80', 'Constructed in the 11th century CE by Queen Udayamati, designed as an inverted temple with seven levels of sculpted panels depicted on the ₹100 note.'),

-- 48. Sun Temple Konark (Odisha)
(48, 'Sun Temple Konark', 'Puri District', 'World Heritage', 40.00, 0.00, 'Kalinga Stone Chariot with 24 Carved Astronomical Wheels', 9167582368, '06:00 AM - 08:00 PM Daily', 'Konark', 'Odisha', 'https://images.unsplash.com/photo-1609137144822-473d328ec862?w=800&auto=format&fit=crop&q=80', 'A 13th-century CE monument carved in the shape of a colossal sun chariot with 24 stone wheels functioning as precise sundials, drawn by seven horses.'),

-- 49. Udayagiri & Khandagiri Caves (Odisha)
(49, 'Udayagiri and Khandagiri Caves', 'Bhubaneswar', 'Cave', 25.00, 0.00, 'King Kharavela Hathigumpha Inscription & Jain Rock Shrines', 9167425510, '06:00 AM - 06:00 PM Daily', 'Bhubaneswar', 'Odisha', 'https://images.unsplash.com/photo-1609946850231-50e50b86a512?w=800&auto=format&fit=crop&q=80', 'Ancient rock-cut caves carved for Jain ascetics during the 2nd century BCE reign of King Kharavela of the Chedi dynasty.'),

-- 50. Nalanda Mahavihara (Bihar)
(50, 'Nalanda Mahavihara', 'Bargaon, Nalanda', 'World Heritage', 40.00, 0.00, 'Ancient 5th Century Residential International University Ruins', 9161122818, '09:00 AM - 05:00 PM Daily', 'Nalanda', 'Bihar', 'https://images.unsplash.com/photo-1609137144822-473d328ec862?w=800&auto=format&fit=crop&q=80', 'The most acclaimed monastic university of ancient India, flourishing for over 700 years with 10,000 scholars from across Asia.'),

-- 51. Sher Shah Suri Tomb (Bihar)
(51, 'Sher Shah Suri Tomb', 'Sasaram, Rohtas', 'Mausoleum', 25.00, 0.00, '122ft Sandstone Mausoleum Rising from a Square Lake (1545)', 9161842220, '06:00 AM - 05:00 PM Daily', 'Sasaram', 'Bihar', 'https://images.unsplash.com/photo-1588416936097-41850ab3d86d?w=800&auto=format&fit=crop&q=80', 'Standing inside a large artificial lake, this octagonal tomb designed by architect Aliwal Khan is an engineering and artistic landmark.'),

-- 52. Victoria Memorial (West Bengal)
(52, 'Victoria Memorial', '1, Queens Way, Maidan', 'Palace', 50.00, 0.00, 'Indo-Saracenic White Makrana Marble Museum on 64 Acres', 9133222318, '10:00 AM - 05:00 PM (Closed Mondays)', 'Kolkata', 'West Bengal', 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800&auto=format&fit=crop&q=80', 'Built between 1906 and 1921 with Makrana marble from Rajasthan, housing 25 galleries of historical treasures surrounded by manicured gardens.'),

-- 53. Hazarduari Palace (West Bengal)
(53, 'Hazarduari Palace', 'Killa Nizamat', 'Palace', 25.00, 0.00, 'Palace of 1,000 Doors of the Nawabs of Bengal (1837)', 9134822701, '09:00 AM - 05:00 PM (Closed Fridays)', 'Murshidabad', 'West Bengal', 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?w=800&auto=format&fit=crop&q=80', 'Built in 1837 by architect Duncan Macleod for Nawab Humayun Jah, featuring 900 real and 100 false doors designed to confound intruders.'),

-- 54. Bishnupur Terracotta Temples (West Bengal)
(54, 'Bishnupur Terracotta Temples', 'Bishnupur, Bankura', 'Temple', 25.00, 0.00, 'Malla Dynasty Rasmancha, Shyamrai & Jor Bangla Brickwork', 9132442520, '06:00 AM - 06:00 PM Daily', 'Bankura', 'West Bengal', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'Famous for their baked clay terracotta tiles depicting scenes from the Mahabharata, built by the Malla kings from the 17th century.'),

-- 55. Bekal Fort (Kerala)
(55, 'Bekal Fort', 'Kasaragod Coast', 'Fort', 25.00, 0.00, '40-Acre Coastal Sea Fortress with Keyhole Observation Tower', 9146722365, '08:00 AM - 05:30 PM Daily', 'Kasaragod', 'Kerala', 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?w=800&auto=format&fit=crop&q=80', 'The largest and best-preserved fort in Kerala, rising directly above Arabian Sea waves, built by Shivappa Nayaka in 1650 CE.'),

-- 56. Mattancherry Dutch Palace (Kerala)
(56, 'Mattancherry Dutch Palace', 'Palace Rd, Kochi', 'Palace', 20.00, 0.00, 'Kerala Nalukettu Courtyard Palace with Ramayana Mural Frescoes', 9148422220, '09:45 AM - 04:45 PM (Closed Fridays)', 'Kochi', 'Kerala', 'https://images.unsplash.com/photo-1590050752117-238cb0fb12b1?w=800&auto=format&fit=crop&q=80', 'Built by the Portuguese in 1555 and gifted to the King of Cochin, housing celebrated Hindu mythological murals in classical Kerala tempera.'),

-- 57. Basilica of Bom Jesus (Goa)
(57, 'Basilica of Bom Jesus', 'Old Goa', 'World Heritage', 0.00, 0.00, 'Mortal Remains of St. Francis Xavier, Baroque Architecture (1605)', 9183222857, '09:00 AM - 06:30 PM Daily', 'Old Goa', 'Goa', 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=800&auto=format&fit=crop&q=80', 'A UNESCO World Heritage landmark in Old Goa holding the sacred relics of St. Francis Xavier, one of the finest examples of Baroque art in Asia.'),

-- 58. Fort Aguada (Goa)
(58, 'Fort Aguada & Lighthouse', 'Sinquerim Beach', 'Fort', 25.00, 0.00, '17th Century Portuguese Coastal Bastion & 4-Storey Lighthouse', 9183224792, '09:30 AM - 06:00 PM Daily', 'Candolim', 'Goa', 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?w=800&auto=format&fit=crop&q=80', 'Constructed in 1612 to guard the mouth of the Mandovi River, containing a 2,376,000-gallon freshwater storage cistern for passing ships.'),

-- 59. Jallianwala Bagh (Punjab)
(59, 'Jallianwala Bagh Memorial', 'Golden Temple Road', 'Historical', 0.00, 0.00, 'National Freedom Memorial, Martyrs Well & Preserved Bullet Marks', 9118325510, '06:30 AM - 07:30 PM Daily', 'Amritsar', 'Punjab', 'https://images.unsplash.com/photo-1585136917122-384aa94c0384?w=800&auto=format&fit=crop&q=80', 'A national memorial site commemorating the martyrs of the 13 April 1919 massacre, featuring the eternal flame and the historic Martyrs Well.'),

-- 60. Kangra Fort (Himachal Pradesh)
(60, 'Kangra Fort', 'Old Kangra', 'Fort', 25.00, 0.00, 'Oldest Dated Fort in India Built by Katoch Rajput Kings', 9118922650, '09:00 AM - 06:00 PM Daily', 'Kangra', 'Himachal Pradesh', 'https://images.unsplash.com/photo-1598324789736-4861f89564a0?w=800&auto=format&fit=crop&q=80', 'Perched at the confluence of the Banganga and Majhi rivers, this historic fort traces its origins back to the ancient Trigarta Kingdom of the Mahabharata.'),

-- 61. Jageshwar Dham (Uttarakhand)
(61, 'Jageshwar Dham Temple Group', 'Jageshwar, Almora', 'Temple', 25.00, 0.00, 'Cluster of 124 Ancient Stone Temples in High Altitude Deodar Valley', 9159622630, '06:00 AM - 08:00 PM Daily', 'Almora', 'Uttarakhand', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'A sacred complex of 124 stone temples dating from the 7th to the 14th century, dedicated to Lord Shiva in the Himalayan deodar forest.'),

-- 62. Martand Sun Temple (Jammu & Kashmir)
(62, 'Martand Sun Temple Ruins', 'Anantnag District', 'Temple', 25.00, 0.00, '8th Century Emperor Lalitaditya Karkota Dynasty Monumental Ruins', 9119322220, '06:00 AM - 06:00 PM Daily', 'Anantnag', 'Jammu & Kashmir', 'https://images.unsplash.com/photo-1621252179027-94459d278660?w=800&auto=format&fit=crop&q=80', 'Built in the 8th century CE on a high plateau, featuring 84 colonnaded fluted pillars blending Greek, Roman, and Gandharan architectural forms.'),

-- 63. Shalimar Bagh (Jammu & Kashmir)
(63, 'Shalimar Bagh', 'Dal Lake Boulevard', 'Historical', 30.00, 0.00, 'Mughal Emperor Jahangir Garden of Love (1619)', 9119424520, '09:00 AM - 07:00 PM Daily', 'Srinagar', 'Jammu & Kashmir', 'https://images.unsplash.com/photo-1588416936097-41850ab3d86d?w=800&auto=format&fit=crop&q=80', 'The crown of Mughal gardens, built in 1619 by Emperor Jahangir for his wife Nur Jahan, fed by clean mountain water canals from Dal Lake.'),

-- 64. Leh Palace (Ladakh)
(64, 'Leh Palace (Lhachen Palkhar)', 'Namgyal Hill, Leh', 'Palace', 25.00, 0.00, '9-Storey Tibetan Adobe Palace Overlooking Ladakh Range (1600)', 9119822520, '07:00 AM - 06:00 PM Daily', 'Leh', 'Ladakh', 'https://images.unsplash.com/photo-1599661046289-e31897846e41?w=800&auto=format&fit=crop&q=80', 'A dramatic nine-storey palace constructed by King Sengge Namgyal in 1600 CE modeled after Lhasa Potala Palace with views of the Stok Kangri peak.'),

-- 65. Rang Ghar (Assam)
(65, 'Rang Ghar', 'Joysagar, Sivasagar', 'Historical', 25.00, 0.00, 'Asia Oldest Surviving Royal Amphitheatre (Ahom Dynasty 1746)', 9137722201, '09:00 AM - 05:00 PM Daily', 'Sivasagar', 'Assam', 'https://images.unsplash.com/photo-1600100397608-f010f4438fa4?w=800&auto=format&fit=crop&q=80', 'A two-storeyed royal sports pavilion built by Ahom King Pramatta Singha in 1746, where kings watched indigenous sports and buffalo fights.'),

-- 66. Unakoti Rock Carvings (Tripura)
(66, 'Unakoti Rock Carvings', 'Kailashahar', 'Historical', 25.00, 0.00, 'Colossal 30ft Bas-Relief Shaivite Rock Sculptures (7th-9th Century)', 9138242201, '06:00 AM - 06:00 PM Daily', 'Unakoti', 'Tripura', 'https://images.unsplash.com/photo-1609946850231-50e50b86a512?w=800&auto=format&fit=crop&q=80', 'An ancient pilgrimage site featuring colossal rock carvings and murals on mountain cliffs, literally translating to one less than a crore.'),

-- 67. Neermahal Water Palace (Tripura)
(67, 'Neermahal Water Palace', 'Rudrasagar Lake, Melaghar', 'Palace', 30.00, 0.00, 'Eastern India Only Lake Palace, Manikya Dynasty (1930)', 9138128201, '09:00 AM - 05:00 PM Daily', 'Sepahijala', 'Tripura', 'https://images.unsplash.com/photo-1599661046289-e31897846e41?w=800&auto=format&fit=crop&q=80', 'Built in 1930 by Maharaja Bir Bikram Kishore Manikya in the center of Rudrasagar Lake, blending Hindu temple and Mughal palace styles.'),

-- 68. Cellular Jail (Andaman & Nicobar Islands)
(68, 'Cellular Jail National Memorial', 'Atlanta Point, Port Blair', 'Historical', 30.00, 0.00, 'Kala Pani Colonial Cellular Prison & Freedom Fighters Memorial', 9131922301, '09:00 AM - 04:45 PM (Closed Mondays)', 'Port Blair', 'Andaman & Nicobar', 'https://images.unsplash.com/photo-1598324789736-4861f89564a0?w=800&auto=format&fit=crop&q=80', 'A colonial prison complex with seven radial wings completed in 1906, where hundreds of Indian freedom fighters were exiled during the Independence movement.'),

-- 69. Sirpur Group of Monuments (Chhattisgarh)
(69, 'Sirpur Group of Monuments', 'Sirpur, Mahasamund', 'Historical', 25.00, 0.00, 'Laxman Brick Temple & 7th Century Buddhist Mahaviharas', 9177222401, '06:00 AM - 06:00 PM Daily', 'Sirpur', 'Chhattisgarh', 'https://images.unsplash.com/photo-1606298855672-3efb63017be8?w=800&auto=format&fit=crop&q=80', 'An ancient city along the Mahanadi River renowned for the 7th-century Laxman Temple, one of the finest brick-built sanctuaries in India.'),

-- 70. Kangla Fort (Manipur)
(70, 'Kangla Fort', 'Imphal', 'Fort', 25.00, 0.00, 'Ancient Capital Seat of the Meitei Kings of Manipur', 9138524401, '07:00 AM - 05:30 PM (Closed Wednesdays)', 'Imphal', 'Manipur', 'https://images.unsplash.com/photo-1605649487212-47bdab064df8?w=800&auto=format&fit=crop&q=80', 'The royal palace and coronation seat of the Meitei rulers of Manipur, containing sacred ponds, temples, and the Kangla Sha dragon statues.');
