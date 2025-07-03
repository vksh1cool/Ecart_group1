package web;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import service.UserService;

@WebServlet("/AddAdmin")
public class AddAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddAdmin() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = generateUserId();
        String customerName = request.getParameter("customerName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("countryCode") + "-" + request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String role = "1";

        UserService service = new UserService();
        User existingUser = service.getUserByEmailOrPhone(email, phoneNumber);

        if (existingUser != null) {
            request.setAttribute("customerName", existingUser.getCustomerName());
            request.setAttribute("email", existingUser.getEmail());
            request.setAttribute("phoneNumber", existingUser.getPhoneNumber());
            request.getRequestDispatcher("existingUser.jsp").forward(request, response);
        } else {
            User user = new User(userId, customerName, email, phoneNumber, address, password, role);
            boolean isRegistered = service.registerUser(user);
            
            if (isRegistered) {
                // Pass user details for acknowledgment page
                request.setAttribute("userId", userId);
                request.setAttribute("customerName", customerName);
                
                // Redirect to acknowledgment page
                request.getRequestDispatcher("acknowledgment.jsp").forward(request, response);
            } else {
                response.getWriter().write("User registration failed");
            }
        }
    }

    private String generateUserId() {
        Random random = new Random();
        int randomNumber = random.nextInt(90000) + 10000;
        return "UID-" + randomNumber;
    }
}
