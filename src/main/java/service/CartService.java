package service;

import java.util.ArrayList;

import dao.CartDao;

public class CartService {

	
		public static void addProductToCart(String userid,int product) {
			CartDao.addCartProduct(userid,product);
		}
		
		public ArrayList<Integer> getAllProducts(String userid){
			return CartDao.getAllCarts(userid);
		}
}
