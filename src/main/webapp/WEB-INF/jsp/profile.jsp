<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NeSL | Profile</title>
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
                    <h1>Profile Settings</h1>
                    <p>Update your account information</p>
                </div>

                <c:if test="${not empty successMessage}">
                    <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 20px;">
                        ${successMessage}
                    </div>
                </c:if>

                <form method="POST" action="/profile" novalidate>
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />

                    <div class="form-group">
                        <div class="field-label">Name <span class="req">*</span></div>
                        <div class="input-shell">
                            <div class="input-icon">👤</div>
                            <input type="text" name="name" value="${user.name}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="field-label">User ID</div>
                        <div class="input-shell">
                            <div class="input-icon">🆔</div>
                            <input type="text" value="${user.userId}" readonly style="background: #f5f5f5;">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="field-label">Email <span class="req">*</span></div>
                        <div class="input-shell">
                            <div class="input-icon">📧</div>
                            <input type="email" name="email" value="${user.email}" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="field-label">Role</div>
                        <div class="input-shell">
                            <div class="input-icon">🏷️</div>
                            <input type="text" value="${user.role}" readonly style="background: #f5f5f5;">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="field-label">UIN / PAN</div>
                        <div class="input-shell">
                            <div class="input-icon">🆔</div>
                            <input type="text" name="uin" value="${user.uin}">
                        </div>
                    </div>

                    <div class="actions" style="margin-top: 30px;">
                        <button type="submit" class="btn-signin" style="width: 100%;">Update Profile</button>
                    </div>

                </form>

            </div>
        </div>
    </main>

</body>
</html>