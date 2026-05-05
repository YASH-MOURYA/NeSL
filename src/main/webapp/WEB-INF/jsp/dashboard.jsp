<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NeSL | Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <!-- ── HEADER ── -->
    <header class="header">
        <div class="logo-wrap">
            <div class="logo-mark">Ne<span class="accent-sl">SL<sup>®</sup></span></div>
            <div class="logo-divider"></div>
            <div class="logo-tagline">National E-Governance<br>Services Limited</div>
        </div>
        <div class="header-actions">
            <span class="user-info">Welcome, ${username}!</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <!-- ── MAIN ── -->
    <main class="main">
        <div class="dashboard-container">
            <div class="dashboard-header">
                <h1>Dashboard</h1>
                <p>Manage your NeSL services and account</p>
            </div>

            <div class="dashboard-grid">
                <div class="dashboard-card">
                    <div class="card-icon">👤</div>
                    <h3>Profile</h3>
                    <p>View and update your profile information</p>
                    <a href="${pageContext.request.contextPath}/profile" class="card-link">View Profile</a>
                </div>

                <sec:authorize access="hasRole('ADMIN') or hasRole('MANAGER')">
                <div class="dashboard-card">
                    <div class="card-icon">👥</div>
                    <h3>User Management</h3>
                    <p>Manage user accounts and permissions</p>
                    <a href="${pageContext.request.contextPath}/users" class="card-link">Manage Users</a>
                </div>
                </sec:authorize>

                <div class="dashboard-card">
                    <div class="card-icon">📊</div>
                    <h3>Reports</h3>
                    <p>View system reports and analytics</p>
                    <a href="${pageContext.request.contextPath}/reports" class="card-link">View Reports</a>
                </div>

                <div class="dashboard-card">
                    <div class="card-icon">⚙️</div>
                    <h3>Settings</h3>
                    <p>Configure your account settings</p>
                    <a href="${pageContext.request.contextPath}/settings" class="card-link">Account Settings</a>
                </div>

                <div class="dashboard-card">
                    <div class="card-icon">📞</div>
                    <h3>Support</h3>
                    <p>Get help and contact support</p>
                    <a href="${pageContext.request.contextPath}/support" class="card-link">Contact Support</a>
                </div>

                <div class="dashboard-card">
                    <div class="card-icon">📱</div>
                    <h3>Notifications</h3>
                    <p>View your notifications</p>
                    <a href="${pageContext.request.contextPath}/notifications" class="card-link">View Notifications</a>
                </div>
            </div>
        </div>
    </main>

    <!-- Chatbot Popup -->
    <div id="chatbot-popup" class="chatbot-popup">
        <div class="chatbot-header">
            <span class="chatbot-title">NeSL Assistant</span>
            <button class="chatbot-close" onclick="closeChatbot()">&times;</button>
        </div>
        <div id="chatbot-messages" class="chatbot-messages">
            <div class="message bot-message">
                <div class="message-content">Hello! I'm your NeSL assistant. How can I help you today?</div>
            </div>
        </div>
        <div class="chatbot-input">
            <input type="text" id="chatbot-input-field" placeholder="Type your message..." onkeypress="handleKeyPress(event)">
            <button onclick="sendMessage()">Send</button>
        </div>
    </div>

    <button class="chatbot-toggle" onclick="toggleChatbot()">
        <span class="chat-icon">💬</span>
    </button>

    <script>
        let chatbotOpen = false;

        function toggleChatbot() {
            const popup = document.getElementById('chatbot-popup');
            chatbotOpen = !chatbotOpen;
            popup.style.display = chatbotOpen ? 'flex' : 'none';
        }

        function closeChatbot() {
            document.getElementById('chatbot-popup').style.display = 'none';
            chatbotOpen = false;
        }

        function sendMessage() {
            const input = document.getElementById('chatbot-input-field');
            const message = input.value.trim();
            if (message) {
                addMessage('user', message);
                input.value = '';

                // Simple bot responses
                setTimeout(() => {
                    const response = getBotResponse(message);
                    addMessage('bot', response);
                }, 500);
            }
        }

        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }

        function addMessage(sender, content) {
            const messages = document.getElementById('chatbot-messages');
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${sender}-message`;
            messageDiv.innerHTML = `<div class="message-content">${content}</div>`;
            messages.appendChild(messageDiv);
            messages.scrollTop = messages.scrollHeight;
        }

        function getBotResponse(message) {
            const responses = {
                'hello': 'Hello! How can I assist you with NeSL services?',
                'help': 'I can help you with account management, password reset, service inquiries, and general support.',
                'password': 'For password issues, please contact our support team at support@nesl.com',
                'login': 'Having trouble logging in? Make sure you\'re using the correct user ID and password for your role.',
                'default': 'I\'m here to help! Please provide more details about your question.'
            };

            const lowerMessage = message.toLowerCase();
            for (const [key, response] of Object.entries(responses)) {
                if (lowerMessage.includes(key)) {
                    return response;
                }
            }
            return responses.default;
        }
    </script>

</body>
</html>