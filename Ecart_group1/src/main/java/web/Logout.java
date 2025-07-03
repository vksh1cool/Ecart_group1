package web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the current session, if it exists
        HttpSession session = request.getSession(false); // Use false to avoid creating a new session if none exists

        if (session != null) {
            // Invalidate the session to log the user out
            session.invalidate();
        }

        // Redirect to login or home page after logout
        response.sendRedirect("login.jsp");
    }
}
