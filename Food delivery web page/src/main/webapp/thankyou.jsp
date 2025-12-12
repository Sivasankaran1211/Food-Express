<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Thank You</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />
  
  
  <style>
    body {
      background: linear-gradient(135deg, #fff7ea 0%, #ffe5d6 40%, #ffd2c8 100%);
      font-family: "Segoe UI", Arial, sans-serif;
      color: #2f1b0f;
      margin: 0;
      padding: 0;
    }
    
          /* Top navigation */
    header {
      width: 100%;
      background: linear-gradient(120deg, #ff7a3c, #ffb545);
      box-shadow: 0 4px 14px rgba(0, 0, 0, 0.12);
      position: sticky;
      top: 0;
      z-index: 100;
    }
    .nav-bar {
      max-width: 1100px;
      margin: 0 auto;
      padding: 0.7rem 1.5rem;
      display: flex;
      align-items: center;
    }
    .logo {
      font-size: 1.4rem;
      font-weight: 700;
      color: #fff5e6;
      text-transform: uppercase;
      letter-spacing: 1px;
    }
    .logo span {
      color: #ffe066;
    }
    .nav-links {
      margin-left: auto;
      display: flex;
      gap: 1rem;
      align-items: center;
    }
    .nav-links a {
      position: relative;
      padding: 0.4rem 0.9rem;
      text-decoration: none;
      color: #fffdf6;
      font-size: 0.95rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-radius: 999px;
      overflow: hidden;
      transition: color 0.3s ease, transform 0.3s ease;
    }
    .nav-links a::before {
      content: "";
      position: absolute;
      inset: 0;
      background: radial-gradient(circle at top left, #ffffff55, transparent 60%);
      transform: translateX(-100%);
      transition: transform 0.35s ease;
      z-index: -1;
    }
    .nav-links a:hover,
    .nav-links a:focus-visible {
      color: #4a2507;
      transform: translateY(-2px);
      outline: none;
    }
    .nav-links a:hover::before,
    .nav-links a:focus-visible::before {
      transform: translateX(0);
    }
    .nav-links i {
      margin-right: 4px;
    }

 
    
    .prev-icon {
  color: #fff;
  font-size: 20px;
  margin-right: 20px;
  cursor: pointer;
  display: flex;
  align-items: center;
  text-decoration: none;
}

.nav-bar {
  display: flex;
  align-items: center;
}
    
    
 

    .wrapper {
      max-width: 800px;
      margin: 2.8rem auto;
      padding: 2rem 2rem 2.4rem;
      background: #fff8f1;
      border-radius: 18px;
      box-shadow: 0 10px 32px rgba(0,0,0,0.10);
      text-align: center;
    }
    .icon-circle {
      width: 70px;
      height: 70px;
      border-radius: 50%;
      background: #42c97b;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1.1rem;
      color: #fff;
      font-size: 32px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.18);
    }
    h1 {
      font-size: 2rem;
      color: #cb6500;
      margin-bottom: 0.4rem;
    }
    .subtitle {
      font-size: 0.98rem;
      color: #7a4c34;
      margin-bottom: 1.4rem;
    }
    .order-info {
      background: #fffdf8;
      border-radius: 14px;
      padding: 1rem 1.2rem;
      border: 1px dashed #ffd3a8;
      margin-bottom: 1.5rem;
      font-size: 0.95rem;
      color: #5b3420;
    }
    .order-info span.label {
      font-weight: 600;
      color: #8a4a0b;
    }

    .suggestion-title {
      font-size: 1rem;
      font-weight: 600;
      color: #7a3f15;
      margin-bottom: 0.6rem;
      margin-top: 0.8rem;
    }
    .chips {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 0.4rem;
      margin-bottom: 1.8rem;
    }
    .chip {
      padding: 0.25rem 0.8rem;
      border-radius: 999px;
      background: #ffe6d3;
      color: #8b3c21;
      font-size: 0.85rem;
    }

    .btn-row {
      display: flex;
      justify-content: center;
      gap: 1rem;
      flex-wrap: wrap;
    }
    .btn {
      border-radius: 999px;
      padding: 0.7rem 1.8rem;
      font-size: 0.98rem;
      font-weight: 600;
      cursor: pointer;
      border: none;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 0.4rem;
    }
    .btn-primary {
      background: linear-gradient(120deg, #ff7a3c, #ffb545);
      color: #3a1604;
      box-shadow: 0 6px 16px rgba(0,0,0,0.16);
    }
    .btn-secondary {
      background: #fff;
      color: #a35a12;
      border: 1px solid #ffb545;
    }
  </style>
</head>
<body>

  <header>
    <div class="nav-bar">
    
    	 <a class="prev-icon" onclick="window.history.back()" title="Go Back">
      <i class="fa fa-arrow-left"></i>
    </a>
    
    
      <div class="logo">Food<span>Express</span></div>
      <nav class="nav-links">
        <a href="Restaurant" class="active"><i class="fa fa-home"></i>Home</a>
		<a href="cart"><i class="fa fa-shopping-cart"></i>Cart</a>
        <a href="#"><i class="fa fa-heart"></i>Favorite</a>
         <a href="yourOrders"><i class="fa fa-list"></i>Your Order</a>
      </nav>
    </div>
  </header>

<div class="wrapper">
  <div class="icon-circle">
    <i class="fa fa-check"></i>
  </div>
  <h1>Thank You for Your Order!</h1>
  <p class="subtitle">
    Your delicious meal is being prepared. You’ll receive an update once it’s out for delivery.
  </p>

<div><span class="label">Order ID:</span> ${orderId}</div>
<div><span class="label">Expected Delivery:</span> ${eta}</div>


  <div class="suggestion-title">
    People also order:
  </div>
  <div class="chips">
    <span class="chip">Extra Cheese</span>
    <span class="chip">Gulab Jamun</span>
    <span class="chip">Cold Coffee</span>
    <span class="chip">French Fries</span>
  </div>

  <div class="btn-row">
    <a href="Restaurant" class="btn btn-primary">
      <i class="fa fa-home"></i>
      Back to Home
    </a>
    <a href="yourOrders" class="btn btn-secondary">
  <i class="fa fa-shopping-bag"></i>
  View Orders
</a>
	
	  <a href="invoice?orderId=${orderId}" class="btn btn-secondary">
    <i class="fa fa-file-pdf-o"></i>
    Download Invoice
  </a>
	
  </div>
</div>

</body>
</html>
