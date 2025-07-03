<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="css/index.css">
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
        <h2>Login</h2>
        <div class="form2">
            <form action="LoginServlet" method="post">
                <div class="row">
                    <input type="text" name="userId" placeholder="User ID" required>
                </div>
                <div class="row">
                    <input type="password" name="password" class="password" placeholder="Password" required>
                </div>

                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                    <p style="color:red;"><%= errorMessage %></p>
                <% 
                    } 
                %>

                <div class="login">
                  <span style="color:rgb(255, 191, 96)">New User?</span><a href="index.jsp"> Register</a>
                </div>
                <button class="btn" type="submit">Login</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
