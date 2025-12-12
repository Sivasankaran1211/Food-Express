package com.food;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImp implements OrderDAO {

    @Override
    public int saveOrder(Order order) throws SQLException {
        String orderSql = "INSERT INTO orders " +
                "(customer_name, phone, ADDRESS, city, state, pincode, payment_method, total_amount, user_id, eta_minutes) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?)";

        String itemSql = "INSERT INTO order_items " +
                "(order_id, food_id, item_name, quantity, price) VALUES (?,?,?,?,?)";

        try (Connection con = ConnectionDB.getConnection()) {
            con.setAutoCommit(false);
            int orderId;

            try (PreparedStatement ps =
                         con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, order.getCustomerName());
                ps.setString(2, order.getPhone());
                ps.setString(3, order.getAddress());
                ps.setString(4, order.getCity());
                ps.setString(5, order.getState());
                ps.setString(6, order.getPincode());
                ps.setString(7, order.getPaymentMethod());
                ps.setDouble(8, order.getTotalAmount());
                ps.setInt(9, order.getUserId());
                ps.setInt(10, order.getEtaMinutes());  
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    } else {
                        con.rollback();
                        throw new SQLException("Failed to get order id");
                    }
                }
            }

            try (PreparedStatement psItem = con.prepareStatement(itemSql)) {
                for (OrderItem item : order.getItems()) {
                    psItem.setInt(1, orderId);
                    psItem.setInt(2, item.getFoodId());
                    psItem.setString(3, item.getItemName());
                    psItem.setInt(4, item.getQuantity());
                    psItem.setDouble(5, item.getPrice());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            con.commit();
            return orderId;
        }
    }

    // 🔥 ADD THIS MISSING METHOD
    @Override
    public List<Order> getOrdersByUser(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("ADDRESS"));
                    order.setCity(rs.getString("city"));
                    order.setState(rs.getString("state"));
                    order.setPincode(rs.getString("pincode"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setCreatedAt(rs.getString("created_at"));
                    order.setUserId(userId);
                    order.setEtaMinutes(rs.getInt("eta_minutes"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    @Override
    public List<Order> getOrdersWithItemsByUser(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();

        String oSql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        String iSql = "SELECT oi.id, oi.order_id, oi.food_id, oi.item_name, " +
                      "oi.quantity, oi.price, f.imageUrl " +
                      "FROM order_items oi " +
                      "JOIN food_items f ON oi.food_id = f.id " +
                      "WHERE oi.order_id = ?";

        try (Connection con = ConnectionDB.getConnection()) {
            // load all orders for user
            try (PreparedStatement ps = con.prepareStatement(oSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Order o = new Order();
                        o.setId(rs.getInt("id"));
                        o.setCustomerName(rs.getString("customer_name"));
                        o.setPhone(rs.getString("phone"));
                        o.setAddress(rs.getString("ADDRESS"));
                        o.setCity(rs.getString("city"));
                        o.setState(rs.getString("state"));
                        o.setPincode(rs.getString("pincode"));
                        o.setPaymentMethod(rs.getString("payment_method"));
                        o.setTotalAmount(rs.getDouble("total_amount"));
                        o.setCreatedAt(rs.getString("created_at"));
                        o.setUserId(userId);
                        o.setEtaMinutes(rs.getInt("eta_minutes"));
                        orders.add(o);
                    }
                }
            }

            // for each order, load its items
            try (PreparedStatement psItems = con.prepareStatement(iSql)) {
                for (Order order : orders) {
                    List<OrderItem> items = new ArrayList<>();
                    psItems.setInt(1, order.getId());
                    try (ResultSet rs = psItems.executeQuery()) {
                        while (rs.next()) {
                            OrderItem item = new OrderItem();
                            item.setId(rs.getInt("id"));
                            item.setOrderId(rs.getInt("order_id"));
                            item.setFoodId(rs.getInt("food_id"));
                            item.setItemName(rs.getString("item_name"));
                            item.setQuantity(rs.getInt("quantity"));
                            item.setPrice(rs.getDouble("price"));
                            item.setImageUrl(rs.getString("imageUrl"));
                            items.add(item);
                        }
                    }
                    order.setItems(items);
                }
            }
        }
        return orders;
    }

    @Override
    public Order getOrderWithItems(int orderId) throws SQLException {
        Order order = null;
        String oSql = "SELECT * FROM orders WHERE id = ?";

        String iSql = "SELECT oi.id, oi.order_id, oi.food_id, oi.item_name, " +
                      "oi.quantity, oi.price, f.imageUrl " +
                      "FROM order_items oi " +
                      "JOIN food_items f ON oi.food_id = f.id " +
                      "WHERE oi.order_id = ?";

        try (Connection con = ConnectionDB.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement(oSql)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        order = new Order();
                        order.setId(rs.getInt("id"));
                        order.setCustomerName(rs.getString("customer_name"));
                        order.setPhone(rs.getString("phone"));
                        order.setAddress(rs.getString("ADDRESS"));
                        order.setCity(rs.getString("city"));
                        order.setState(rs.getString("state"));
                        order.setPincode(rs.getString("pincode"));
                        order.setPaymentMethod(rs.getString("payment_method"));
                        order.setTotalAmount(rs.getDouble("total_amount"));
                        order.setCreatedAt(rs.getString("created_at"));
                    }
                }
            }

            if (order == null) return null;

            List<OrderItem> items = new ArrayList<>();
            try (PreparedStatement ps = con.prepareStatement(iSql)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        OrderItem item = new OrderItem();
                        item.setId(rs.getInt("id"));
                        item.setOrderId(rs.getInt("order_id"));
                        item.setFoodId(rs.getInt("food_id"));
                        item.setItemName(rs.getString("item_name"));
                        item.setQuantity(rs.getInt("quantity"));
                        item.setPrice(rs.getDouble("price"));
                        item.setImageUrl(rs.getString("imageUrl"));
                        items.add(item);
                    }
                }
            }
            order.setItems(items);
        }
        return order;
    }
}
