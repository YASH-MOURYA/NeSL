<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Success</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="success-page">
<div class="page">
    <div class="card">
        <h1>Login Successful</h1>
        <p>Your request was processed using the selected login category.</p>
        <div class="field"><strong>Login Type:</strong> ${loginType}</div>
        <div class="field"><strong>User ID:</strong> ${userId}</div>
        <div class="field"><strong>Password:</strong> ${password}</div>
        <div class="field"><strong>UIN / PAN:</strong> ${uin}</div>
        <a class="link" href="/login">Back to Login</a>
    </div>
</div>
</body>
</html>