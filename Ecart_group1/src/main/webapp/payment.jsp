<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="bean.User" %>
<%@ page import="bean.Product" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./css/payment.css">
<link rel="stylesheet" type="text/css" href="./css/homepage.css">
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
            	<% if(name != null){ %>
                <li><a href="home.jsp">Home</a></li>
            	<% if(name.getRole().equals("0")) {%>
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
     <!-- Payment Form -->
     <div class="payment-container" >
        <form id="payment-form" method="post" action="PaymentServlet" style="widht:50vw;">
            <h2>Payment</h2>
            
            <!-- Payment Options -->
            <label for="payment-mode">Select Mode:</label>
            <select id="payment-mode">
                <option value="credit-card">Credit Card</option>
                <option value="upi">UPI</option>
            </select>

            <!-- UPI Field (Hidden by default) -->
            <div id="upi-section" class="hidden">
                <label for="upi-id">Enter UPI ID:</label>
                <input type="text" id="upi-id" name="upi-id">
            </div>

            <!-- Credit Card Fields -->
            <div id="credit-card-section">
                <label for="card-number">Card Number:</label>
                <input type="text" id="card-number" minlength="16" maxlength="16" required>
                
                <label for="cardholder-name">Card Holder Name:</label>
                <input type="text" id="cardholder-name" minlength="10" required>
                
                <label for="expiry-date">Expiry Date (MM/YY):</label>
                <input type="text" id="expiry-date" placeholder="MM/YY" required>
                
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" minlength="3" maxlength="3" required>
            </div>

            <!-- Make Payment Button -->
            <button type="button" id="make-payment">Make Payment</button>

        </form>
    </div>
<%@ include file="Footer.jsp" %>
    
    <script src="./js/index.js"></script>
<script>

document.getElementById('make-payment').addEventListener('click', function() {
    const cardNumber = document.getElementById('card-number').value;
    const cardHolder = document.getElementById('cardholder-name').value;
    const expiryDate = document.getElementById('expiry-date').value;
    const cvv = document.getElementById('cvv').value;

    // Validate the card number (must be exactly 16 digits and numeric)
    if (cardNumber.length !== 16 || isNaN(cardNumber)) {
        alert('Please enter a valid 16-digit card number.');
        return;
    }

    // Validate the cardholder name (must be at least 10 characters long and alphabetic)
    if (cardHolder.length < 10 || /\d/.test(cardHolder)) {
        alert('Card holder name must be alphabetic and at least 10 characters long.');
        return;
    }

    // Validate expiry date (must be in MM/YY format)
    const expiryParts = expiryDate.split('/');
    if (expiryParts.length !== 2) {
        alert('Please enter a valid expiry date in MM/YY format.');
        return;
    }
    
    const month = parseInt(expiryParts[0], 10);
    const year = parseInt(expiryParts[1], 10);

    const currentYear = new Date().getFullYear() % 100; // Get last 2 digits of the current year
    const currentMonth = new Date().getMonth() + 1; // Get current month (0-based index, so +1)

    if (isNaN(month) || isNaN(year) || month < 1 || month > 12 || (year < currentYear) || (year === currentYear && month < currentMonth)) {
        alert('Please enter a valid expiry date in MM/YY format, and it should not be in the past.');
        return;
    }

    // Validate the CVV (must be exactly 3 digits and numeric)
    if (cvv.length !== 3 || isNaN(cvv)) {
        alert('Please enter a valid 3-digit CVV.');
        return;
    }

    // Generate the unique order ID
    let orderId = 'ORD' + Math.floor(Math.random() * 1000000);

    // Save the details in localStorage (optional)
    localStorage.setItem('orderId', orderId);
    localStorage.setItem('cardHolder', cardHolder);
    localStorage.setItem('expiryDate', expiryDate);
    localStorage.setItem('paymentMethod', 'Credit Card');  // Assuming credit card for this example

    // Redirect to the invoice page
    window.location.href = 'invoice.jsp';
});

</script>
   
</body>
</html>



