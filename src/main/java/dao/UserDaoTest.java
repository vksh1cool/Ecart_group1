package dao;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import bean.User;
import dao.UserDao;
import util.DBUtil;

public class UserDaoTest {

    @Mock
    private Connection mockConnection;

    @Mock
    private PreparedStatement mockPreparedStatement;

    @Mock
    private ResultSet mockResultSet;

    @InjectMocks
    private UserDao userDao;

    @Before
    public void setUp() throws SQLException {
    	 MockitoAnnotations.initMocks(this);
        when(DBUtil.createConnection()).thenReturn(mockConnection);
    }

    @Test
    public void testRegisterUser() throws SQLException {
        User user = new User("U01", "John Doe", "john.doe@example.com", "1234567890", "123 Street", "password123", "1");
        
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);

        boolean result = userDao.registerUser(user);
        assertTrue(result);

        verify(mockPreparedStatement, times(1)).setString(1, "U01");
        verify(mockPreparedStatement, times(1)).setString(2, "John Doe");
        verify(mockPreparedStatement, times(1)).setString(3, "john.doe@example.com");
        verify(mockPreparedStatement, times(1)).setString(4, "1234567890");
        verify(mockPreparedStatement, times(1)).setString(5, "123 Street");
        verify(mockPreparedStatement, times(1)).setString(6, "password123");
        verify(mockPreparedStatement, times(1)).setString(7, "1");
        verify(mockPreparedStatement, times(1)).executeUpdate();
    }

    @Test
    public void testGetUserByEmailOrPhone() throws SQLException {
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);

        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getString("userId")).thenReturn("U01");
        when(mockResultSet.getString("customerName")).thenReturn("John Doe");
        when(mockResultSet.getString("email")).thenReturn("john.doe@example.com");
        when(mockResultSet.getString("phone")).thenReturn("1234567890");
        when(mockResultSet.getString("address")).thenReturn("123 Street");
        when(mockResultSet.getString("password")).thenReturn("password123");
        when(mockResultSet.getString("role")).thenReturn("1");

        User result = userDao.getUserByEmailOrPhone("john.doe@example.com", "1234567890");
        assertNotNull(result);
        assertEquals("U01", result.getUserId());
        assertEquals("John Doe", result.getCustomerName());
        assertEquals("john.doe@example.com", result.getEmail());

        verify(mockPreparedStatement, times(1)).setString(1, "john.doe@example.com");
        verify(mockPreparedStatement, times(1)).setString(2, "1234567890");
        verify(mockPreparedStatement, times(1)).executeQuery();
    }

    @Test
    public void testGetUserByIdAndPassword() throws SQLException {
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);

        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getString("userId")).thenReturn("U01");
        when(mockResultSet.getString("customerName")).thenReturn("John Doe");
        when(mockResultSet.getString("email")).thenReturn("john.doe@example.com");
        when(mockResultSet.getString("phone")).thenReturn("1234567890");
        when(mockResultSet.getString("address")).thenReturn("123 Street");
        when(mockResultSet.getString("password")).thenReturn("password123");
        when(mockResultSet.getString("role")).thenReturn("1");

        User result = userDao.getUserByIdAndPassword("U01", "password123");
        assertNotNull(result);
        assertEquals("U01", result.getUserId());
        assertEquals("John Doe", result.getCustomerName());
        assertEquals("password123", result.getPassword());

        verify(mockPreparedStatement, times(1)).setString(1, "U01");
        verify(mockPreparedStatement, times(1)).setString(2, "password123");
        verify(mockPreparedStatement, times(1)).executeQuery();
    }

    @Test
    public void testGetAllCustomers() throws SQLException {
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);

        when(mockResultSet.next()).thenReturn(true).thenReturn(false);
        when(mockResultSet.getString("userId")).thenReturn("U01");
        when(mockResultSet.getString("customerName")).thenReturn("John Doe");
        when(mockResultSet.getString("email")).thenReturn("john.doe@example.com");
        when(mockResultSet.getString("phone")).thenReturn("1234567890");
        when(mockResultSet.getString("address")).thenReturn("123 Street");
        when(mockResultSet.getString("password")).thenReturn("password123");
        when(mockResultSet.getString("role")).thenReturn("0");

        List<User> customers = userDao.getAllCustomers();
        assertNotNull(customers);
        assertEquals(1, customers.size());
        User result = customers.get(0);
        assertEquals("U01", result.getUserId());
        assertEquals("John Doe", result.getCustomerName());

        verify(mockPreparedStatement, times(1)).setString(1, "0");
        verify(mockPreparedStatement, times(1)).executeQuery();
    }

    @Test
    public void testUpdateUser() throws SQLException {
        User user = new User("U01", "John Doe", "john.doe@example.com", "1234567890", "123 Street", "newpassword", "1");
        
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);

        boolean result = UserDao.updateUser(user);
        assertTrue(result);

        verify(mockPreparedStatement, times(1)).setString(1, "newpassword");
        verify(mockPreparedStatement, times(1)).setString(2, "U01");
        verify(mockPreparedStatement, times(1)).executeUpdate();
    }
}