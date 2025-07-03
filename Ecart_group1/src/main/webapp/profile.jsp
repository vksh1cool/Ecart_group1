<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="bean.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/homepage.css">
    <title>Profile</title>
</head>
<body>
    <% int num = 0; User name = (User) session.getAttribute("user"); %>
    
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

    


    
    
    

    <div class="userProfile">
        <div class="profile-container">
            <div class="profile-header">
                <div class="profile-img">
                    <img src="./images/user.png" alt="Profile Image">
                </div>
                <div class="profile-info">
                    <h1> <%= name.getCustomerName() %></h1>
                    <p class="email"><%= name.getUserId() %></p>
                </div>
            </div>
    
            <div class="profile-details">
                <div class="detail-item">
                    <h3>Email</h3>
                    <p><%= name.getEmail() %></p>
                </div>
                <div class="detail-item">
                    <h3>Phone Number</h3>
                    <p><%= name.getPhoneNumber() %></p>
                </div>
				<div>
			   <a href="UpdatePassword.jsp">Update Password</a>
               <a href="Logout" style="color: red">Log out</a>
				</div>
            </div>
        </div>
        
    </div>
    
    
    
   <%@ include file="Footer.jsp" %>

	<script src="js/index.js"></script>
</body>
</html>