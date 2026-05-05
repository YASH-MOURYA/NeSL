<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Form</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page user-form-page">
    <div class="card">
        <h1>${user.id == null ? 'Create User' : 'Edit User'}</h1>
        <form method="post" action="${pageContext.request.contextPath}/users">
            <input type="hidden" name="id" value="${user.id}" />
            <div class="field">
                <label>Name</label>
                <input type="text" name="name" value="${user.name}" required />
            </div>
            <div class="field">
                <label>User ID</label>
                <input type="text" name="userId" value="${user.userId}" required />
            </div>
            <div class="field">
                <label>Email</label>
                <input type="email" name="email" value="${user.email}" required />
            </div>
            <div class="field">
                <label>Role</label>
                <select name="role" required>
                    <c:forEach items="${roles}" var="roleOption">
                        <option value="${roleOption}" ${user.role == roleOption ? 'selected' : ''}>${roleOption}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="field">
                <label>UIN / PAN</label>
                <input type="text" name="uin" value="${user.uin}" />
            </div>
            <div class="field">
                <label>Password</label>
                <input type="password" name="password" value="${user.password}" required />
            </div>
            <div class="actions">
                <button type="submit" class="btn-signin">Save</button>
                <a class="link" href="${pageContext.request.contextPath}/users">Cancel</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
