// Servlet1.java
package com.food;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/Restaurant")
public class Servlet1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RestaurantImp rest = new RestaurantImp();
        List<User> list = rest.getUser();
        req.setAttribute("list", list);
        RequestDispatcher rd = req.getRequestDispatcher("Restaurant.jsp");
        
        rd.forward(req, resp);
    }
}
