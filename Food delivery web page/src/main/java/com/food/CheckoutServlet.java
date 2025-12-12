package com.food;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("Cart") == null) {
            // no cart → send back to restaurants or cart
            resp.sendRedirect("cart");
            return;
        }

        // If you want to show order total on checkout.jsp:
        Cart cart = (Cart) req.getSession().getAttribute("Cart");
        double total = 0.0;
        if (cart != null) {
            for (CartItem item : cart.getItems()) {
                total += item.getPrice() * item.getQuantity();
            }
        }
        req.getSession().setAttribute("cartTotal", total);
      
        RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");
        rd.forward(req, resp);
    }
}
