package com.food;

public class CartItem {
    private int itemId;          // ID of the menu/food item
    private String itemName;     // Name of the food item
    private int quantity;        // Quantity ordered
    private double price;
    private String imageUrl;   
  // Useful if menu items from multiple restaurants

    // Default constructor
    public CartItem() { }
    
    
    public CartItem(int itemId, String itemName, int quantity, double price,String imageUrl) {
	
	this.itemId = itemId;
	this.itemName = itemName;
	this.quantity = quantity;
	this.price = price;
	this.imageUrl=imageUrl;
    }


    
    
	public String getImageUrl() {
		return imageUrl;
	}


	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}


	public int getItemId() {
		return itemId;
	}


	public void setItemId(int itemId) {
		this.itemId = itemId;
	}


	public String getItemName() {
		return itemName;
	}


	public void setItemName(String itemName) {
		this.itemName = itemName;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public double getPrice() {
		return price;
	}


	public void setPrice(double price) {
		this.price = price;
	}

    // Full constructor
    
    
    
    
}
