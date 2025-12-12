package com.food;

public class User {
	private int id;
	private String name;
	private String ratings;
	private String description;
	private String address;
	private String imageUrl;
	private String timeArrival;
	
	public User() {
		
	}

	public User( int id, String name, String ratings, String description, String address, String imageUrl, String timeArrival) {
		this.id=id;
		this.name = name;
		this.ratings = ratings;
		this.description = description;
		this.address = address;
		this.imageUrl = imageUrl;
		this.timeArrival = timeArrival;
	}

	
	
	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getRatings() {
		return ratings;
	}

	public String getDescription() {
		return description;
	}

	public String getAddress() {
		return address;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public String getTimeArrival() {
		return timeArrival;
	}



}
