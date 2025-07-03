package web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Order;
import dao.OrderDao;

@WebServlet("/MyOrdersServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDao;

    @Override
    public void init() {
        orderDao = new OrderDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hardcoded username for testing
        String userId = "2";  // You can replace with any valid username from your database

        // Fetch orders based on status
        List<Order> confirmedOrders = orderDao.getOrdersByStatus(userId, "confirmed");
        List<Order> inTransitOrders = orderDao.getOrdersByStatus(userId, "inTransit");
        List<Order> deliveredOrders = orderDao.getOrdersByStatus(userId, "delivered");
        List<Order> cancelledOrders = orderDao.getOrdersByStatus(userId, "cancelled");

        // Set attributes to send to the JSP page
        request.setAttribute("confirmedOrders", confirmedOrders);
        request.setAttribute("inTransitOrders", inTransitOrders);
        request.setAttribute("deliveredOrders", deliveredOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);

        // Forward to JSP for displaying the orders
        request.getRequestDispatcher("myorders.jsp").forward(request, response);
    }

    // This servlet is just for testing, so we are not handling post requests or updates
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("MyOrdersServlet");
    }
}
