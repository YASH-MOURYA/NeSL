<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NeSL | ${pageTitle}</title>
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
            <a href="${pageContext.request.contextPath}/dashboard" class="logout-btn">Back to Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <!-- ── MAIN ── -->
    <main class="main">
        <div class="card" style="max-width: 600px;">
            <div class="card-stripe"></div>
            <div class="card-body">

                <div class="section-head">
                    <h1>${pageTitle}</h1>
                    <p>${message}</p>
                </div>

                <div style="text-align: center; margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn-signin" style="text-decoration: none; display: inline-block;">Back to Dashboard</a>
                </div>

            </div>
        </div>
    </main>

</body>
</html>