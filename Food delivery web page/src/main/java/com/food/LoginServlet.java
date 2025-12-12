package com.food;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        String sql = "SELECT id, name FROM users WHERE email=? AND password=?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
            	if (rs.next()) {
            	    HttpSession session = req.getSession();
            	    session.setAttribute("userId", rs.getInt("id"));
            	    session.setAttribute("userName", rs.getString("name"));

            	    // redirect to your main restaurant listing
            	    resp.sendRedirect("Restaurant");
            	} else {
            	    req.setAttribute("error", "Invalid email or password");
            	    req.getRequestDispatcher("login.jsp").forward(req, resp);
            	}

            }
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
