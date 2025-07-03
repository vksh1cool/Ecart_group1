<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.User" %>
<%@ page import="dao.OrderDao" %>
<%@ page import="bean.Product" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ page import="bean.Order" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
   <!-- Connect to your existing CSS file -->
	<link rel="stylesheet" href="./css/homepage.css"> 
</head>
<body>
 
<%
    // Get the logged-in user from session
   
    User user= (User) session.getAttribute("user");
	String username= user.getUserId();
    
%>
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
            	<% if(name != null){ %>
                <li><a href="home.jsp">Home</a></li>
            	<% if(name.getRole().equals("0")) {%>
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


<div class="orders-section">
    <h2>My Orders</h2>
    
    <!-- Dropdown to filter orders -->
    <label for="orderCategory">Filter by Order Category:</label>
    <select id="orderCategory" onchange="filterOrders()">
        <option value="confirmed">Confirmed</option>
        <option value="inTransit">In Transit</option>
        <option value="delivered">Delivered</option>
        <option value="cancelled">Cancelled</option>
    </select>

    <%
        OrderDao orderDAO = new OrderDao();
        List<Order> confirmedOrders = orderDAO.getOrdersByStatus(username, "Confirmed");
        List<Order> inTransitOrders = orderDAO.getOrdersByStatus(username, "In Transit");
        List<Order> deliveredOrders = orderDAO.getOrdersByStatus(username, "Delivered");
        List<Order> cancelledOrders = orderDAO.getOrdersByStatus(username, "Cancelled");
    %>

    <!-- Confirmed Orders -->
    <div id="confirmedOrders" class="orderTable">
        <h3>Confirmed Orders</h3>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Ordered Item</th>
                    <th>Ordered Date</th>
                    <th>Arriving Date</th>
                    <th>Address</th>
                    <th>Cancel</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Order order : confirmedOrders) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                    <td><%= order.getArrivingDate() %></td>
                    <td><%= order.getAddress() %></td>
                   
                    <td><button onclick="deleteOrder('<%= order.getOrderId() %>')">Cancel</button></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- In Transit Orders -->
    <div id="inTransitOrders" class="orderTable" style="display:none;">
        <h3>In Transit Orders</h3>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Ordered Item</th>
                    <th>Ordered Date</th>
                    <th>Arriving Date</th>
                    <th>Address</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Order order : inTransitOrders) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                     <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                    <td><%= order.getArrivingDate() %></td>
                    <td><%= order.getAddress() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Delivered Orders -->
    <div id="deliveredOrders" class="orderTable" style="display:none;">
        <h3>Delivered Orders</h3>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Ordered Item</th>
                    <th>Ordered Date</th>
                    <th>Delivered Date</th>
                    <th>Address</th>
                    <th>Feedback</th>
                    <th>Return</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Order order : deliveredOrders) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                     <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                    <td><%= order.getDeliveredDate() %></td>
                    <td><%= order.getAddress() %></td>
                    <td><button onclick="giveFeedback('<%= order.getOrderId() %>')">Feedback</button></td>
                    <td><button onclick="returnOrder('<%= order.getOrderId() %>')">Return</button></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Cancelled Orders -->
    <div id="cancelledOrders" class="orderTable" style="display:none;">
        <h3>Cancelled Orders</h3>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Ordered Item</th>
                    <th>Ordered Date</th>
                    <th>Cancelled Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Order order : cancelledOrders) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderedItem() %></td>
                    <td><%= order.getOrderedDate() %></td>
                    <td><%= order.getCancelledDate() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="Footer.jsp" %>
    
    <script src="./js/index.js"></script>
<!-- JavaScript Section -->
<script>
    // Function to update the displayed orders based on the selected filter
    function filterOrders() {
        const selectedCategory = document.getElementById('orderCategory').value;

        // Hide all order tables first
        document.getElementById('confirmedOrders').style.display = 'none';
        document.getElementById('inTransitOrders').style.display = 'none';
        document.getElementById('deliveredOrders').style.display = 'none';
        document.getElementById('cancelledOrders').style.display = 'none';

        // Show the table corresponding to the selected category
        switch (selectedCategory) {
            case 'confirmed':
                document.getElementById('confirmedOrders').style.display = 'block';
                break;
            case 'inTransit':
                document.getElementById('inTransitOrders').style.display = 'block';
                break;
            case 'delivered':
                document.getElementById('deliveredOrders').style.display = 'block';
                break;
            case 'cancelled':
                document.getElementById('cancelledOrders').style.display = 'block';
                break;
        }
    }

    // Update Order
    function updateOrder(orderId) {
        const newAddress = prompt('Enter new address for Order ID ' + orderId);
        if (newAddress) {
            window.location.href = `MyOrdersServlet?action=update&orderId=${orderId}&newAddress=${newAddress}`;
        }
    }

    // Delete Order
    function deleteOrder(orderId) {
        if (confirm('Are you sure you want to Cancel Order ID: ' + orderId + '?')) {
            window.location.href = `MyOrdersServlet?action=delete&orderId=${orderId}`;
        }
    }

    // Set the default view to "Confirmed Orders" on page load
    window.onload = function() {
        filterOrders();
    };
</script>

</body>
</html>
