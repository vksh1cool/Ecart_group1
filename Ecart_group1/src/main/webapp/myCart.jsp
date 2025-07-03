<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="bean.User" %>
<%@ page import="java.util.*" %>
<%@ page import="bean.Cart" %>
<%@ page import="bean.Product" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>My Cart</title>
    <link rel="stylesheet" href="./css/homepage.css">
    <style>
        .cart-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            max-width: 600px;
            height: 60vh;
            margin: 3em auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .cart-container h1 {
            color: #333;
            text-align: center;
        }
        .cart-container ul {
            list-style-type: none;
            padding: 0;
        }
        .cart-container ul li {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .cart-container .empty-cart {
            text-align: center;
            color: #666;
            margin-top: 20px;
        }
        .cart-container .continue-shopping {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: rgb(231, 155, 41);
            font-weight: bold;
        }
        .cart-container .continue-shopping:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <% User user = (User) session.getAttribute("user"); %>
    <%@ include file="Header.jsp" %>
    
    <nav>
        <div class="container" style="flex-direction:row-reverse;">
            <div class="welcome">
                <% if (user != null) { %>
                    <h3>Welcome, <%= user.getCustomerName() %></h3>
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
                    <button class="btn"><a href="login.jsp" style="text-decoration:none;color:black;">Login</a></button>
                <% } %>
            </div>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <% if (user != null) { if (user.getRole().equals("0")) { %>
                    <li><a href="myCart.jsp">My Cart</a></li>
                    <li><a href="myOrders.jsp">My Orders</a></li>
                <% } else { %>
                    <li><a href="addProduct.jsp">Add Products</a></li>
                    <li><a href="ProductServlet">View all Products</a></li>
                    <li><a href="ViewCustomersServlet">View all Customers</a></li>
                    <li><a href="viewAllOrders.jsp">View all Orders</a></li>
                    <li><a href="AddAdmin.jsp">Add New Admin</a></li>
                <% }} %>
            </ul>
        </div>
    </nav>

    <div class="cart-container">
        <h1>My Cart</h1>
        <% 
            Cart cart = (Cart) session.getAttribute("cart");
            ArrayList<Product> products = new ArrayList<>();
            if (cart != null) {
                products = cart.getProducts();
            }

            // Create a map to count the occurrences of each product
            Map<Integer, Integer> productCountMap = new HashMap<>(); // Key: Product ID, Value: Count
            float totalSum = 0;

            // Count products and calculate total price
            for (Product product : products) {
                int productId = product.getProductId();
                productCountMap.put(productId, productCountMap.getOrDefault(productId, 0) + 1);
                totalSum += product.getProductPrice();
            }
        %>
        
        <% if (cart != null && !products.isEmpty()) { %>
            <ul id="cart-items">
                <% 
                    for (Product product : products) {
                        int productId = product.getProductId();
                        int count = productCountMap.get(productId);
                        String productName = product.getProductName();
                        float productPrice = product.getProductPrice();
                        float totalPriceForItem = productPrice * count;
                        // Ensure we only show each product once
                        if (count > 0) {
                %>
                    <li>
                        <%= productName %> - Rs.<%= productPrice %> x <%= count %> 
                        <strong>Total: Rs.<%= totalPriceForItem %></strong>
                        <button onclick="deleteFromCart(<%= productId %>)" class="btn" style="width:10vw;height:5vh;color:white;text-align:center;background-color:red">Remove</button>
                    </li>
                <% 
                        // Set count to 0 to avoid duplication
                        productCountMap.put(productId, 0);
                        } 
                    } 
                %>
            </ul>
            <h3 style="text-align:center;margin-top:1em;">Total Price: Rs.<%= totalSum %></h3>
            <a class="btn" style="text-decoration:none;width:10vw;height:5vh;color:black;text-align:center;margin-top:1em;" href="payment.jsp">Checkout</a>
        <% } else { %>
            <p class="empty-cart">Your cart is empty.</p>
        <% } %>

        <a href="home.jsp" class="continue-shopping">Continue Shopping</a>
    </div>
    
    <%@ include file="Footer.jsp" %>
    
    <script src="./js/index.js"></script>
    <script>
    function deleteFromCart(productId) {
        if (confirm("Are you sure you want to remove this product from your cart?")) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "DeleteFromCartServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    alert("Product removed from cart");
                    location.reload(); // Reload page to reflect updated cart
                }
            };
            xhr.send("productId=" + productId);
        }
    }
    </script>
</body>
</html>
