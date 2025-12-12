package com.food;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodItemImp {

    public static List<FoodItem> getDishesByRestaurantId(int restId) {
        List<FoodItem> dishes = new ArrayList<>();
        String sql = "SELECT id, name, ratings, price, is_available, restaurant_id, imageUrl " +
                     "FROM food_items WHERE restaurant_id = ?";
        
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, restId);
            try (ResultSet rs = ps.executeQuery()) {  // ← Fix 1: try-with-resources for ResultSet
                while (rs.next()) {
                    FoodItem foodItem = new FoodItem(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("ratings"),
                        rs.getDouble("price"),
                        rs.getBoolean("is_available"),
                        rs.getString("imageUrl")
                    );
                    dishes.add(foodItem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dishes;
    }
}
