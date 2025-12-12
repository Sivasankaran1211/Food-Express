package com.food;

import java.sql.SQLException;
import java.util.List;

public interface OrderDAO {
    int saveOrder(Order order) throws SQLException;
    List<Order> getOrdersByUser(int userId) throws SQLException;   // you already have
    List<Order> getOrdersWithItemsByUser(int userId) throws SQLException;  // NEW
    Order getOrderWithItems(int orderId) throws SQLException;
}
