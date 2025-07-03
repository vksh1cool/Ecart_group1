package web;
import bean.Product;
import service.ProductService;


import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductService productService; // Declare the instance variable

    public ProductServlet() {
        super();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all products and set them as a request attribute
        List<Product> productList = null;
        
        ProductService productService = new ProductService();
        
        String action = request.getParameter("action");

            	try {
        			productList = productService.getAllProducts();
        		} catch (Exception e) {
        			// TODO Auto-generated catch block
        			e.printStackTrace();
        		}
                request.setAttribute("productList", productList);
                
                // Forward to the JSP page to display the products
                request.getRequestDispatcher("view_all_products.jsp").forward(request, response);
        
		
    }

    
}
