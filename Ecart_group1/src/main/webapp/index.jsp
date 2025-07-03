<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register user</title>
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
    <h2>Register</h2>
    <form action="UserServlet" method="post">
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
            <div class="login">
                <span style="color:rgb(255, 191, 96)">Already Registered?</span>
                <a href="login.jsp">Login</a>
            </div>
            <div class="row" style="justify-content: space-between;">
                <button class="btn" type="submit" style="margin-right:3px">Register</button>
                <button class="btn" type="reset">Reset</button>
            </div>
        </div>
    </form>
</div>

    </div>
</body>
<script src="js/script.js"></script>
</html>