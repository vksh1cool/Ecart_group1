package web;

import bean.Order;
import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/ViewOrdersServlet")
public class ViewOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = request.getParameter("status");
        ArrayList<Order> orders;

        if (status != null && !status.isEmpty()) {
            orders = orderService.fetchOrdersByStatus(status);
        } else {
            orders = orderService.fetchAllOrders();
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("viewAllOrders.jsp").forward(request, response);
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String orderId = request.getParameter("orderId");
//        String newStatus = request.getParameter("newStatus");
//
//        orderService.changeOrderStatus(orderId, newStatus);
//        response.sendRedirect("orders"); // Redirect back to the orders page
//    }
}


