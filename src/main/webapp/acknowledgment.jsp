<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Acknowledgment</title>
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
        <h2>Registration Successful!</h2>
        <p>User ID: <strong><%= request.getAttribute("userId") %></strong></p>
        <p>Username: <strong><%= request.getAttribute("customerName") %></strong></p>
        
        <div class="login">
            <button class="btn" onclick="window.location.href='login.jsp'">Proceed to Login</button>
        </div>
    </div>
</div>
</body>
</html>
