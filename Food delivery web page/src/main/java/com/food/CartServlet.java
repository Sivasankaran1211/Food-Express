package com.food;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
         throws ServletException, IOException {

        HttpSession session = req.getSession();

        // get or create cart
        Cart cart = (Cart) session.getAttribute("Cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("Cart", cart);
        }

        // store restaurant id in session (if sent)
        String restIdParam = req.getParameter("restId");
        if (restIdParam != null && !restIdParam.isBlank()) {
            try {
                int restId = Integer.parseInt(restIdParam);
                session.setAttribute("restId", restId);
            } catch (NumberFormatException e) {
                // ignore bad restId
            }
        }
        Integer sessionRestId = (Integer) session.getAttribute("restId");

        String action = req.getParameter("action");  // add / update / delete

        try {
            if ("add".equals(action)) {
                addItemToCart(req, cart);
            } else if ("update".equals(action)) {
                updateItem(req, cart);
            } else if ("delete".equals(action)) {
                deleteItemFromCart(req, cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // redirect after every operation — choose what you prefer:

        // 1) Go back to menu after add, cart page for others:
        if ("add".equals(action) && sessionRestId != null) {
            resp.sendRedirect("Menu?id=" + sessionRestId);
        } else {
            resp.sendRedirect("cart.jsp");
        }

//        System.out.println("CartServlet action=" + action);
        
    
        
        // If you want ALWAYS go to cart.jsp, just use:
        // resp.sendRedirect("cart.jsp");
    }

    private void addItemToCart(HttpServletRequest req, Cart cart)
            throws SQLException, ClassNotFoundException {

        int menuId   = Integer.parseInt(req.getParameter("menuId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        FoodItemDAO dao = new FoodItemDaoImp();
        FoodItem food  = dao.getFoodItemById(menuId);

        if (food == null) {
            System.out.println("Food is null for id=" + menuId);
            return;
        }

        String itemName = food.getName();
        double price    = food.getPrice();
        String imageUrl = food.getImageUrl();

        CartItem item = new CartItem(menuId, itemName, quantity, price, imageUrl);
        cart.addItem(item);

//        System.out.println("Cart size after add = " + cart.getItems().size());
    }

    private void updateItem(HttpServletRequest req, Cart cart) {
        int menuId = Integer.parseInt(req.getParameter("menuId"));
        String op  = req.getParameter("op"); // "inc" or "dec"
        cart.updateItem(menuId, op);
    }

    private void deleteItemFromCart(HttpServletRequest req, Cart cart) {
        int menuId = Integer.parseInt(req.getParameter("menuId"));
        cart.removeItem(menuId);
    }
}
