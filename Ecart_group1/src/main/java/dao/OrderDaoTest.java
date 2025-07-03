//import dao.OrderDao;
package dao;
import bean.Order;
import util.DBUtil;

import org.junit.Before;
//import org.junit.BeforeEach;
import org.junit.Test;
import org.mockito.Mockito;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

public class OrderDaoTest {

    private OrderDao orderDao;
    private Connection mockConnection;
    private Statement mockStatement;
    private PreparedStatement mockPreparedStatement;
    private ResultSet mockResultSet;

    @Before
    public void setUp() {
        orderDao = new OrderDao();
        mockConnection = Mockito.mock(Connection.class);
        mockStatement = Mockito.mock(Statement.class);
        mockPreparedStatement = Mockito.mock(PreparedStatement.class);
        mockResultSet = Mockito.mock(ResultSet.class);

        // Mock DBUtil to return the mock connection
//        DBUtil mockDBUtil = mock(DBUtil.class);
//        when(mockDBUtil.createConnection()).thenReturn(mockConnection);
    }

    @Test
   public void testGetAllOrders() throws Exception {
        // Arrange
        String sql = "SELECT * FROM Orders";
        when(mockConnection.createStatement()).thenReturn(mockStatement);
        when(mockStatement.executeQuery(sql)).thenReturn(mockResultSet);

        when(mockResultSet.next()).thenReturn(true).thenReturn(false); // Simulate one result
        when(mockResultSet.getString("order_id")).thenReturn("1");
        when(mockResultSet.getString("ordered_item")).thenReturn("Laptop");
        when(mockResultSet.getString("ordered_date")).thenReturn("2023-10-01");
        when(mockResultSet.getString("arriving_date")).thenReturn("2023-10-05");
        when(mockResultSet.getString("address")).thenReturn("123 Street");
        when(mockResultSet.getString("status")).thenReturn("Shipped");

        // Act
        ArrayList<Order> orders = orderDao.getAllOrders();

        // Assert
        assertNotNull(orders);
        assertEquals(1, orders.size());

        Order order = orders.get(0);
        assertEquals("1", order.getOrderId());
        assertEquals("Laptop", order.getOrderedItem());
        assertEquals("2023-10-01", order.getOrderedDate());
        assertEquals("2023-10-05", order.getArrivingDate());
        assertEquals("123 Street", order.getAddress());
        assertEquals("Shipped", order.getStatus());
    }

    @Test
    public void testGetOrdersByStatus() throws Exception {
        // Arrange
        String sql = "SELECT * FROM orders WHERE status = '?'";
        when(mockConnection.prepareStatement(sql)).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);

        when(mockResultSet.next()).thenReturn(true).thenReturn(false); // Simulate one result
        when(mockResultSet.getString("order_id")).thenReturn("1");
        when(mockResultSet.getString("ordered_item")).thenReturn("Laptop");
        when(mockResultSet.getString("ordered_date")).thenReturn("2023-10-01");
        when(mockResultSet.getString("arriving_date")).thenReturn("2023-10-05");
        when(mockResultSet.getString("address")).thenReturn("123 Street");
        when(mockResultSet.getString("status")).thenReturn("Shipped");

        // Act
        ArrayList<Order> orders = orderDao.getOrdersByStatus("Shipped");

        // Assert
        assertNotNull(orders);
        assertEquals(1, orders.size());

        Order order = orders.get(0);
        assertEquals("1", order.getOrderId());
        assertEquals("Laptop", order.getOrderedItem());
        assertEquals("2023-10-01", order.getOrderedDate());
        assertEquals("2023-10-05", order.getArrivingDate());
        assertEquals("123 Street", order.getAddress());
        assertEquals("Shipped", order.getStatus());
    }

//    @Test
//   public void testUpdateOrderStatus() throws Exception {
//        // Arrange
//        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
//        when(mockConnection.prepareStatement(sql)).thenReturn(mockPreparedStatement);
//        when(mockPreparedStatement.executeUpdate()).thenReturn(1); // Simulate update success
//
//        // Act
//        boolean result = orderDao.updateOrderStatus("1", "Delivered");
//
//        // Assert
//        assertTrue(result);
//    }
}
