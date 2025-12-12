package com.food;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.IOException;

import java.util.List;

import javax.imageio.ImageIO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {

    private OrderDaoImp orderDao;

    @Override
    public void init() {
        orderDao = new OrderDaoImp();
    }
    
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String orderIdParam = req.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID required");
            return;
        }

        int orderId = Integer.parseInt(orderIdParam);

        // 1) Load order + items in one call
        Order order;
        try {
            order = orderDao.getOrderWithItems(orderId);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB error");
            return;
        }

        if (order == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
            return;
        }

        List<OrderItem> items = order.getItems();   // all items for this order

        // 2) CREATE THE IMAGE (this was missing)
        int width = 800;
        int height = 600;              // increase later if needed
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        // background
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);

        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        int y = 40;

        // header
        g.setColor(new Color(0xFF7A3C));
        g.setFont(new Font("SansSerif", Font.BOLD, 26));
        g.drawString("FoodDelivery - Invoice", 40, y);
        y += 30;

        g.setColor(Color.DARK_GRAY);
        g.setFont(new Font("SansSerif", Font.PLAIN, 14));
        g.drawString("Order ID: " + order.getId(), 40, y);           y += 20;
        g.drawString("Customer: " + order.getCustomerName(), 40, y); y += 20;
        g.drawString("Phone: " + order.getPhone(), 40, y);           y += 30;

        // table header
        g.setFont(new Font("SansSerif", Font.BOLD, 14));
        g.drawString("Item", 40, y);
        g.drawString("Qty", 360, y);
        g.drawString("Price", 420, y);
        g.drawString("Total", 520, y);
        y += 10;
        g.drawLine(40, y, 760, y);
        y += 20;

        // table rows
        g.setFont(new Font("SansSerif", Font.PLAIN, 13));
        double subtotal = 0.0;

        for (OrderItem item : items) {
            double lineTotal = item.getPrice() * item.getQuantity();
            subtotal += lineTotal;

            g.drawString(item.getItemName(), 40, y);
            g.drawString(String.valueOf(item.getQuantity()), 360, y);
            g.drawString("₹ " + String.format("%.2f", item.getPrice()), 420, y);
            g.drawString("₹ " + String.format("%.2f", lineTotal), 520, y);

            y += 20;
        }

        y += 10;
        g.drawLine(40, y, 760, y);
        y += 25;

        double delivery = 0.0; // or order.getDeliveryFee() if you have it
        double total = subtotal + delivery;

        g.setFont(new Font("SansSerif", Font.BOLD, 14));
        g.drawString("Subtotal:  ₹ " + String.format("%.2f", subtotal), 520, y); y += 20;
        g.drawString("Delivery:  ₹ " + String.format("%.2f", delivery), 520, y); y += 20;
        g.drawString("Total:     ₹ " + String.format("%.2f", total),    520, y);

        g.dispose();

        // 3) SEND IT AS DOWNLOAD
        resp.setContentType("image/png");
        resp.setHeader("Content-Disposition",
                "attachment; filename=\"Invoice_" + orderId + ".png\"");
        ImageIO.write(image, "png", resp.getOutputStream());
    }


}
