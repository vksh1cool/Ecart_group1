package web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.ProductService;
import service.UserService;
import bean.Product;
import bean.User;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	
	
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	
//        response.getWriter().write("Login Servlet Logged");
    	
    	String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        UserService userService = new UserService();
        ProductService p = new ProductService();
        
        
        User user = userService.getUserByIdAndPassword(userId, password);
        ArrayList<Product> products = p.getAllProducts();
        
        HttpSession session = request.getSession();
        
        if(products != null) {        	
        session.setAttribute("products",products);
        }
        session.setAttribute("user", user);
        if (user != null) {
            // Successful login, redirect to home.jsp
        	request.setAttribute("user", user);
            request.setAttribute("userName", user.getCustomerName());
            request.setAttribute("email", user.getEmail());
            request.setAttribute("phone", user.getPhoneNumber());
//            session.setAttribute("user", user);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            // Authentication failed, send back to login page with error
            request.setAttribute("errorMessage", "Invalid User ID or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
