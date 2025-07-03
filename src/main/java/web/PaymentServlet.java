//package service;
package web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String paymentMode = request.getParameter("payment-mode");
        String cardNumber = request.getParameter("card-number");
        String cardHolder = request.getParameter("cardholder-name");
        String expiryDate = request.getParameter("expiry-date");
        String cvv = request.getParameter("cvv");
        String upiId = request.getParameter("upi-id");
        String product = "Laptop";

        HttpSession session = request.getSession();

        // Server-side validation
        if ("credit-card".equals(paymentMode)) {
            // Validate card number (should be 16 digits)
            if (cardNumber == null || cardNumber.length() != 16 || !isNumeric(cardNumber)) {
                session.setAttribute("errorMessage", "Invalid card number. It must be 16 digits.");
                response.sendRedirect("payment.jsp");
                return;
            }

            // Validate cardholder name (must be at least 10 characters and alphabetic)
            if (cardHolder == null || cardHolder.length() < 10 || containsNumeric(cardHolder)) {
                session.setAttribute("errorMessage", "Card holder name must be alphabetic and at least 10 characters long.");
                response.sendRedirect("payment.jsp");
                return;
            }

            // Validate expiry date (must be in MM/YY format and not in the past)
            if (!isValidExpiryDate(expiryDate)) {
                session.setAttribute("errorMessage", "Invalid expiry date. Please enter a valid MM/YY format and make sure it's not expired.");
                response.sendRedirect("payment.jsp");
                return;
            }

            // Validate CVV (should be 3 digits)
            if (cvv == null || cvv.length() != 3 || !isNumeric(cvv)) {
                session.setAttribute("errorMessage", "Invalid CVV. It must be 3 digits.");
                response.sendRedirect("payment.jsp");
                return;
            }

            // Process credit card payment and store details in session
            session.setAttribute("orderId", "ORD" + (int)(Math.random() * 1000000)); // Random order ID for demo
            session.setAttribute("cardHolder", cardHolder);
            session.setAttribute("expiryDate", expiryDate);
            session.setAttribute("paymentMethod", "Credit Card");
            
        } else if ("upi".equals(paymentMode)) {
            // Validate UPI ID (for demo, just check it's not empty)
            if (upiId == null || upiId.isEmpty()) {
                session.setAttribute("errorMessage", "Invalid UPI ID. Please provide a valid UPI ID.");
                response.sendRedirect("payment.jsp");
                return;
            }

            // Process UPI payment and store details in session
            session.setAttribute("orderId", "ORD" + (int)(Math.random() * 1000000)); // Random order ID for demo
            session.setAttribute("upiId", upiId);
            session.setAttribute("paymentMethod", "UPI");
        }

        // Redirect to invoice.jsp if validation passes
        RequestDispatcher rd = request.getRequestDispatcher("invoice.jsp");
        rd.forward(request, response);
//        response.sendRedirect("invoice.jsp");
    }

    // Helper method to check if a string contains only numeric characters
    private boolean isNumeric(String str) {
        try {
            Long.parseLong(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // Helper method to check if a string contains any numeric characters (for cardholder name validation)
    private boolean containsNumeric(String str) {
        for (char c : str.toCharArray()) {
            if (Character.isDigit(c)) {
                return true;
            }
        }
        return false;
    }

    // Helper method to validate the expiry date
    private boolean isValidExpiryDate(String expiryDate) {
        if (expiryDate == null || !expiryDate.contains("/")) {
            return false;
        }

        String[] parts = expiryDate.split("/");
        if (parts.length != 2) {
            return false;
        }

        try {
            int month = Integer.parseInt(parts[0]);
            int year = Integer.parseInt(parts[1]);

            if (month < 1 || month > 12) {
                return false;
            }

            // Get the current year and month
            int currentYear = java.time.Year.now().getValue() % 100; // Get last two digits of the year
            int currentMonth = java.time.LocalDate.now().getMonthValue();

            // Check if the year is in the future or the current year with a valid month
            if (year < currentYear || (year == currentYear && month < currentMonth)) {
                return false;
            }

            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
