package com.food;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {

    private final Map<Integer, CartItem> items = new LinkedHashMap<>();

    public void addItem(CartItem item) {
        int itemId = item.getItemId();

        if (items.containsKey(itemId)) {
            CartItem existingItem = items.get(itemId);
            int newQty = item.getQuantity();
            int oldQty = existingItem.getQuantity();
            existingItem.setQuantity(newQty + oldQty);
        } else {
            items.put(itemId, item);
        }
    }

    public void updateItem(int itemId, String op) {
        if (!items.containsKey(itemId)) return;

        CartItem existingItem = items.get(itemId);
        int qty = existingItem.getQuantity();

        if ("inc".equals(op)) {
            qty++;
        } else if ("dec".equals(op)) {
            qty--;
        }

        if (qty <= 0) {
            items.remove(itemId);
        } else {
            existingItem.setQuantity(qty);
        }
    }

    public void removeItem(int itemId) {
        items.remove(itemId);
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

}
