package web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Product;
import service.ProductService;

/**
 * Servlet implementation class UpdateProduct
 */
@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProduct() {
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
		// TODO Auto-generated method stub
		Product product = new Product();
		ProductService  productService=new ProductService();
        product.setProductId(Integer.parseInt(request.getParameter("productId"))); // Generates a 3-digit random number
        product.setProductName(request.getParameter("productName"));
        product.setProductPrice(Float.parseFloat(request.getParameter("productPrice")));
        product.setProductCategory(request.getParameter("productCategory"));
        product.setProductDescription(request.getParameter("productDescription"));
        
        boolean isUpdated= productService.updateProduct(product);
        
        if(isUpdated) {
			response.sendRedirect("view_all_products.jsp");
		}
		else {
			response.getWriter().println("Product updation Failed");
		}
	}

}
