package com.food;

import java.sql.SQLException;
import java.util.List;

public interface FoodItemDAO {

    // Get a single menu item by its id
    FoodItem getFoodItemById(int id) throws SQLException;

    // Get all menu items for a given restaurant
    List<FoodItem> getFoodItemsByRestaurant(int restaurantId) throws SQLException;
}
