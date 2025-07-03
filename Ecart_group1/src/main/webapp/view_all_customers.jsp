<%@ page import="java.util.List" %>
<%@ page import="bean.User" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/homepage.css">
</head>
<body>
	<%@  include file="Header.jsp" %>
	<% User name = (User) session.getAttribute("user"); %>
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
                <li><a href=<%= (name != null) ? "ViewCustomersServlet":"login.jsp" %>> View all Customers</a></li>
                <li><a href=<%= (name != null) ? "viewAllOrders.jsp":"login.jsp" %>> View all Orders</a></li>
                <li><a href=<%= (name != null) ? "AddAdmin.jsp":"login.jsp" %>> Add New Admin</a></li>
                <% }} %>
            </ul>
        </div>
    </nav>
	
	<h2> Customers </h2>
    <div class="table-container">

    
    <table>
        <tr>
            <th> Customer ID</th>
            <th> Customer Name</th>
            <th> Email </th>
            <th> Mobile Number </th>
            <th> Address</th>
            
        </tr>
   
       	<%
       		List<User> customerList = (List<User>) request.getAttribute("customerList");
       		if(customerList != null) {
   				for(User customer: customerList) { 
       	%>
       		<tr>
            	<td> <%= customer.getUserId() %>  </td>
            	<td>  <%= customer.getCustomerName() %> </td>
            	<td> <%= customer.getEmail() %>  </td>
            	<td> <%= customer.getPhoneNumber() %> </td>
            	<td> <%= customer.getAddress() %>  </td>
            	
        	</tr>
        <%
       			}
	       	} else {
       			
        %>
        	
        	<tr>
        		<td colspan="5"> No customers found </td>
        	</tr>
       	
       	<%
       		}
       	%>	 
    </table>
	</div>
	
	<%@  include file="Footer.jsp" %>
	<script src="./js/index.js"></script>
</body>
</html>