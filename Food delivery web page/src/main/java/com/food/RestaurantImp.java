// RestaurantImp.java
package com.food;

import java.sql.*;
import java.util.*;

public class RestaurantImp implements UserInterface {
    private static final String SELECT_SQL = "SELECT * FROM `restaurant-details`";

    @Override
    public List<User> getUser() {
        List<User> list = new ArrayList<>();
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement prp = con.prepareStatement(SELECT_SQL);
             ResultSet rs = prp.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String ratings = rs.getString("ratings");
                String description = rs.getString("description");
                String address = rs.getString("address");
                String imageUrl = rs.getString("imageUrl");
                String timeArrival = rs.getString("timeArrival");

                User user = new User(id, name, ratings, description, address, imageUrl, timeArrival);
                list.add(user);
            }
            
      
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
