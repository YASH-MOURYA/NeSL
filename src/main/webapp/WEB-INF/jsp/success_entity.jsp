<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Entity Login Success</title>
    <style>
        body { font-family: Arial, sans-serif; background: #0d2b5e; color: #fff; margin: 0; padding: 0; }
        .page { min-height: 100vh; display: flex; justify-content: center; align-items: center; text-align: center; padding: 40px; }
        .card { max-width: 620px; background: rgba(255,255,255,.08); border: 1px solid rgba(255,255,255,.18); border-radius: 18px; padding: 36px; }
        h1 { margin-bottom: 16px; font-size: 34px; letter-spacing: -1px; }
        p { margin: 12px 0; font-size: 16px; color: #dfe7ff; }
        .badge { display: inline-block; margin-top: 20px; padding: 12px 22px; border-radius: 999px; background: #1f72c7; font-weight: 700; }
        .link { display: inline-block; margin-top: 28px; color: #fff; text-decoration: none; border: 1px solid rgba(255,255,255,.4); padding: 12px 22px; border-radius: 999px; transition: background .2s; }
        .link:hover { background: rgba(255,255,255,.08); }
    </style>
</head>
<body>
<div class="page">
    <div class="card">
        <h1>Entity Dashboard</h1>
        <p>Your entity access has been granted successfully.</p>
        <p>Login Type: <strong>${loginType}</strong></p>
        <p>UIN / PAN: <strong>${uin}</strong></p>
        <div class="badge">Entity Access Granted</div>
        <div>
            <a class="link" href="/login">Return to Login</a>
        </div>
    </div>
</div>
</body>
</html>