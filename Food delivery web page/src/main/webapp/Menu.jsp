<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.food.FoodItem " %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
     <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />
  
  <title><%= request.getAttribute("restaurantName") %></title>
  <style>
    body {
      background: linear-gradient(135deg, #fff7ea 0%, #ffe5d6 40%, #ffd2c8 100%);
      font-family: "Segoe UI", Arial, sans-serif;
      color: #2f1b0f;
      min-height: 100vh;
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
    
    
    
    
    .container {
      max-width: 950px;
      margin: 2rem auto;
      padding: 1.5rem;
      background: #fff8f2;
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.08);
    }
    h1 {
      font-size: 2.15rem;
      color: #cb6500;
      margin-bottom: 0.3rem;
    }
    .desc {
      margin-bottom: 1.1rem;
      color: #69452e;
      font-size: 1.04rem;
    }
    .menu-table {
      width: 100%;
      border-collapse: collapse;
      background: #fff9f6;
      border-radius: 10px;
      overflow: hidden;
      margin-top:1.2rem;
    }
    .menu-table th, .menu-table td {
      padding: 0.95rem 1rem;
      text-align: left;
      vertical-align: middle;
    }
    .menu-table th {
      background: #ffe1bf;
      color: #814900;
      font-weight: 700;
    }
    .menu-table tr:not(:last-child) {
      border-bottom: 1px solid #ffe2cb;
    }
    .dish-img {
      width: 80px;
      height: 60px;
      object-fit: cover;
      border-radius: 10px;
      box-shadow: 0 2px 8px #ffe2cb;
      margin-right: 8px;
    }
    .dish-available {
      color: #2bbb74;
      font-weight: 600;
    }
    .dish-unavailable {
      color: #cf4336;
      font-weight: 500;
    }
    .add-cart-btn {
      background: linear-gradient(90deg, #ff9944, #ffe863);
      color: #4a310d;
      border: none;
      border-radius: 999px;
      padding: 0.55rem 1.3rem;
      font-size: 1rem;
      cursor: pointer;
      font-weight: 600;
      transition: background 0.15s;
    }
    .dish-title {
  font-size: 1.08rem;
  font-weight: 600;
  color: #3a1f12;
  margin-bottom: 0.3rem;
  min-height: 48px; /* NEW: adjust value so 2 lines of text fit */
	}
    
    
    
    
    .add-cart-btn:active {
      background: linear-gradient(80deg, #ffd366, #ffaf48);
    }
    .view-cart {
      display: block;
      margin: 1.8rem 0 0 auto;
      background: #ffb545;
      color: #442210;
      padding: 0.65rem 1.7rem;
      font-size: 1.03rem;
      border-radius: 999px;
      font-weight: 700;
      text-decoration: none;
      text-align: right;
      border: none;
      cursor: pointer;
    }
    .cart-notification {
      color: #24933e;
      margin-top: 0.9rem;
      font-size: 1rem;
    }
    
    .menu-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 1.2rem;
  margin-top: 1.5rem;
}
.dish-card {
  background: #fff9f3;
  border-radius: 16px;
  box-shadow: 0 7px 24px #ffcfa748, 0 1.5px 2px #fff6e4ee;
  padding: 1.1rem 1.2rem;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  border: 1px solid rgba(255, 180, 120, 0.18);
  position: relative;
  overflow: hidden;
  transition: transform 0.23s, box-shadow 0.23s;
}
.dish-card:hover { transform: translateY(-5px); box-shadow: 0 15px 34px #ffdbc410;}
.dish-img {
  width: 100%;
  height: 120px;
  border-radius: 10px;
  object-fit: cover;
  background: #ffd6b3;
  margin-bottom: 0.75rem;
}
.dish-title { font-size: 1.08rem; font-weight: 600; color: #3a1f12; margin-bottom: 0.3rem; }
.rating-price { display: flex; align-items: center; gap: 0.8rem; margin-bottom: 0.15rem;}
.dish-rating { font-size: 0.94rem; color: #a06924;}
.dish-rating i { color: #ffc555; margin-right: 2px;}
.dish-price { font-size: 1rem; font-weight: 500; color: #84321c; }
.availability { font-size: 0.91rem;}
.avail-yes { color: #169c4e; font-weight: 600;}
.avail-no { color: #d43b28; font-weight: 600;}
@media (max-width: 650px) {.menu-grid {grid-template-columns: 1fr;}}
    
    
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


  <div class="container">
  
  
  
   <h1>Welcome to <%= request.getAttribute("restaurantName") %></h1>
  <div class="desc"><%= request.getAttribute("description") %></div>
  
   
<div class="menu-grid">
<%
  List<FoodItem> dishes = (List<FoodItem>) request.getAttribute("dishes");
  if (dishes != null && !dishes.isEmpty()) {
    for(FoodItem item : dishes) {
%>






  <div class="dish-card">
  
  
    <img src="<%= item.getImageUrl() %>" alt="<%= item.getName() %>" class="dish-img" />
    <div class="dish-title"><%= item.getName() %></div>
    <div class="rating-price">
      <div class="dish-rating"><i class="fa fa-star"></i> <%= item.getRatings() %></div>
      <div class="dish-price">₹<%= item.getPrice() %></div>
    </div>
    <div class="availability">
      <% if(item.isAvailable()) { %>
        <span class="avail-yes">Available</span>
      <% } else { %>
        <span class="avail-no">Not Available</span>
      <% } %>
    </div>
    <% if(item.isAvailable()) { %>
<form action="cart" method="get">
    <input type="hidden" name="menuId" value="<%= item.getId() %>">
    <input type="hidden" name="quantity" value="1">
    <input type="hidden" name="restId" value="<%= request.getAttribute("restId") %>">
    <input type="hidden" name="action" value="add">
    <button class="view-cart" onclick="window.location.href='cart'">Add to Cart</button>

</form>

    <% } %>
  </div>
<%
    }
  } else {
%>
  <div>No dishes available right now.</div>
<%
  }
%>
</div>
	
		

				<button class="view-cart" onclick="window.location.href='cart'">View Cart</button>

  	<div class="cart-notification" id="cartMsg"></div>
</div>



</body>
</html>