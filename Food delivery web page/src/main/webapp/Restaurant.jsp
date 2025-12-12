<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List,com.food.User" %>

<%
    String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Food Express</title>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: "Segoe UI", Arial, sans-serif;
      background: linear-gradient(135deg, #fff7ea 0%, #ffe5d6 40%, #ffd2c8 100%);
      min-height: 100vh;
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
  max-width: 1200px;
  margin: 0 auto;
  padding: 0.7rem 1.5rem;
  display: flex;
  align-items: center;
}

/* LOGO: fixed hard-left */
.logo {
  font-size: 1.4rem;
  font-weight: 700;
  color: #fff5e6;
  text-transform: uppercase;
  letter-spacing: 1px;
  flex-shrink: 0;
}
.logo span {
  color: #ffe066;
}

/* MENU + SEARCH: sit to the right of logo */
.nav-links {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 1rem;
}

.nav-links a {
  position: relative;
  padding: 0.4rem 0.9rem;
  text-decoration: none;
  color: #fffdf6;
  font-size: 0.9rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  border-radius: 999px;
  overflow: hidden;
  transition: color 0.3s ease, transform 0.3s ease;
  white-space: nowrap;
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

.nav-links a.active {
  background: #fff3dd33;
  color: #4a2507;
}

.nav-links i {
  margin-right: 4px;
}

/* Search to the far right */
.search-container {
  margin-left: 1.8rem;
  display: flex;
  align-items: center;
  position: relative;
}
.search-input {
  padding: 0.35rem 1.6rem 0.35rem 1.0rem;
  border-radius: 999px;
  border: none;
  background: #fff3dd;
  color: #442210;
  font-size: 0.96rem;
  min-width: 200px;
  box-shadow: 0 2px 8px rgba(255, 170, 78, 0.05);
  transition: background 0.2s;
  outline: none;
}
.search-input:focus {
  background: #ffffef;
  border: 1px solid #ffb545;
}
.search-icon {
  position: absolute;
  right: 1.1rem;
  color: #d98a2a;
  font-size: 1.05rem;
  pointer-events: none;
}


    main {
      max-width: 1100px;
      margin: 1.8rem auto 2.5rem;
      padding: 0 1.5rem;
    }

    h1.page-title {
      text-align: left;
      font-size: 2.1rem;
      margin-bottom: 0.3rem;
      color: #402013;
    }

    .subtitle {
      font-size: 0.95rem;
      color: #7a5340;
      margin-bottom: 1.8rem;
    }

    .card-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 1.5rem;
    }

    .restaurant-card {
      background: #fff9f3;
      border-radius: 18px;
      padding: 1.1rem 1.2rem;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
      position: relative;
      overflow: hidden;
      border: 1px solid rgba(255, 180, 120, 0.5);
      cursor: pointer;
      transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
      display: flex;
      flex-direction: column;
    }
    .restaurant-card::before {
      content: "";
      position: absolute;
      inset: 0;
      background: linear-gradient(135deg, #ffb86b22, transparent 55%);
      opacity: 0;
      transition: opacity 0.25s ease;
      pointer-events: none;
      border-radius: 18px;
    }
    .restaurant-card:focus-visible {
      outline: 2px solid #ff9240;
      outline-offset: 3px;
    }
    .restaurant-card:hover,
    .restaurant-card:focus-within {
      transform: translateY(-8px);
      box-shadow: 0 14px 30px rgba(0, 0, 0, 0.12);
      border-color: #ff9240;
    }
    .restaurant-card:hover::before,
    .restaurant-card:focus-within::before {
      opacity: 1;
    }

    .restaurant-image {
      width: 100%;
      height: 160px;
      border-radius: 14px;
      object-fit: cover;
      margin-bottom: 0.9rem;
    }

    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 0.4rem;
    }

    .restaurant-name {
      font-size: 1.2rem;
      font-weight: 600;
      color: #3a1f12;
    }

    .badge-eta {
      font-size: 0.8rem;
      padding: 0.15rem 0.6rem;
      border-radius: 999px;
      background: #ffe8bf;
      color: #8a4a0b;
      border: 1px solid #ffcf7f;
      white-space: nowrap;
    }

    .ratings {
      display: flex;
      align-items: center;
      gap: 4px;
      margin-bottom: 0.2rem;
      margin-top: 0.35rem;
      font-size: 0.9rem;
      color: #7b4a27;
    }
    .ratings .fa-star,
    .ratings .fa-star-half-alt {
      color: #ffb300;
    }
    .rating-score {
      margin-left: 3px;
      font-weight: 600;
      color: #4a2b1a;
    }
    .address {
      font-size: 0.86rem;
      color: #8a5b42;
      margin-bottom: 0.4rem;
    }
    .description {
      font-size: 0.85rem;
      color: #5a3622;
      line-height: 1.45;
      max-height: 0;
      opacity: 0;
      overflow: hidden;
      transition: max-height 0.3s ease, opacity 0.3s ease, transform 0.3s ease;
      transform: translateY(4px);
    }
    .restaurant-card:hover .description,
    .restaurant-card:focus-within .description {
      max-height: 200px;
      opacity: 1;
      transform: translateY(0);
    }
    .tags {
      margin-top: 0.5rem;
      display: flex;
      flex-wrap: wrap;
      gap: 0.35rem;
      font-size: 0.75rem;
    }
    .tag-pill {
      padding: 0.18rem 0.55rem;
      border-radius: 999px;
      background: #ffe3dd;
      color: #8b3c21;
    }
    @media (max-width: 820px) {
      .search-container {
        display: none;
      }
    }
    @media (max-width: 600px) {
      .nav-bar {
        padding-inline: 1rem;
      }
      .nav-links a {
        font-size: 0.85rem;
        padding: 0.3rem 0.7rem;
      }
      h1.page-title {
        font-size: 1.7rem;
      }
    }
    main {
      margin-bottom: 3.8rem;
    }
  </style>
</head>
<body>
  <!-- Navigation -->
<header>
  <div class="nav-bar">
    <div class="logo">FOOD<span>EXPRESS</span></div>

    <nav class="nav-links">
      <a href="Restaurant"><i class="fa fa-home"></i>Home</a>
      <a href="cart"><i class="fa fa-shopping-cart"></i>Cart</a>
      <a href="#"><i class="fa fa-heart"></i>Favorite</a>
      <a href="yourOrders"><i class="fa fa-list"></i>Your Order</a>
      <a href="logout"
   onclick="return confirm('Are you sure you want to log out?');">
  <i class="fa fa-sign-out"></i>Logout
</a>


      <div class="search-container">
        <input type="text" class="search-input" placeholder="Search restaurants..." />
        <span class="search-icon"><i class="fa fa-search"></i></span>
      </div>
    </nav>
  </div>
</header>


  <!-- Main content -->
  <main>
    <div style="display:flex; justify-content:space-between; align-items:baseline; margin-bottom:0.3rem;">
    <%
      if (userName != null) {
    %>
    <h1 class="page-title">Welcome, <%= userName %></h1>
    <%
      }
    %>
  </div>
    <p class="subtitle">Discover popular restaurants near you, compare their ratings and delivery times, and pick the perfect place for your next meal.</p>
   		
   			 <section class="card-grid">
    <%
  List<User> list = (List<User>) request.getAttribute("list");
  if (list != null && !list.isEmpty()) {
    for (User user : list) {
    %>
      <a href="Menu?id=<%= user.getId() %>" style="text-decoration: none; color: inherit;">
        <article class="restaurant-card">
          <img src="<%= user.getImageUrl() %>" alt="<%= user.getName() %>" class="restaurant-image"/>
          <div class="card-header">
            <h2 class="restaurant-name"><%= user.getName() %></h2>
            <span class="badge-eta"><%= user.getTimeArrival() %></span>
          </div>
          <div class="ratings">
            <span class="rating-score"><%= user.getRatings() %></span>
          </div>
          <p class="address"><%= user.getAddress() %></p>
          <p class="description"><%= user.getDescription() %></p>
        </article>
      </a>
<%
    }
  } else {
%>
    <div>No restaurants available right now.</div>
<%
  }
%>

   	
    </section>
   		
  </main>
</body>
</html>
