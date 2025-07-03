package web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Product;
import service.ProductService;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Product product = new Product();
		ProductService  productService=new ProductService();
        product.setProductId(generateUserId()); // Generates a 3-digit random number
        product.setProductName(request.getParameter("productName"));
        product.setProductPrice(Float.parseFloat(request.getParameter("productPrice")));
        product.setProductCategory(request.getParameter("productCategory"));
        product.setProductDescription(request.getParameter("productDescription"));
        
        boolean b= productService.addProduct(product);
        ProductService p = new ProductService();
        ArrayList<Product> products = p.getAllProducts();
        
        HttpSession session = request.getSession();
        
        if(products != null) {        	
        session.setAttribute("products",products);
        }
        if(b) {
        	System.out.println("Done");
        	response.getWriter().write("Ho gaya");
        }
        request.setAttribute("product", product);
        request.getRequestDispatcher("view_all_products.jsp").forward(request, response);
	}
	
	private int generateUserId() {
        Random random = new Random();
        int randomNumber = random.nextInt(90000) + 10000;
        return  randomNumber;
    }
}
