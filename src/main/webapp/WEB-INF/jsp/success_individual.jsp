<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Individual Login Success</title>
    <style>
        body { font-family: Arial, sans-serif; background: #124e3d; color: #f0f7ef; margin: 0; padding: 0; }
        .page { min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 40px; }
        .card { max-width: 600px; border-radius: 18px; background: rgba(255,255,255,.08); border: 1px solid rgba(255,255,255,.14); padding: 38px; text-align: center; }
        h1 { margin-bottom: 14px; font-size: 32px; }
        p { margin: 10px 0; font-size: 16px; }
        .badge { margin-top: 18px; display: inline-block; padding: 12px 24px; background: #2f8a67; border-radius: 999px; font-weight: 700; }
        .link { display: inline-block; margin-top: 24px; color: #fff; text-decoration: none; border: 1px solid rgba(255,255,255,.35); padding: 12px 22px; border-radius: 999px; }
    </style>
</head>
<body>
<div class="page">
    <div class="card">
        <h1>Individual Dashboard</h1>
        <p>You are logged in as an individual user.</p>
        <p>Category: <strong>${loginType}</strong></p>
        <div class="badge">Individual Access</div>
        <div>
            <a class="link" href="/login">Return to Login</a>
        </div>
    </div>
</div>
</body>
</html>