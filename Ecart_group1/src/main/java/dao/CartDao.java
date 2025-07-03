package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.Product;
import util.DBUtil;

public class CartDao {

	 public static void addCartProduct(String userid,int product) {
	     

	        try {
	            // Create a database connection
	            Connection cn = DBUtil.createConnection();
	            // Prepare SQL statement for inserting the product
	            PreparedStatement ps = cn.prepareStatement("INSERT INTO carts VALUES (?, ?)");

	            // Set the parameters
	            
	            ps.setString(1, userid);
	            ps.setInt(2, product);
	      

	           
	            
	            // Execute the update
	            int rowsAffected = ps.executeUpdate();
	           
	            
	            // Close the connection and statement
	            DBUtil.closeAllConnection(cn, ps, null);

	        } catch (SQLException e) {
	            e.printStackTrace(); // Log the exception (consider using a logger)
	        }

	      
	    }
	
	 public static ArrayList<Integer> getAllCarts(String userid){
		 ArrayList<Integer> arr = new ArrayList<>();
		 try {
	            Connection cn = DBUtil.createConnection();
	            PreparedStatement ps = cn.prepareStatement("SELECT * FROM carts where userid=?");
	           ps.setString(1,userid);
	           
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	            	int obj = rs.getInt("productid");
	            	String u = rs.getString("userid");
	            	System.out.println(u);
	               arr.add(obj);
	            }
	            DBUtil.closeAllConnection(cn, ps, rs);
	        } catch (SQLException e) {
	            System.out.println(e.getMessage());
	        }
		 return arr;
		 
	 }
	
	
}
