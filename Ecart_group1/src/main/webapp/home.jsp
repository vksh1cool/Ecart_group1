<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="bean.User" %>
<%@ page import="bean.Product" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>E-Cart Home</title>
<link rel="stylesheet" type="text/css" href="./css/homepage.css">
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
            	<% if(name != null){ %>
                <li><a href="home.jsp">Home</a></li>
            	<% if(name.getRole().equals("0")) {%>
                <li><a href=<%= (name != null) ? "myCart.jsp":"login.jsp" %>> My Cart</a></li>
                <li><a href=<%= (name != null) ? "myOrders.jsp":"login.jsp" %>> My Orders</a></li>
                <% } else { %>
                <li><a href=<%= (name != null) ? "addProduct.jsp":"login.jsp" %>> Add Products</a></li>
                <li><a href=<%= (name != null) ? "ProductServlet":"login.jsp" %>> View all Products</a></li>
                <li><a href=<%= (name != null) ? "ViewCustomersServlet":"login.jsp" %>> View all Customers</a></li>
                <li><a href=<%= (name != null) ? "ViewOrdersServlet":"login.jsp" %>> View all Orders</a></li>
                   <li><a href=<%= (name != null) ? "AddAdmin.jsp":"login.jsp" %>> Add New Admin</a></li>
                <% }} %>
            </ul>
        </div>
    </nav>

    <div class="background"></div>
    
    <h1 style="text-align:center;color:rgb(231, 155, 41);margin-bottom:2em;">Welcome to E-Cart</h1>

    <% if (name != null && name.getRole().equals("0")) { %>
        <h1 style="display:flex;justify-content:center;">Products</h1>
        <div class="cards">
            <% for (Product product : products) { %>
                <div class="product-card">
                    <h2 class="product-name"><%= product.getProductName() %></h2>
                    <p class="product-description"><%= product.getProductDescription() %></p>
                    <p class="product-price">Rs.<%= product.getProductPrice() %></p>
                   <button class="add-to-cart" style="border:none;cursor:pointer;" onclick="addToCart(<%= product.getProductId() %>)">Add to Cart</button>

                </div>
                
                
                
            <% } %>
        </div>
    <% } %>
    
    <%@ include file="Footer.jsp" %>
    
    <script src="./js/index.js"></script>
    
    
    <script>
    function addToCart(productId) {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "AddToCartServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                alert("Product added to cart!");
            }
        };
        xhr.send("productId=" + productId);
    }
    
    </script>
</body>
</html>
