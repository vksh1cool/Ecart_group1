<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="bean.User" %>
<%@ page import="bean.Product" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice</title>
    <link rel="stylesheet" href="./css/invoice.css">
    <link rel="stylesheet" type="text/css" href="./css/homepage.css">
</head>
<body>

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
        
    <div class="invoice-container" id="invoice-content" style="height:90vh;width:50vw;">
        <h1>Invoice</h1>
        <p><strong>Order ID:</strong> <span id="order-id"></span></p>
        <p><strong>Payment Method:</strong> <span id="payment-method"></span></p>
        <p><strong>Name:</strong> <span id="name"></span></p>
      
        
        <button id="print-invoice" onclick={window.print();}>Print Invoice</button>
        <button id="go-home">Go to Home</button>
    </div>
 <%@ include file="Footer.jsp" %>
    
    <script src="./js/index.js"></script>
    <script src="./js/invoice.js"></script>
</body>
</html>
    