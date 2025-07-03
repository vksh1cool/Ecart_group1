package web;

import bean.Cart;
import bean.Product;
import bean.User;
import service.CartService;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	CartService crt = new CartService();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        
        
        User user = (User) session.getAttribute("user");
        
        crt.addProductToCart(user.getUserId(), productId);
        
        ArrayList<Integer> ids = crt.getAllProducts(user.getUserId());
        
        ArrayList<Product> products = new ArrayList<>();
        
        for(int i = 0; i < ids.size();i++) {
        	System.out.println(ids.get(i));
        	Product obj = getProductById(ids.get(i));
        	products.add(obj);
        }
        
        
        // Retrieve product from database based on productId
        // Assuming you have a method getProductById() to fetch product
        Product product = getProductById(productId);
        if(products != null) {
        	session.setAttribute("items", products);
        }
        cart.addProduct(product);
    }

    private Product getProductById(int productId) {
        // Fetch product from database using the productId
        // Placeholder implementation
    	ProductService obj = new ProductService();
    	ArrayList<Product> arr = obj.getAllProducts();
    	
    	for(int i = 0; i < arr.size();i++) {
    		if(arr.get(i).getProductId() == productId) {
    			return arr.get(i);
    		}
    	}
    	
        return null;
    }
}