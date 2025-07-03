package service;

import bean.Order;
import dao.OrderDao;

import java.util.ArrayList;

public class OrderService {
    private OrderDao orderDao;

    public OrderService() {
        orderDao = new OrderDao();
    }

    public ArrayList<Order> fetchAllOrders() {
        return orderDao.getAllOrders();
    }

    public ArrayList<Order> fetchOrdersByStatus(String status) {
        return orderDao.getOrdersByStatus(status);
    }

//    public boolean changeOrderStatus(String orderId, String newStatus) {
//        return orderDao.updateOrderStatus(orderId, newStatus);
//    }
}
