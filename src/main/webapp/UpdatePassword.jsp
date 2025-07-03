
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
    <title>Update Password</title>
    <link rel="stylesheet" href="./css/homepage.css">
</head>
<body>
<%  String passwordUpdated = (String) session.getAttribute("passwordUpdated"); %>
<% if (passwordUpdated != null) { %>
    <script>
        <% if ("true".equals(passwordUpdated)) { %>
            alert("Password updated successfully!");
        <% } else if ("false".equals(passwordUpdated)) { %>
            alert("Password update failed. Please try again.");
        <% } else if ("samePassword".equals(passwordUpdated)) { %>
            alert("The new password cannot be the same as the current password.");
        <% } else if ("invalidPassword".equals(passwordUpdated)) { %>
            alert("Password must contain at least one special character, one uppercase letter, one lowercase letter, one number, and be at least 8 characters long.");
        <% } %>
    </script>
    <%
        session.removeAttribute("passwordUpdated"); // Remove the attribute after displaying the message
    }
%>

<%
    User name = (User) session.getAttribute("user");
    ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
%>

<%@ include file="Header.jsp" %>

<nav>
    <div class="container" style="flex-direction:row-reverse;">
        <div class="welcome">
            <% if(name != null) { %>
                <h3>Welcome, <%= name.getCustomerName() %></h3>
                <div class="profile" onmouseenter="main()" onmouseleave="end()">
                    <img src="./images/user.png" alt="">
                    <ul class="user" id="profile">
                        <li style="border-bottom: 1px solid rgb(231, 155, 41);">
                            <a href="profile.jsp">My profile</a>
                        </li>
                        <li><a href="Logout" style="color: red">Log out</a></li>
                    </ul>
                </div>
                <button class="btn" onclick="window.history.back()">
                    <a style="text-decoration:none;color:black;">&larr; Back</a>
                </button>
            <% } else { %>
                <button class="btn">
                    <a href="login.jsp" style="text-decoration:none;color:black;">Login</a>
                </button>
            <% } %>
        </div>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <% if(name != null) {
                if(name.getRole().equals("0")) { %>
                    <li><a href="myCart.jsp">My Cart</a></li>
                    <li><a href="myOrders.jsp">My Orders</a></li>
                <% } else { %>
                    <li><a href="addProduct.jsp">Add Products</a></li>
                    <li><a href="ProductServlet">View all Products</a></li>
                    <li><a href="ViewCustomersServlet">View all Customers</a></li>
                    <li><a href="viewAllOrders.jsp">View all Orders</a></li>
                    <li><a href="AddAdmin.jsp">Add New Admin</a></li>
                <% }
            } %>
        </ul>
    </div>
</nav>

<div class="form">
    <h2>Update Password</h2>
    <form action="UpdatePassword" method="POST" onsubmit="return validatePassword()">
        <label for="currentPassword">Current Password:</label>
        <input type="password" id="currentPassword" name="currentPassword" required><br><br>

        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required><br><br>

        <input type="submit" value="Update Password">
    </form>
</div>

<%@ include file="Footer.jsp" %>

<script>
    function validatePassword() {
        const currentPassword = document.getElementById('currentPassword').value;
        const newPassword = document.getElementById('newPassword').value;

        // Regular expression for password validation
        const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

        if (newPassword === currentPassword) {
            alert("The new password cannot be the same as the current password.");
            return false;
        }

        if (!regex.test(newPassword)) {
            alert("Password must contain at least one special character, one uppercase letter, one lowercase letter, one number, and be at least 8 characters long.");
            return false; // Prevent form submission
        }

        return true; // Allow form submission
    }
</script>

<script src="./js/index.js"></script>
</body>
</html>
