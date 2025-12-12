package com.food;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodItemDaoImp implements FoodItemDAO {

    @Override
    public FoodItem getFoodItemById(int id) throws SQLException {
        String sql = "SELECT id, name, ratings, price, is_available, restaurant_id, imageUrl " +
                     "FROM food_items WHERE id = ?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToFoodItem(rs);
                }
            }
        }
        return null; // not found
    }

    @Override
    public List<FoodItem> getFoodItemsByRestaurant(int restaurantId) throws SQLException {
        List<FoodItem> list = new ArrayList<>();

        String sql = "SELECT id, name, ratings, price, is_available, restaurant_id, imageUrl " +
                     "FROM food_items WHERE restaurant_id = ?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FoodItem item = mapRowToFoodItem(rs);
                    list.add(item);
                }
            }
        }
        return list;
    }

    // Helper to convert a ResultSet row into a FoodItem object
    private FoodItem mapRowToFoodItem(ResultSet rs) throws SQLException {
        FoodItem item = new FoodItem();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setRatings(rs.getDouble("ratings"));
        item.setPrice(rs.getDouble("price"));
        item.setAvailable(rs.getBoolean("is_available"));
        item.setRestaurantId(rs.getInt("restaurant_id"));
        item.setImageUrl(rs.getString("imageUrl"));
        return item;
    }
}
