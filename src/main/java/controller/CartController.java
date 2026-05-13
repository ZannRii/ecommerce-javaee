package controller;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import model.User;

/**
 * Servlet Filter implementation class CartController
 */
@WebServlet("/cart")
public class CartController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.setStatus(401);
            return;
        }

        CartDAO dao = new CartDAO();
        dao.addToCart(user.getUserId(), productId, quantity);

        response.getWriter().write("SUCCESS");
    }
}
