<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page user-list-page">
    <div class="card">
        <h1>User Management</h1>
        <p>Manage all users in the application. Use the buttons below to add, edit, or delete accounts.</p>
        <a class="link" href="${pageContext.request.contextPath}/users/new">Create New User</a>
        <table class="data-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>UIN / PAN</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.userId}</td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>${user.role}</td>
                    <td>${user.uin}</td>
                    <td>
                        <a class="action-link" href="${pageContext.request.contextPath}/users/edit/${user.id}">Edit</a>
                        <a class="action-link" href="${pageContext.request.contextPath}/users/delete/${user.id}">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
