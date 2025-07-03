package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.User;
import util.DBUtil;

public class UserDao {
    public boolean registerUser(User user) {
        boolean status = false;
        try {
            Connection cn = DBUtil.createConnection();
            PreparedStatement ps = cn.prepareStatement("INSERT INTO users (userId, customerName, email, phone, address, password, role) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, user.getUserId());
            ps.setString(2, user.getCustomerName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhoneNumber());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getRole());
            int rowsAffected = ps.executeUpdate();
            status = rowsAffected > 0;
            DBUtil.closeAllConnection(cn, ps, null);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return status;
    }

    public User getUserByEmailOrPhone(String email, String phoneNumber) {
        User user = null;
        try {
            Connection cn = DBUtil.createConnection();
            PreparedStatement ps = cn.prepareStatement("SELECT * FROM users WHERE email = ? OR phone = ?");
            ps.setString(1, email);
            ps.setString(2, phoneNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getString("userId"),
                    rs.getString("customerName"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }
            DBUtil.closeAllConnection(cn, ps, rs);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return user;
    }
    
    public User getUserByIdAndPassword(String userId, String password){
        User user = null;
        try {
            Connection cn = DBUtil.createConnection();
            PreparedStatement ps = cn.prepareStatement("SELECT * FROM users WHERE userid = ? AND password = ?");
            ps.setString(1, userId);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getString("userId"),
                    rs.getString("customerName"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }
            DBUtil.closeAllConnection(cn, ps, rs);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return user;
    }
    
 public List<User> getAllCustomers() {
		
    	User user = null;
		List<User> customers = new ArrayList<>();
		
		try {
			Connection cn = DBUtil.createConnection();
			PreparedStatement ps = cn.prepareStatement("SELECT * FROM Users WHERE role = ? ");
			
			ps.setString(1, "0");
			
			ResultSet rs = ps.executeQuery();
			
//			System.out.println("Hello");
			while(rs.next()) {
				
				
				String userId = rs.getString("userId");
				String customerName = rs.getString("customerName");
				String email = rs.getString("email");
				String phoneNumber = rs.getString("phone");
				String address = rs.getString("address");
				String password = rs.getString("password");
				String role = rs.getString("role");
				
//				System.out.println("UserID: " + userId);
//				System.out.println("Name: " + customerName);
//				System.out.println("Email: " + email);
//				System.out.println("Phone: " + phoneNumber);
//				System.out.println("Address: " + address);
				
				user = new User(userId, customerName, email, phoneNumber, address, password, role);
				
				
//				user.setUserId(userId);
//				user.setCustomerName(customerName);
//				user.setEmail(email);
//				user.setPhoneNumber(phoneNumber);
//				user.setAddress(address);
//				user.setPassword(password);
//				user.setRole(role);
//				
				customers.add(user);
			}
			
//			System.out.println("Customer List: " + customers);	
			DBUtil.closeAllConnection(cn, ps, rs);
		}
		catch(SQLException e) {
			System.out.println(e.getMessage());
		}
		
//		for(int i = 0; i < customers.size(); i++) {
//			System.out.println(customers.get(i).getCustomerName());
//		}
		return customers;
	}


public static boolean updateUser(User user) {
        boolean status = false;
        try {
            Connection cn = DBUtil.createConnection();
            PreparedStatement ps = cn.prepareStatement("UPDATE users set password=? where userid=?");
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getUserId());
        
            int rowsAffected = ps.executeUpdate();
            status = rowsAffected > 0;
            DBUtil.closeAllConnection(cn, ps, null);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return status;
    }


//    public static void main(String[] args) {
//		getAllCustomers();
//	}
    
    
}


/*
 package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bean.User;
import com.util.DBUtil;

public class UserDao {

    // Register method remains the same...

    // New method for login authentication
    public User getUserByIdAndPassword(String userId, String password) {
        User user = null;
        try {
            Connection cn = DBUtil.createConnection();
            String query = "SELECT * FROM users WHERE userId = ? AND password = ?";
            PreparedStatement ps = cn.prepareStatement(query);
            ps.setString(1, userId);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getString("userId"));
                user.setCustomerName(rs.getString("customerName"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }

            DBUtil.closeAllConnection(cn, ps, rs);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return user;
    }
}

*/
 