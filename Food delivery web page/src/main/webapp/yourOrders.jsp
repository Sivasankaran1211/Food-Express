<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%@ page import="com.food.Order, com.food.OrderItem"%>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    // Change pattern if your created_at format is different
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"); // [web:52][web:54]
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Your Orders | FoodExpress</title>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />
  <style>
    body {
      font-family: "Segoe UI", Arial, sans-serif;
      background: linear-gradient(135deg, #fff7ea 0%, #ffe5d6 40%, #ffd2c8 100%);
      min-height: 100vh;
      margin: 0;
      color: #2f1b0f;
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
    
    


    .page-wrap {
      max-width: 1000px;
      margin: 2rem auto;
      padding: 0 1.5rem 2.5rem;
    }
    h1.page-title {
      font-size: 2rem;
      margin-bottom: 1rem;
      color: #402013;
    }

    .empty-box {
      background: #fff8f1;
      border-radius: 14px;
      padding: 1.5rem 1.2rem;
      text-align: center;
      color: #7a5340;
      box-shadow: 0 8px 22px rgba(0,0,0,0.08);
    }

    .order-card {
      background: #fff8f1;
      border-radius: 16px;
      box-shadow: 0 8px 22px rgba(0,0,0,0.08);
      margin-bottom: 1.5rem;
      overflow: hidden;
      border: 1px solid rgba(255, 180, 120, 0.5);
    }
    .order-header {
      padding: 0.9rem 1.1rem;
      background: #ffe1bf;
      border-bottom: 1px solid #ffe2cb;
    }
    .order-header-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 0.3rem;
    }
    .order-id {
      font-weight: 700;
      color: #814900;
    }
    .order-total {
      font-weight: 700;
      color: #8a4300;
    }
    .order-meta {
      font-size: 0.85rem;
      color: #7b5740;
    }

    .status-pill {
      display: inline-block;
      padding: 0.15rem 0.6rem;
      border-radius: 999px;
      font-size: 0.78rem;
   	  background: #fff0c2;
      color: #b87300;
      margin-left: 0.4rem;
    }
    .status-pill.delivered {
     
      color: #28712a;
    }

    table.items-table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      font-size: 0.9rem;
    }
    table.items-table th,
    table.items-table td {
      padding: 0.6rem 0.9rem;
      border-bottom: 1px solid #ffe2cb;
      text-align: left;
    }
    table.items-table th {
      background: #fff7e2;
      color: #814900;
      font-weight: 600;
    }
    .item-info {
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }
    .item-img {
      width: 50px;
      height: 50px;
      border-radius: 8px;
      object-fit: cover;
      background: #ffd6b3;
    }
    
    .status-pill {
  display: inline-flex;
  align-items: center;
  gap: 0.3rem;
  padding: 0.18rem 0.7rem;
  border-radius: 999px;
  font-size: 0.8rem;
  background: #fff0c2;
  color: #b87300;
  font-weight: 600;
}

.status-pill i {
  font-size: 0.85rem;
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

<div class="page-wrap">
  <h1 class="page-title">Your Orders</h1>

  <%
    if (orders == null || orders.isEmpty()) {
  %>
      <div class="empty-box">You have not placed any orders yet.</div>
  <%
    } else {
      for (Order order : orders) {

          LocalDateTime placedTime = null;
          try {
              placedTime = LocalDateTime.parse(order.getCreatedAt(), fmt); // [web:52][web:56]
          } catch (Exception e) {
              // leave placedTime null if parse fails
          }

          boolean delivered = false;
          if (placedTime != null) {
              LocalDateTime etaTime = placedTime.plusMinutes(order.getEtaMinutes());
              delivered = LocalDateTime.now().isAfter(etaTime);           // [web:53][web:59]
          }

          String statusText = delivered ? "Delivered successfully" : "On the way";
          String statusClass = delivered ? "status-pill delivered" : "status-pill";
  %>
    <div class="order-card">
      <div class="order-header">
        <div class="order-header-top">
          <span class="order-id">Order #<%= order.getId() %></span>
          <span class="order-total">Total: ₹<%= order.getTotalAmount() %></span>
        </div>
        <div class="order-meta">
          Placed: <%= order.getCreatedAt() %>
          &nbsp;|&nbsp; Payment: <%= order.getPaymentMethod() %>
          &nbsp;|&nbsp; ETA: <%= order.getEtaMinutes() %> min
          &nbsp;|&nbsp; Status:
          <span class="<%= statusClass %>">
  <% if (delivered) { %>
    <i class="fa fa-check-circle"></i> <%= statusText %>
  <% } else { %>
    <i class="fa fa-truck"></i> <%= statusText %>
  <% } %>
</span>
        </div>
        <div class="order-meta">
          Address: <%= order.getAddress() %>, <%= order.getCity() %> - <%= order.getPincode() %>
        </div>
      </div>

      <table class="items-table">
        <thead>
          <tr>
            <th>Item</th>
            <th>Price</th>
            <th>Qty</th>
            <th>Subtotal</th>
          </tr>
        </thead>
        <tbody>
        <%
          List<OrderItem> items = order.getItems();
          if (items != null) {
            for (OrderItem it : items) {
              double sub = it.getPrice() * it.getQuantity();
        %>
          <tr>
            <td>
              <div class="item-info">
                <% if (it.getImageUrl() != null && !it.getImageUrl().isEmpty()) { %>
                  <img src="<%= it.getImageUrl() %>" class="item-img" alt="">
                <% } %>
                <span><%= it.getItemName() %></span>
              </div>
            </td>
            <td>₹<%= it.getPrice() %></td>
            <td><%= it.getQuantity() %></td>
            <td>₹<%= String.format("%.2f", sub) %></td>
          </tr>
        <%
            }
          }
        %>
        </tbody>
      </table>
    </div>
  <%
      } // end orders loop
    } // end else
  %>
</div>

</body>
</html>
