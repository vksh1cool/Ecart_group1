<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="bean.User" %>
<%@ page import="bean.Product" %>
<%@ page import="bean.Order" %>
<%@ page import="service.OrderService" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>E-Cart Home</title>
<link rel="stylesheet" type="text/css" href="./css/homepage.css">
<link rel="stylesheet" type="text/css" href="./css/viewAllOrders.css">
   
</head>
<body style="overflow-x: hidden;">
    <%
        User name = (User) session.getAttribute("user");
        ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
    %>
   <%@ include file="Header.jsp" %>
    
   <nav>
        <div class="container" style="flex-direction:row-reverse;">
            <div class="welcome">
            
             <% if(name != null){ %>
                <h3>Welcome, <%= name.getCustomerName() %></h3>
                                <div class="profile" onmouseenter="main()" onmouseleave="end()">
                    <img src="./images/user.png" alt="">
                    <ul class="user" id="profile" >
                        <li style="border-bottom: 1px solid rgb(231, 155, 41);"><a href="profile.jsp" >My profile</a></li>
                        <li><a href="Logout" style="color: red">Log out</a></li>
                    </ul>
                </div>
                           <button class="btn" onclick={window.history.back()}>
                    <a style="text-decoration:none;color:black;">&larr; Back</a></button>
           	<% } else { %>
           	  <button class="btn"><a href="login.jsp" style="text-decoration:none;color:black;">Login</a></button>      
           	<% } %>
            </div>
            <ul>
                <li><a href="home.jsp">Home</a></li>
            	<% if(name != null){if(name.getRole().equals("0")) {%>
                <li><a href=<%= (name != null) ? "myCart.jsp":"login.jsp" %>> My Cart</a></li>
                <li><a href=<%= (name != null) ? "myOrders.jsp":"login.jsp" %>> My Orders</a></li>
                <% } else { %>
                <li><a href=<%= (name != null) ? "addProduct.jsp":"login.jsp" %>> Add Products</a></li>
                <li><a href=<%= (name != null) ? "ProductServlet":"login.jsp" %>> View all Products</a></li>
                <li><a href=<%= (name != null) ? "ViewCustomersServlet":"login.jsp" %>> View all Customers</a></li>
                <li><a href=<%= (name != null) ? "viewAllOrders.jsp":"login.jsp" %>> View all Orders</a></li>
                   <li><a href=<%= (name != null) ? "AddAdmin.jsp":"login.jsp" %>> Add New Admin</a></li>
                <% }} %>
            </ul>
        </div>
    </nav>


    
    
   
   

    <h2>Confirmed Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order Id</th>
                <th>Ordered Item</th>
                <th>Ordered Date</th>
                <th>Arriving Date</th>
                <th>Address</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody>
            <%
            OrderService orderService = new OrderService();
            ArrayList<Order> orders = orderService.fetchAllOrders();
            if (orders != null) {
                for (Order order : orders) {
                    if ("Confirmed".equalsIgnoreCase(order.getStatus())) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                    <td><%= order.getArrivingDate() %></td>
                    <td><%= order.getAddress() %></td>
                    <td>
                        <form action="OrderServlet" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <input type="hidden" name="newStatus" value="In Transit">
                            <button type="submit" class="update-btn">Update</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                }
            }
            %>
        </tbody>
    </table>

    <h2>In Transit Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order Id</th>
                <th>Ordered Item</th>
                <th>Ordered Date</th>
                <th>Arriving Date</th>
                <th>Address</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody>
            <%
            if (orders != null) {
                for (Order order : orders) {
                    if ("In Transit".equalsIgnoreCase(order.getStatus())) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                    <td><%= order.getArrivingDate() %></td>
                    <td><%= order.getAddress() %></td>
                    <td>
                        <form action="OrderServlet"method="post">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <input type="hidden" name="newStatus" value="Delivered">
                            <a href="updateOrder.jsp"  class="update-btn">Update</a>
                        </form>
                    </td>
                </tr>
            <%
                    }
                }
            }
            %>
        </tbody>
    </table>

    <h2>Delivered Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order Id</th>
                <th>Ordered Item</th>
                <th>Ordered Date</th>
                <th>Address</th>
               
            </tr>
        </thead>
        <tbody>
            <%
            if (orders != null) {
                for (Order order : orders) {
                    if ("Delivered".equals(order.getStatus())) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                    <td><%= order.getAddress() %></td>
                   
                </tr>
            <%
                    }
                }
            }
            %>
        </tbody>
    </table>

    <h2>Cancelled Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order Id</th>
                <th>Ordered Item</th>
                <th>Ordered Date</th>
            </tr>
        </thead>
        <tbody>
            <%
            if (orders != null) {
                for (Order order : orders) {
                    if ("Cancelled".equals(order.getStatus())) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                </tr>
            <%
                    }
                }
            }
            %>
        </tbody>
    </table>

    <h2>Returned Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order Id</th>
                <th>Ordered Item</th>
                <th>Ordered Date</th>
            </tr>
        </thead>
        <tbody>
            <%
            if (orders != null) {
                for (Order order : orders) {
                    if ("Returned".equals(order.getStatus())) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                </tr>
            <%
                    }
                }
            }
            %>
        </tbody>
    </table>
    
    
  <%@ include file="Footer.jsp" %>
    
    <script src="./js/index.js"></script>
   
</body>
</html>