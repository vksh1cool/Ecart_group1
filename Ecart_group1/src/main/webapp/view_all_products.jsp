<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="service.ProductService" %>
<%@ page import="bean.Product" %>
<%@ page import="bean.User" %>
<%@ page import="bean.Product" %>
<%@ page import="bean.Order" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View All Products</title>
    
        <link rel="stylesheet" href="./css/homepage.css">
        <style>
        
.products {
    margin: 2em;
    padding: 1em;
    background-color: white;
    border-radius: 1em;
    box-shadow: 1px 1px 4px -1px rgba(0, 0, 0, 0.75);
}

.products h2 {
    margin-bottom: 1em;
    text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 1em;
}

th, td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #f2f2f2;
    color: #333;
}

tr:hover {
    background-color: #f9f9f9;
}

button {
    background-color: rgb(255, 191, 96);
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #f8c471;
}


        
        </style>
</head>
<body>
<% User name = (User) session.getAttribute("user"); %>
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

<div class="products">
    <h2>Products</h2>
    <table>
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Product Price</th>
                <th>Product Category</th>
                <th>Product Description</th>
                <th>Update</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
           <%
			ProductService productService = new ProductService();
    		List<Product> productList = productService.getAllProducts();
    		
    		if(productList != null){
    			
    		
    		for(Product product: productList) {
			%>
                <tr>
                    <td><%= product.getProductId() %></td>
                    <td><%= product.getProductName() %></td>
                    <td><%= product.getProductPrice() %></td>
                    <td><%= product.getProductCategory() %></td>
                    <td><%= product.getProductDescription() %></td>
                    <td>
                    <form action="UpdateProduct.jsp" method="post">
                  
                            <input type="hidden" name="productName" value="<%= product.getProductName() %>">
                            <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                            <button type="submit">Update</button>
                        </form>
                    </td>
                    <td>
                         <form action="DeleteProduct" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');">
                  
                            <input type="hidden" name="productName" value="<%= product.getProductName() %>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                    
                </tr>
            <%
                }}
            %>
        </tbody>
    </table>
</div>
 <%@ include file="Footer.jsp" %>
    
    <script src="./js/index.js"></script>
</body>
</html>
