package web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import dao.UserDao;

@WebServlet("/UpdatePassword")
public class UpdatePassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            User user = (User) session.getAttribute("user");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");

            // Regular expression for password validation
            String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}$";

            // Validate current password
            if (user != null && user.getPassword().equals(currentPassword)) {
                
                // Check if the new password meets the criteria
                if (newPassword.equals(currentPassword)) {
                    session.setAttribute("passwordUpdated", "samePassword");
                } else if (!newPassword.matches(passwordRegex)) {
                    session.setAttribute("passwordUpdated", "invalidPassword");
                } else {
                    user.setPassword(newPassword); // Update password
                    boolean updated = UserDao.updateUser(user);
                    
                    if (updated) {
                        session.setAttribute("passwordUpdated", "true"); // Success
                    } else {
                        session.setAttribute("passwordUpdated", "false"); // Failure
                    }
                }
                response.sendRedirect("profile.jsp");
            } else {
                session.setAttribute("passwordUpdated", "false"); // Incorrect current password
                response.sendRedirect("home.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}