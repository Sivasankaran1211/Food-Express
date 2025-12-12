package com.food;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/PlaceOrder")
public class PlaceOrderServlet extends HttpServlet {

private final OrderDAO orderDAO = new OrderDaoImp();

@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp)
throws ServletException, IOException {

HttpSession session = req.getSession(false);
Cart cart = (session != null) ? (Cart) session.getAttribute("Cart") : null;

if (cart == null || cart.getItems().isEmpty()) {
resp.sendRedirect("cart");
return;
}

String fullName = req.getParameter("fullName");
String phone = req.getParameter("phone");
String address1 = req.getParameter("addressLine1");
String address2 = req.getParameter("addressLine2");
String city = req.getParameter("city");
String state = req.getParameter("state");
String pincode = req.getParameter("pincode");
String landmark = req.getParameter("landmark");
String payment = req.getParameter("paymentMethod");

String fullAddress = address1;
if (address2 != null && !address2.isBlank()) {
fullAddress += ", " + address2;
}
if (landmark != null && !landmark.isBlank()) {
fullAddress += ", " + landmark;
}

// Build Order object
Order order = new Order();
order.setCustomerName(fullName);
order.setPhone(phone);
order.setAddress(fullAddress);
order.setCity(city);
order.setState(state);
order.setPincode(pincode);
order.setPaymentMethod(payment);

// >>> ADD THIS BLOCK <<<
int userId = (int) session.getAttribute("userId"); // from LoginServlet
order.setUserId(userId);
order.setEtaMinutes(40); // or any ETA value you want


double total = 0.0;
List<OrderItem> orderItems = new ArrayList<>();
for (CartItem cItem : cart.getItems()) {
OrderItem oi = new OrderItem();
oi.setFoodId(cItem.getItemId());
oi.setItemName(cItem.getItemName());
oi.setQuantity(cItem.getQuantity());
oi.setPrice(cItem.getPrice());
total += cItem.getPrice() * cItem.getQuantity();
orderItems.add(oi);
}
order.setTotalAmount(total);
order.setItems(orderItems);

int orderId;
try {
orderId = orderDAO.saveOrder(order);
} catch (SQLException e) {
e.printStackTrace();
resp.sendError(500, "Unable to save order");
return;
}

session.removeAttribute("Cart");

req.setAttribute("orderId", orderId);
req.setAttribute("eta", "30–40 mins");

RequestDispatcher rd = req.getRequestDispatcher("thankyou.jsp");
rd.forward(req, resp);
}
}