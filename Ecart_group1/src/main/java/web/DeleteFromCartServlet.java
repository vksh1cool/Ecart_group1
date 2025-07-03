package web;

import bean.Cart;
import bean.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/DeleteFromCartServlet")
public class DeleteFromCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            ArrayList<Product> products = cart.getProducts();

            // Remove the product with the specified ID from the cart
            products.removeIf(product -> product.getProductId() == productId);

            // Update the cart in the session
            cart = new Cart();
            cart.getProducts().addAll(products);
            session.setAttribute("cart", cart);
        }

        // Send response back to indicate successful removal
        response.getWriter().write("Product removed successfully");
    }
}
