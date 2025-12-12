<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login | FoodExpress</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    body {
      margin: 0;
      font-family: "Segoe UI", Arial, sans-serif;
      background: linear-gradient(135deg, #fff7ea 0%, #ffe5d6 40%, #ffd2c8 100%);
      color: #2f1b0f;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .auth-card {
      width: 360px;
      background: #fff8f1;
      border-radius: 18px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.12);
      padding: 2rem 2.2rem 2.1rem;
      text-align: center;
    }
    .logo-text {
      font-size: 1.6rem;
      font-weight: 700;
      margin-bottom: 0.2rem;
      color: #ff7a3c;
    }
    .logo-text span { color: #ffb545; }
    .tagline {
      font-size: 0.9rem;
      color: #7b4a32;
      margin-bottom: 1.4rem;
    }
    h2 {
      margin: 0 0 1rem;
      font-size: 1.4rem;
      color: #cb6500;
    }
    .field {
      text-align: left;
      margin-bottom: 0.9rem;
    }
    label {
      display: block;
      font-size: 0.86rem;
      margin-bottom: 0.25rem;
      color: #5b3520;
    }
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 0.45rem 0.65rem;
      border-radius: 8px;
      border: 1px solid #ffd3a8;
      background: #fffdf8;
      font-size: 0.96rem;
      box-sizing: border-box;
    }
    .btn-primary {
      width: 100%;
      margin-top: 0.8rem;
      border-radius: 999px;
      border: none;
      padding: 0.65rem 0;
      background: linear-gradient(120deg, #ff7a3c, #ffb545);
      color: #3a1604;
      font-weight: 700;
      cursor: pointer;
      box-shadow: 0 6px 16px rgba(0,0,0,0.16);
      display: inline-flex;
      justify-content: center;
      align-items: center;
      gap: 0.45rem;
      font-size: 0.98rem;
    }
    .link-text {
      margin-top: 1.1rem;
      font-size: 0.86rem;
      color: #7a4c34;
    }
    .link-text a {
      color: #cb6500;
      text-decoration: none;
      font-weight: 600;
    }
    .error {
      margin-top: 0.5rem;
      font-size: 0.85rem;
      color: #d9392e;
    }
  </style>
</head>
<body>

<div class="auth-card">
  <div class="logo-text">Food<span>Express</span></div>
  <div class="tagline">Sign in to enjoy your favourite meals</div>

  <h2>Welcome Back</h2>

  <form action="login" method="post">
    <div class="field">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" required>
    </div>
    <div class="field">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required>
    </div>
    <button type="submit" class="btn-primary">
      <i class="fa fa-sign-in"></i>
      Login
    </button>
  </form>

  <div class="error">
    <%= request.getAttribute("error") == null ? "" : request.getAttribute("error") %>
  </div>

  <div class="link-text">
    New here?
    <a href="register.jsp">Create an account</a>
  </div>
</div>

</body>
</html>
