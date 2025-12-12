<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Double cartTotal = (Double) session.getAttribute("cartTotal");
    if (cartTotal == null) cartTotal = 0.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Checkout | FoodExpress</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    body {
      background: linear-gradient(135deg, #fff7ea 0%, #ffe5d6 40%, #ffd2c8 100%);
      font-family: "Segoe UI", Arial, sans-serif;
      color: #2f1b0f;
      margin: 0;
    }

    /* Top navigation (same family as other pages) */
    header {
      width: 100%;
      background: linear-gradient(120deg, #ff7a3c, #ffb545);
      box-shadow: 0 4px 14px rgba(0,0,0,0.12);
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
    .prev-icon {
      color: #fff;
      font-size: 20px;
      margin-right: 18px;
      cursor: pointer;
      display: flex;
      align-items: center;
      text-decoration: none;
    }
    .logo {
      font-size: 1.4rem;
      font-weight: 700;
      color: #fff5e6;
      text-transform: uppercase;
      letter-spacing: 1px;
    }
    .logo span { color: #ffe066; }
    .nav-links {
      margin-left: auto;
      display: flex;
      gap: 1rem;
      align-items: center;
    }
    .nav-links a {
      padding: 0.4rem 0.9rem;
      text-decoration: none;
      color: #fffdf6;
      font-size: 0.9rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-radius: 999px;
    }
    .nav-links a.active {
      background: #fff3dd33;
      color: #4a2507;
    }

    /* Main layout */
    .page-wrap {
      max-width: 950px;
      margin: 2rem auto 6rem;
      padding: 0 1.4rem;
    }
    .checkout-title {
      font-size: 1.9rem;
      color: #cb6500;
      margin-bottom: 0.4rem;
    }
    .checkout-subtitle {
      font-size: 0.95rem;
      color: #7a5340;
      margin-bottom: 1.3rem;
    }

    .checkout-grid {
      display: grid;
      grid-template-columns: minmax(0, 2fr) minmax(260px, 1.4fr);
      gap: 1.5rem;
    }

    .card {
      background: #fff8f1;
      border-radius: 16px;
      padding: 1.3rem 1.4rem;
      box-shadow: 0 8px 26px rgba(0,0,0,0.08);
      border: 1px solid rgba(255, 180, 120, 0.45);
    }
    .card h3 {
      margin: 0 0 0.8rem;
      font-size: 1.1rem;
      color: #7a3f15;
    }

    /* Address form */
    .form-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit,minmax(220px,1fr));
      gap: 1rem 1.3rem;
    }
    label {
      display: block;
      font-size: 0.9rem;
      margin-bottom: 0.25rem;
      color: #5a331c;
    }
    input[type="text"],
    input[type="tel"],
    input[type="email"] {
      width: 100%;
      padding: 0.45rem 0.65rem;
      border-radius: 8px;
      border: 1px solid #ffd3a8;
      background: #fffdf8;
      font-size: 0.95rem;
      color: #3a2214;
      box-sizing: border-box;
    }

    /* Payment section – pill tabs like big apps */
    .payment-tabs {
      display: flex;
      gap: 0.5rem;
      margin-bottom: 1rem;
      flex-wrap: wrap;
    }
    .payment-tab {
      flex: 1;
      min-width: 120px;
      padding: 0.55rem 0.8rem;
      border-radius: 999px;
      border: 1px solid #ffd3a8;
      background: #fffaf4;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.45rem;
      font-size: 0.86rem;
      color: #6b3d1f;
      cursor: pointer;
      transition: background 0.2s, border-color 0.2s, transform 0.15s;
    }
    .payment-tab i { font-size: 0.95rem; }
    .payment-tab.active {
      background: #ffeed3;
      border-color: #ff9c41;
      color: #5a2b14;
      box-shadow: 0 4px 14px rgba(255, 156, 65, 0.35);
      transform: translateY(-1px);
    }
    .payment-tab input {
      display: none;
    }

    .payment-details {
      margin-top: 0.5rem;
    }
    .payment-note {
      font-size: 0.82rem;
      color: #8a5b42;
      margin-bottom: 0.6rem;
    }
    .card-row {
      display: grid;
      grid-template-columns: 1.6fr 1fr 0.8fr;
      gap: 0.9rem;
      margin-top: 0.4rem;
    }
    .upi-row {
      margin-top: 0.4rem;
    }

    /* Order summary card */
    .summary-list {
      list-style: none;
      padding: 0;
      margin: 0.4rem 0 0.8rem;
      font-size: 0.9rem;
      color: #5b3520;
    }
    .summary-list li {
      display: flex;
      justify-content: space-between;
      margin-bottom: 0.3rem;
    }
    .summary-total {
      border-top: 1px dashed #ffd3a8;
      margin-top: 0.3rem;
      padding-top: 0.5rem;
      font-weight: 700;
      color: #8a4a0b;
      font-size: 1rem;
    }

    /* Sticky bottom bar like apps */
    .bottom-bar {
      position: fixed;
      left: 0;
      right: 0;
      bottom: 0;
      background: #fff7ea;
      box-shadow: 0 -4px 18px rgba(0,0,0,0.12);
      padding: 0.6rem 0;
    }
    .bottom-bar-inner {
      max-width: 950px;
      margin: 0 auto;
      padding: 0 1.4rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 1rem;
    }
    .bottom-amount {
      font-size: 0.95rem;
      color: #7a3f15;
    }
    .bottom-amount strong {
      font-size: 1.15rem;
      color: #cb6500;
    }
    .btn-primary {
      background: linear-gradient(120deg, #ff7a3c, #ffb545);
      color: #3a1604;
      border: none;
      padding: 0.7rem 2.2rem;
      border-radius: 999px;
      font-size: 0.98rem;
      font-weight: 700;
      cursor: pointer;
      box-shadow: 0 6px 16px rgba(0,0,0,0.18);
      letter-spacing: 0.4px;
      display: inline-flex;
      align-items: center;
      gap: 0.45rem;
      transition: transform 0.12s, box-shadow 0.12s;
    }
    .btn-primary:hover {
      transform: translateY(-1px);
      box-shadow: 0 9px 22px rgba(0,0,0,0.22);
    }

    @media (max-width: 800px) {
      .checkout-grid {
        grid-template-columns: 1fr;
      }
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
      <a href="Restaurant"><i class="fa fa-home"></i>Home</a>
      <a href="cart"><i class="fa fa-shopping-cart"></i>Cart</a>
      <a href="yourOrders"><i class="fa fa-list"></i>Your Order</a>
    </nav>
  </div>
</header>

<div class="page-wrap">
  <h2 class="checkout-title">Checkout</h2>
  <p class="checkout-subtitle">Confirm your address and choose a secure payment method to place your order.</p>

  <form action="PlaceOrder" method="post" id="checkoutForm">
    <div class="checkout-grid">
      <!-- LEFT: address + payment -->
      <div>
        <!-- Address -->
        <div class="card">
          <h3>Delivery Address</h3>
          <div class="form-grid">
            <div>
              <label for="fullName">Full Name</label>
              <input type="text" id="fullName" name="fullName" required>
            </div>
            <div>
              <label for="phone">Mobile Number</label>
              <input type="tel" id="phone" name="phone" required>
            </div>
            <div>
              <label for="email">Email (optional)</label>
              <input type="email" id="email" name="email">
            </div>
            <div>
              <label for="pincode">Pincode</label>
              <input type="text" id="pincode" name="pincode" required>
            </div>
            <div style="grid-column:1/-1;">
              <label for="addressLine1">Address</label>
              <input type="text" id="addressLine1" name="addressLine1" required>
            </div>
            <div style="grid-column:1/-1;">
              <label for="addressLine2">Confirm Address</label>
              <input type="text" id="addressLine2" name="addressLine2">
            </div>
            <div>
              <label for="city">City</label>
              <input type="text" id="city" name="city" required>
            </div>
            <div>
              <label for="state">State</label>
              <input type="text" id="state" name="state" required>
            </div>
            <div style="grid-column:1/-1;">
              <label for="landmark">Nearby Landmark (optional)</label>
              <input type="text" id="landmark" name="landmark">
            </div>
          </div>
        </div>

        <!-- Payment -->
        <div class="card" style="margin-top:1.2rem;">
          <h3>Payment Method</h3>

          <div class="payment-tabs">
            <label class="payment-tab active" id="tab-cod">
              <input type="radio" name="paymentMethod" value="COD" checked>
              <i class="fa fa-money"></i> Cash on Delivery
            </label>
            <label class="payment-tab" id="tab-upi">
              <input type="radio" name="paymentMethod" value="UPI">
              <i class="fa fa-mobile"></i> UPI
            </label>
            <label class="payment-tab" id="tab-card">
              <input type="radio" name="paymentMethod" value="CARD">
              <i class="fa fa-credit-card"></i> Card
            </label>
          </div>

          <div class="payment-details" id="payment-cod">
            <p class="payment-note">
              Pay in cash to the delivery partner when your order arrives.
            </p>
          </div>

          <div class="payment-details" id="payment-upi" style="display:none;">
            <p class="payment-note">
              Enter your UPI ID; you will receive a payment request in your UPI app.
            </p>
            <div class="upi-row">
              <label for="upiId">UPI ID</label>
              <input type="text" id="upiId" name="upiId" placeholder="name@bank">
            </div>
          </div>

          <div class="payment-details" id="payment-card" style="display:none;">
            <p class="payment-note">
              Your card details are encrypted and securely processed.
            </p>
            <div>
              <label for="cardNumber">Card Number</label>
              <input type="text" id="cardNumber" name="cardNumber" placeholder="XXXX XXXX XXXX XXXX">
            </div>
            <div class="card-row">
              <div>
                <label for="cardName">Name on Card</label>
                <input type="text" id="cardName" name="cardName">
              </div>
              <div>
                <label for="expiry">Expiry (MM/YY)</label>
                <input type="text" id="expiry" name="expiry" placeholder="MM/YY">
              </div>
              <div>
                <label for="cvv">CVV</label>
                <input type="password" id="cvv" name="cvv" maxlength="4">
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- RIGHT: summary -->
      <div>
        <div class="card">
          <h3>Order Summary</h3>
          <ul class="summary-list">
            <li>
              <span>Items total</span>
              <span>₹ <%= String.format("%.2f", cartTotal) %></span>
            </li>
            <li>
              <span>Delivery fee</span>
              <span>₹ 0.00</span>
            </li>
            <li class="summary-total">
              <span>To Pay</span>
              <span>₹ <%= String.format("%.2f", cartTotal) %></span>
            </li>
          </ul>
          <p style="font-size:0.8rem;color:#8a5b42;margin-top:0.4rem;">
            By placing this order, you agree to our terms and refund policy.
          </p>
        </div>
      </div>
    </div>

    <!-- Sticky bottom bar -->
    <div class="bottom-bar">
      <div class="bottom-bar-inner">
        <div class="bottom-amount">
          To Pay<br>
          <strong>₹ <%= String.format("%.2f", cartTotal) %></strong>
        </div>
        <button type="submit" class="btn-primary">
          <i class="fa fa-check"></i> Place Order
        </button>
      </div>
    </div>
  </form>
</div>

<script>
  // Simple tab switching for payment methods (no external libs)
  const tabCod = document.getElementById('tab-cod');
  const tabUpi = document.getElementById('tab-upi');
  const tabCard = document.getElementById('tab-card');

  const sectionCod = document.getElementById('payment-cod');
  const sectionUpi = document.getElementById('payment-upi');
  const sectionCard = document.getElementById('payment-card');

  function selectMethod(tab, section, value) {
    [tabCod, tabUpi, tabCard].forEach(t => t.classList.remove('active'));
    tab.classList.add('active');

    sectionCod.style.display = 'none';
    sectionUpi.style.display = 'none';
    sectionCard.style.display = 'none';
    section.style.display = 'block';

    const radios = document.querySelectorAll('input[name="paymentMethod"]');
    radios.forEach(r => { r.checked = (r.value === value); });
  }

  tabCod.onclick = () => selectMethod(tabCod, sectionCod, 'COD');
  tabUpi.onclick = () => selectMethod(tabUpi, sectionUpi, 'UPI');
  tabCard.onclick = () => selectMethod(tabCard, sectionCard, 'CARD');
</script>

</body>
</html>
