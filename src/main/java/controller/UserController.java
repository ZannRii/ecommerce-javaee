package controller;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

import dao.UserDAO;
import model.User;
import util.DBConnection;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/user")
public class UserController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (action) {

            case "register":
                register(request, response);
                break;

            case "login":
                login(request, response);
                break;

            default:
                response.sendRedirect("login.jsp");
                break;
        }
    }

    //  REGISTER 
    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        //  basic validation
        if (name == null || email == null || password == null || phone == null ||
            name.isEmpty() || email.isEmpty() || password.isEmpty() || phone.isEmpty()) {

            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // check duplicate email
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // create user
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        user.setPassword(hashedPassword);
        user.setPhone(phone);

        boolean success = userDAO.register(user);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Registration failed!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // LOGIN
    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
            email.isEmpty() || password.isEmpty()) {

            request.setAttribute("error", "Email and Password required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.login(email, password);

        if (user != null) {

            // create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // role-based redirect
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                response.sendRedirect("home");
            }

        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}