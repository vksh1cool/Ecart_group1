package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.Order;
import util.DBUtil;

public class OrderDao {
    // Fetch orders by username
    public List<Order> getOrdersByUsername(String username) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE username = ?";

        try (Connection cn = DBUtil.createConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getString("orderId"));
                order.setUserId(rs.getString("userId"));
                order.setOrderedItem(rs.getString("orderedItem"));
                order.setOrderedDate(rs.getString("orderedDate"));
                order.setArrivingDate(rs.getString("arrivingDate"));
                order.setDeliveredDate(rs.getString("deliveredDate"));
                order.setCancelledDate(rs.getString("cancelledDate"));
                order.setAddress(rs.getString("address"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching orders: " + e.getMessage());
        }

        return orders;
    }

    // Fetch orders by username and status
    public List<Order> getOrdersByStatus(String userId, String status) {
        List<Order> orders = new ArrayList<>();
//        System.out.println("First");
        String sql = "SELECT * FROM orders WHERE userid = ? AND status = ?";
        System.out.println("User Id: "+userId);
        try (Connection cn = DBUtil.createConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
        if(rs!=null)
        {
        	;
            while (rs.next()) {
            	
                Order order = new Order();
                order.setOrderId(rs.getString("orderId"));
                order.setUserId(rs.getString("userId"));
                order.setOrderedItem(rs.getString("orderedItem"));
                order.setOrderedDate(rs.getString("orderedDate"));
                order.setArrivingDate(rs.getString("arrivingDate"));
                order.setDeliveredDate(rs.getString("deliveredDate"));
                order.setCancelledDate(rs.getString("cancelledDate"));
                order.setAddress(rs.getString("address"));
                order.setStatus(rs.getString("status"));
                orders.add(order);
         
            }
        }
        else {
        	throw new RuntimeException("Result set is Empty");
        }
        } catch (SQLException e) {
            System.out.println("Error fetching orders by status: " + e.getMessage());
        } 
        catch (RuntimeException re) {
        	System.out.println(re.getMessage());
        }

        return orders;
    }

    public ArrayList<Order> getAllOrders() {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders "; // Replace with your table name

        try (Connection connection = DBUtil.createConnection(); // Use the instance to get a connection
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                Order order = new Order();
                order.setOrderId(resultSet.getString("orderId"));
                order.setOrderedItem(resultSet.getString("orderedItem"));
                order.setOrderedDate(resultSet.getString("orderedDate"));
                order.setArrivingDate(resultSet.getString("arrivingDate"));
                order.setAddress(resultSet.getString("address"));
                order.setStatus(resultSet.getString("status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public ArrayList<Order> getOrdersByStatus(String status) {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE status = '?'"; // Replace with your table name

        try (Connection connection = DBUtil.createConnection(); // Use the instance
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            ResultSet resultSet = statement.executeQuery();
//           System.out.println(resultSet.getFetchSize());

            while (resultSet.next()) {
                Order order = new Order();
                order.setOrderId(resultSet.getString("order_id"));
                order.setOrderedItem(resultSet.getString("ordered_item"));
                order.setOrderedDate(resultSet.getString("ordered_date"));
                order.setArrivingDate(resultSet.getString("arriving_date"));
                order.setAddress(resultSet.getString("address"));
                order.setStatus(resultSet.getString("status"));
                orders.add(order);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

	
}
