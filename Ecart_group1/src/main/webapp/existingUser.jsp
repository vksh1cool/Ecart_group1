<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Already Exists</title>
<link rel="stylesheet" type="text/css" href="css/index.css">

<style>
.form{
color:black;
}
</style>
</head>
<body>
<nav>
    <div class="container">
        <img src="shop.png" alt="">
        <h1>E Cart</h1>
    </div>
</nav>
<div class="body">
    <div class="form">
        <h2>User Already Exists</h2>
        <p>Username: <strong><%= request.getAttribute("customerName") %></strong></p>
        <p>Email: <strong><%= request.getAttribute("email") %></strong></p>
        <p>Phone Number: <strong><%= request.getAttribute("phoneNumber") %></strong></p>
        <div class="login">
            <span style="color:rgb(255, 191, 96)">Want to log in instead?</span>
            <a href="login.jsp">Login</a>
        </div>
    </div>
</div>
</body>
</html>
