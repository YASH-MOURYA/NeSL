<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="error-page">
<div class="page">
    <div class="card">
        <h1>Login Failed</h1>
        <p>There was a problem signing in.</p>
        <div class="error-box">${errorMessage}</div>
        <div>
            <a class="link" href="/login">Try Again</a>
        </div>
    </div>
</div>
</body>
</html>
