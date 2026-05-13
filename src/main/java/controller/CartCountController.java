package controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import model.User;

/**
 * Servlet implementation class CartCountController
 */
@WebServlet("/cartCount")
public class CartCountController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.getWriter().write("0");
            return;
        }

        CartDAO dao = new CartDAO();
        int count = dao.getCartItemCount(user.getUserId());

        response.getWriter().write(String.valueOf(count));
    }
}