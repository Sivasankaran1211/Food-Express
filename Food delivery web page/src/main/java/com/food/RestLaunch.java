package com.food;

import java.util.List;

public class RestLaunch {

	public static void main(String[] args) {
		RestaurantImp imp = new RestaurantImp();
		List<User> user = imp.getUser();
	}

}
