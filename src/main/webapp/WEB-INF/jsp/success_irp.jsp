<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>IRP Login Success</title>
    <style>
        body { font-family: Arial, sans-serif; background: #1f3d7a; color: #eef3ff; margin: 0; padding: 0; }
        .page { min-height: 100vh; display: flex; justify-content: center; align-items: center; text-align: center; padding: 40px; }
        .card { width: 100%; max-width: 620px; background: rgba(255,255,255,.07); border: 1px solid rgba(255,255,255,.16); border-radius: 18px; padding: 36px; }
        h1 { margin-bottom: 16px; font-size: 32px; }
        p { margin: 10px 0; font-size: 16px; }
        .badge { margin-top: 18px; display: inline-block; padding: 10px 20px; background: #3a75b4; border-radius: 999px; font-weight: 700; }
        .link { display: inline-block; margin-top: 26px; color: #fff; text-decoration: none; border: 1px solid rgba(255,255,255,.35); padding: 12px 22px; border-radius: 999px; }
    </style>
</head>
<body>
<div class="page">
    <div class="card">
        <h1>IRP Dashboard</h1>
        <p>You are signed in as IRP / RP / Liquidator.</p>
        <p>Login Type: <strong>${loginType}</strong></p>
        <p>Your UIN / PAN is <strong>${uin}</strong>.</p>
        <div class="badge">IRP Access</div>
        <div>
            <a class="link" href="/login">Back to Login</a>
        </div>
    </div>
</div>
</body>
</html>