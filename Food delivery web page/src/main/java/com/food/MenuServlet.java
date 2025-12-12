package com.food;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/Menu")
public class MenuServlet extends HttpServlet{
	
				
			private String sql="SELECT name, description FROM `restaurant-details` WHERE id=?";



				@Override
				protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
					
					 String restIdStr = req.getParameter("id");
				        int restId = Integer.parseInt(restIdStr);
				     // In MenuServlet.doGet(), keep this line exactly:
				        List<FoodItem> dishes = FoodItemImp.getDishesByRestaurantId(restId);
				        String restName = "";
				        String desc = "";
				        try (Connection con = ConnectionDB.getConnection();
				             PreparedStatement ps = con.prepareStatement(sql)) {
				            ps.setInt(1, restId);
				            ResultSet rs = ps.executeQuery();
				            if(rs.next()) {
				                restName = rs.getString("name");
				                desc = rs.getString("description");
				            }
				        } catch (SQLException e) { e.printStackTrace(); }
				        req.setAttribute("restaurantName", restName);
				        req.setAttribute("description", desc);
				        req.setAttribute("dishes", dishes);
				        req.setAttribute("restId", restId);   // needed by Menu.jsp

				        RequestDispatcher rd = req.getRequestDispatcher("Menu.jsp");
				        rd.forward(req, resp);

				}

}
