<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    </main>

    <!-- Official Portal Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <!-- Col 1: About -->
                <div>
                    <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px;">
                        <div class="emblem-badge" style="width: 32px; height: 32px; font-size: 0.9rem;">ASI</div>
                        <h4 style="color: white; font-size: 1.15rem; font-weight: 700;">BharatDarshan Portal</h4>
                    </div>
                    <p style="font-size: 0.88rem; line-height: 1.6; color: #94a3b8;">
                        An initiative of the Archaeological Survey of India (ASI), Ministry of Culture, Government of India. Providing seamless, paperless e-ticketing and authentic cultural heritage exploration for monuments across India.
                    </p>
                </div>

                <!-- Col 2: Quick Links -->
                <div>
                    <h5 class="footer-title">Quick Links</h5>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/monuments">Explore Monuments</a></li>
                        <li><a href="${pageContext.request.contextPath}/monuments?type=World+Heritage">UNESCO World Heritage Sites</a></li>
                        <li><a href="${pageContext.request.contextPath}/my-bookings">My Bookings</a></li>
                    </ul>
                </div>

                <!-- Col 3: Guidelines & Help -->
                <div>
                    <h5 class="footer-title">Visitor Guidelines</h5>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/monuments">Monument Timings &amp; Rules</a></li>
                        <li><a href="${pageContext.request.contextPath}/login">Citizen Login / Portal Access</a></li>
                        <li><a href="${pageContext.request.contextPath}/register">New Visitor Registration</a></li>
                        <li><span style="color: #cbd5e1; font-size: 0.85rem;">ASI Toll-Free: 1800-11-2233</span></li>
                    </ul>
                </div>
            </div>

            <!-- Bottom Copyright & Viva Disclaimer -->
            <div class="footer-bottom">
                <p>
                    &copy; 2026 BharatDarshan &bull; Archaeological Survey of India &bull; IGNOU BCA Final Year Project
                </p>
                <p style="margin-top: 4px; color: #64748b; font-size: 0.75rem;">
                    Designed and built with Java Servlets, JSP (Model 2 MVC), MySQL JDBC, and Pure CSS3 (Strict Zero-JS Architecture).
                </p>
            </div>
        </div>
    </footer>

</body>
</html>
