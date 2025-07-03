<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="bean.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/homepage.css"> <!-- Link your CSS file -->
    <title>Add Product</title>
    <style>
        @charset "ISO-8859-1";
        .form-container {
            max-width: 600px;
            margin: 2em auto;
            background-color: white;
            padding: 2em;
            border-radius: 1em;
            box-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 1em;
        }
        label {
            display: block;
            margin-bottom: 0.5em;
            font-weight: bold;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 0.5em;
            border: 1px solid #ccc;
            border-radius: 0.5em;
        }
        .btn {
            width: 9vw;
            height: 5vh;
            border: 1px solid black;
            background-color: rgb(255, 191, 96);
            color: black;
            font-weight: bold;
            border-radius: 2em;
            cursor: pointer;
            margin-right: 1em;
        }
        .acknowledgment {
            display: none;
            text-align: center;
            margin-top: 2em;
            color: green;
        }
        .acknowledgment p {
            margin: 0.5em 0;
        }
    </style>
</head>
<body>


<% User name = (User) session.getAttribute("user"); %>
	
	<%@  include file="Header.jsp" %>
	
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
                <li><a href=<%= (name != null) ? "view_all_products.jsp":"login.jsp" %>> View all Products</a></li>
                <li><a href=<%= (name != null) ? "view_all_customers.jsp":"login.jsp" %>> View all Customers</a></li>
                <li><a href=<%= (name != null) ? "viewAllOrders.jsp":"login.jsp" %>> View all Orders</a></li>
               <li><a href=<%= (name != null) ? "AddAdmin.jsp":"login.jsp" %>> Add New Admin</a></li>
                <% }} %>
            </ul>
        </div>
    </nav>
<div class="form-container">
    <h2>Add Product</h2>
    <form id="addProductForm" method="post" action="AddProductServlet">
        
        <div class="form-group">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" maxlength="50" required>
        </div>
        <div class="form-group">
            <label for="productPrice">Product Price:</label>
            <input type="number" id="productPrice" name="productPrice" step="0.01" required>
        </div>
        <div class="form-group">
            <label for="productCategory">Product Category:</label>
            <input type="text" id="productCategory" name="productCategory" required>
        </div>
        <div class="form-group">
            <label for="productDescription">Product Description:</label>
            <input type="text" id="productDescription" name="productDescription" maxlength="200" required>
        </div>
        <button type="submit" class="btn">Register</button>
        <button type="reset" class="btn">Reset</button>
    </form>

    <div class="acknowledgment" id="acknowledgment">
        <p id="acknowledgeId"></p>
        <p id="acknowledgeName"></p>
        <p id="acknowledgePrice"></p>
    </div>
</div>

<%@ include file="Footer.jsp" %>

</body>
</html>