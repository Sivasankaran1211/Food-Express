<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="java.util.*, com.food.CartItem , com.food.Cart" %>
    
    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />
  <title>Food Cart</title>
  <style>
    body {
      background: linear-gradient(135deg, #fff7ea 0%, #ffe5d6 40%, #ffd2c8 100%);
      font-family: "Segoe UI", Arial, sans-serif;
      color: #2f1b0f;
      min-height: 100vh;
      margin: 0;
      padding: 0;
    }

          
    
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
      max-width: 700px;
      margin: 2.5rem auto;
      padding: 1.5rem 1.2rem;
      background: #fff8f1;
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.08);
    }
    h2 {
      color: #cb6500;
      margin-bottom: 1.2rem;
      font-size: 2rem;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff9f6;
    }
    th, td {
      padding: 0.8rem 1rem;
      text-align: left;
    }
    th {
      background: #ffe1bf;
      color: #814900;
      font-weight: 700;
    }
    tr:not(:last-child) td {
      border-bottom: 1px solid #ffe2cb;
    }
    .qty-btn {
      padding: 0.15rem 0.7rem;
      font-size: 1.1rem;
      border-radius: 6px;
      border: 1px solid #ffb545;
      background: #fffbe6;
      color: #a07025;
      cursor: pointer;
      transition: background 0.15s;
      margin: 0 0.25rem;
    }
    .delete-btn {
      background: #ff726f;
      color: #fff;
      border: none;
      border-radius: 6px;
      padding: 0.3rem 0.7rem;
      cursor: pointer;
      font-size: 1rem;
      transition: background 0.15s;
      margin-left: 0.5rem;
    }
    .delete-btn:hover {
      background: #fa3a3a;
    }
    .total-row td {
      font-weight: 700;
      color: #a65c00;
      font-size: 1.08rem;
      border-top: 2px solid #ffb545;
    }
    .empty {
      color: #a5350e;
      text-align: center;
      padding: 2.2rem 0;
      font-size: 1.15rem;
    }
    .back-link {
      color: #fff;
      background: #ffb545;
      display: inline-block;
      margin: 1.5rem 0 0 0;
      padding: 0.7rem 1.7rem;
      border-radius: 999px;
      font-weight: bold;
      text-decoration: none;
    }
    .back-link:hover {
      background: #ffa232;
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
        <a href="Restaurant" class="active" ><i class="fa fa-home"></i>Home</a>
       <a href="cart"><i class="fa fa-shopping-cart"></i>Cart</a>
        <a href="#"><i class="fa fa-heart"></i>Favorite</a>
        <a href="#"><i class="fa fa-fire"></i>Hot Deals</a>
      </nav>
    </div>
  </header>

  

<div class="container">
  <h2>Your Cart</h2>

  <%
    Cart cart = (Cart) session.getAttribute("Cart");
    Integer restId = (Integer) session.getAttribute("restId");

    if (cart == null || cart.getItems().isEmpty()) {
  %>
    <div class="empty">Your cart is empty. Start adding items!</div>
  <%
    } else {
      double total = 0.0;
  %>
    <table>
      <thead>
        <tr>
          <th>Item</th>
          <th>Price</th>
          <th>Quantity</th>
          <th>Subtotal</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
  <%
      for (CartItem item : cart.getItems()) {
        double subtotal = item.getPrice() * item.getQuantity();
        total += subtotal;
  %>
        <tr>
          <td>
            <div style="display:flex; align-items:center; gap:0.8rem;">
              <img src="<%= item.getImageUrl() %>" alt="<%= item.getItemName() %>"
                   style="width:60px;height:60px;object-fit:cover;border-radius:8px;">
              <span><%= item.getItemName() %></span>
            </div>
          </td>
          <td>₹<%= item.getPrice() %></td>
          <td>
            <div style="display:flex;align-items:center;gap:0.5rem;">
              <a href="cart?action=update&op=dec&menuId=<%= item.getItemId() %>&restId=<%= restId %>"
                 class="qty-btn" style="text-decoration: none"  >−</a>
              <span><%= item.getQuantity() %></span>
              <a href="cart?action=update&op=inc&menuId=<%= item.getItemId() %>&restId=<%= restId %>"
                 class="qty-btn" style="text-decoration: none"   >+</a>
            </div>
          </td>
          <td>₹<%= String.format("%.2f", subtotal) %></td>
          <td>
            <a href="cart?action=delete&menuId=<%= item.getItemId() %>&restId=<%= restId %>"
               class="delete-btn">
              <i class="fa fa-trash"></i>
            </a>
          </td>
        </tr>
  <%
      }
  %>
        <tr class="total-row">
          <td colspan="3">Total</td>
          <td colspan="2">₹<%= String.format("%.2f", total) %></td>
        </tr>
      </tbody>
    </table>
    
    <div style="margin-top: 1.8rem; display:flex; justify-content:space-between; align-items:center;">
      <% if (restId != null) { %>
        <a href="Menu?id=<%= restId %>" class="back-link">Back to Menu</a>
      <% } else { %>
        <span></span>
      <% } %>

      <form action="checkout" method="get" style="margin:0;">
        <button type="submit"
                style="
                  background: linear-gradient(120deg, #ff7a3c, #ffb545);
                  color: #3a1604;
                  border: none;
                  padding: 0.8rem 2.4rem;
                  border-radius: 999px;
                  font-size: 1rem;
                  font-weight: 700;
                  cursor: pointer;
                  box-shadow: 0 8px 22px rgba(0,0,0,0.18);
                  letter-spacing: 0.5px;
                  display: inline-flex;
                  align-items: center;
                  gap: 0.5rem;
                  transition: transform 0.15s ease, box-shadow 0.15s ease, background 0.15s ease;
                "
                onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 11px 26px rgba(0,0,0,0.22)';"
                onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 8px 22px rgba(0,0,0,0.18)';">
        Checkout
        </button>
      </form>
    </div>

    
    
    
    
    
  <%
    }
  %>
</div>

</body>
</html>
