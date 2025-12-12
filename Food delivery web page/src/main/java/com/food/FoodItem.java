package com.food;

public class FoodItem {
    private int id;
    private String name;
    private double ratings;
    private double price;
    private boolean isAvailable;
    private int restaurantId;
    private String imageUrl;

    public FoodItem() {}

    public FoodItem(int id, String name, double ratings, double price, boolean isAvailable, int restaurantId) {
        this.id = id;
        this.name = name;
        this.ratings = ratings;
        this.price = price;
        this.isAvailable = isAvailable;
        this.restaurantId = restaurantId;
    }
    
    public FoodItem(int id, String name, double ratings, double price, boolean isAvailable , String imageUrl) {
        this.id = id;
        this.name = name;
        this.ratings = ratings;
        this.price = price;
        this.isAvailable = isAvailable;
        this.imageUrl=imageUrl;
    
    }

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public double getRatings() {
        return ratings;
    }
    public void setRatings(double ratings) {
        this.ratings = ratings;
    }

    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isAvailable() {
        return isAvailable;
    }
    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public int getRestaurantId() {
        return restaurantId;
    }
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
