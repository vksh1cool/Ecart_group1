package dao;

import util.DBUtil;
import bean.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductDao {
    
	
	
	public static ArrayList<Product> getAllProduct(){
		ArrayList<Product> arr = new ArrayList<>();
        try {
            Connection cn = DBUtil.createConnection();
            PreparedStatement ps = cn.prepareStatement("SELECT * FROM prdts");
           
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
               Product product = new Product(
                    rs.getInt("productId"),
                    rs.getString("productName"),
                    rs.getFloat("productPrice"),
                    rs.getString("productCategory"),
                    rs.getString("productDescription")
                );
               
               System.out.println(rs.getInt("productId"));
               arr.add(product);
            }
            DBUtil.closeAllConnection(cn, ps, rs);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return arr;
    }
	
    public boolean addProduct(Product product) {
        boolean result = false;

        try {
            // Create a database connection
            Connection cn = DBUtil.createConnection();
            // Prepare SQL statement for inserting the product
            PreparedStatement ps = cn.prepareStatement("INSERT INTO prdts VALUES (?, ?, ?, ?, ?)");

            // Set the parameters
            
            ps.setInt(1, product.getProductId());
            ps.setString(2, product.getProductName());
            ps.setFloat(3, product.getProductPrice());
            ps.setString(4, product.getProductCategory());
            ps.setString(5, product.getProductDescription());

           
            
            // Execute the update
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                result = true; // Product added successfully
                
            }
            
            // Close the connection and statement
            DBUtil.closeAllConnection(cn, ps, null);

        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception (consider using a logger)
        }

        return result;
    }
    
    public boolean deleteProductByName(String productName) {
    	String sql = "DELETE FROM prdts where productName=?";
    	boolean rowDeleted = false;
    	
    	try {
    		 Connection cn = DBUtil.createConnection();
             // Prepare SQL statement for inserting the product
             PreparedStatement ps = cn.prepareStatement(sql);
             
             ps.setString(1, productName);
             
             int rowsAffected = ps.executeUpdate();
             
             if(rowsAffected > 0) {
            	 rowDeleted = true;
             }
    	}
    	catch(SQLException e) {
    		e.printStackTrace();
    	}
    	
    	return rowDeleted;
    }
    
    public boolean updateProduct(Product product) {
        boolean result = false;

        try {
            // Create a database connection
            Connection cn = DBUtil.createConnection();
            // Prepare SQL statement for inserting the product
            PreparedStatement ps = cn.prepareStatement("update prdts set productPrice=?, productCategory=?, productDescription=? WHERE productName=?");

            // Set the parameters
            
            ps.setFloat(1, product.getProductPrice());
            ps.setString(2, product.getProductCategory());
            ps.setString(3, product.getProductDescription());
            ps.setString(4, product.getProductName());
           
            
            // Execute the update
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                result = true; // Product added successfully
                
            }
            
            // Close the connection and statement
            DBUtil.closeAllConnection(cn, ps, null);

        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception (consider using a logger)
        }

        return result;
    }
}
