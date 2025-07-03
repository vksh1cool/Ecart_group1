<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="bean.User" %>
<%@ page import="bean.Product" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Admin</title>
<link rel="stylesheet" type="text/css" href="./css/homepage.css">
<style>


.form{
	display:flex;
	justify-center:center;
}

.form h2 {
    margin-bottom: 1em;
    color: black;
}

.form2 {
    display: flex;
    flex-direction: column; /* Changed to column for vertical layout */
    justify-content: center;
    align-items: center;
    width: 100%;
}



/* Flexbox alignment for input rows */
.row {
    display: flex;
    justify-content: space-between; /* Maintain space between inputs */
    width: 100%;
    margin-bottom: 1em; /* Add consistent margin between rows */
}

input, select {
    flex: 1; /* Allow inputs to grow equally */
    height: 5vh;
    padding: 0 1em;
    border-radius: 4px;
    border: 1px solid #ccc;
    outline: none;
    margin-right: 0.5em; /* Add space between inputs */
}

input:last-child,
select:last-child {
    margin-right: 0;/* Remove margin for the last element */
}

/* Space between inputs in the same row */
.row > input {
    margin-right: 0.5em; /* Add margin to the right of the first input */
}

.row > input:last-child {
    margin-right: 0; /* Remove margin for the last input */
}

/* Country Code and Mobile Number Row */
.country-code {
    flex: 0 1 20%; /* Set country code dropdown to be smaller */
}

.phone-number {
    flex: 1; /* Allow phone number to take the rest of the space */
}

/* Address field takes full width with margin */
.address {
    width: 100%; /* Full width for address field */
    margin-bottom: 1em; /* Add margin to separate it from password fields */
}

/* Password fields also have margin */
.password {
    width: 100%;
    margin-bottom: 1em; /* Add margin to maintain spacing */
}

/* Link style for "Already Registered? Login" */
.login a {
    color: black; /* Set login link color to black */
    text-decoration: none; /* No underline by default */
}

.login a:hover {
    text-decoration: underline; /* Underline on hover */
}

/* Buttons */
.btn {
    width: 12vw;
    height: 5vh;
    color: white;
    background-color: rgb(255, 191, 96);
    cursor: pointer;
    border: none;
    border-radius: 0.25em;
    margin: 1em 0;
}

.btn:hover {
    background-color: rgb(236, 179, 92);
}

a {
    color: rgb(255, 191, 96);
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

/* Media Queries */
@media (max-width: 768px) {
    .form {
        width: 80vw;
    }

    .row > input, .row > select {
        width: 100%; /* Stack input fields on mobile */
        margin-right: 0; /* Remove margin for mobile view */
    }

    .btn {
        width: 100%; /* Full width buttons on smaller screens */
    }

    .country-code, .phone-number {
        width: 100%; /* Stack country code and phone on mobile */
    }
}

@media (max-width: 480px) {
    .form {
        width: 90vw;
    }
}

</style>
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

    <div class="body">
        <div class="form">
    <form action="AddAdmin" method="post">
    <h2>Add New Admin</h2>
        <div class="form2">
            <div class="row">
                <input type="text" placeholder="Customer Name" name="customerName" id="customerName" required>
            </div>
            <div class="row">
                <input type="email" placeholder="Email" name="email" id="email" required>
            </div>
            <div class="row">
                <select class="country-code" required name="countryCode" id="countryCode">
                    <option value="+91">+91</option>
                    <option value="+1">+1</option>
                    <option value="+44">+44</option>
                </select>
                <input type="tel" class="phone-number" placeholder="Phone Number" name="phoneNumber" id="phoneNumber" required>
            </div>
            <div class="row">
                <input type="text" class="address" placeholder="Address" name="address" id="address" required>
            </div>
            <div class="row">
                <input type="password" class="password" placeholder="Password" name="password" id="password" required>
            </div>
            <div class="row">
                <input type="password" class="password" placeholder="Confirm Password" name="confirmPassword" id="confirmPassword" required>
            </div>

            <div class="row" style="justify-content: space-between;">
                <button class="btn" type="submit" style="margin-right:3px">Register</button>
                <button class="btn" type="reset">Reset</button>
            </div>
        </div>
    </form>
</div>

    </div>
    
    <%@ include file="Footer.jsp" %>
<script src="js/script.js"></script>
</body>
</html>