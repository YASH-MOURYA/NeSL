<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NeSL | Welcome</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=Syne:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body class="home-page">

    <header class="header">
        <div class="logo-wrap">
            <div class="logo-mark">Ne<span class="accent-sl">SL<sup>®</sup></span></div>
            <div class="logo-divider"></div>
            <div class="logo-tagline">National E-Governance<br>Services Limited</div>
        </div>
        <div class="header-badge">
            <span class="badge-dot"></span>
            <span class="badge-txt">Public Access</span>
        </div>
    </header>

    <main class="main home-main">
        <div class="card hero-card">
            <div class="card-stripe"></div>
            <div class="card-body">
                <div class="hero-copy">
                        <div class="locale-switcher">
                            <label for="homeLocaleSelect">Language</label>
                            <select id="homeLocaleSelect" onchange="switchHomeLanguage()">
                                <option value="en">English</option>
                                <option value="hi">हिंदी</option>
                            </select>
                        </div>
                        <h1 id="homeHeading">Welcome to NeSL</h1>
                        <p id="homeSubhead">Please log in to continue.</p>

                        <div class="hero-actions">
                            <a class="btn-signin" id="homeLoginBtn" href="${pageContext.request.contextPath}/login">Login</a>
                        </div>
                    </div>
            </div>
            <footer class="card-footer">
                <div class="reg-row">
                    <span class="reg-label">Need help?</span>
                    <a href="#" class="reg-link">Contact Support</a>
                </div>
            </footer>
        </div>
    </main>

    <footer class="page-footer">
        &copy; 2025 National E-Governance Services Limited &mdash; All rights reserved
    </footer>

    <script>
        const homeTranslations = {
            en: {
                heading: 'Welcome to NeSL',
                subhead: 'Please log in to continue.',
                loginBtn: 'Login'
            },
            hi: {
                heading: 'NeSL में आपका स्वागत है',
                subhead: 'ई-गवर्नेंस सेवाओं के लिए आपका सुरक्षित गेटवे। जारी रखने के लिए लॉगिन करें।',
                loginBtn: 'लॉगिन'
            }
        };

        function switchHomeLanguage() {
            const locale = document.getElementById('homeLocaleSelect').value;
            const text = homeTranslations[locale] || homeTranslations.en;
            document.getElementById('homeHeading').textContent = text.heading;
            document.getElementById('homeSubhead').textContent = text.subhead;
            document.getElementById('homeLoginBtn').textContent = text.loginBtn;
        }

        document.addEventListener('DOMContentLoaded', switchHomeLanguage);
    </script>
</body>
</html>
