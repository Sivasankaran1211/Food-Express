package com.food;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//package com.food;
@WebServlet("/yourOrders")
public class YourOrdersServlet extends HttpServlet {

 private final OrderDAO orderDAO = new OrderDaoImp();

 @Override
 protected void doGet(HttpServletRequest req, HttpServletResponse resp)
         throws ServletException, IOException {

     HttpSession session = req.getSession(false);
     if (session == null || session.getAttribute("userId") == null) {
         resp.sendRedirect("login.jsp");
         return;
     }

     int userId = (int) session.getAttribute("userId");

     try {
    	 List<Order> orders = orderDAO.getOrdersWithItemsByUser(userId);
    	 req.setAttribute("orders", orders);
    	 req.getRequestDispatcher("yourOrders.jsp").forward(req, resp);

     } catch (Exception e) {
         throw new ServletException(e);
     }
 }
}

