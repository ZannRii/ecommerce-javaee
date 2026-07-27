package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDao;
import dao.CartItemDao;
import model.User;

/**
 * Servlet implementation class ProfileController
 */
@WebServlet("/profile")
public class ProfileController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CartDao cartDao = new CartDao();
	private CartItemDao cartItemDao = new CartItemDao();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = (User) request.getSession().getAttribute("user");

		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		request.setAttribute("user", user);
		request.setAttribute("cartCount", getCartCount(user.getUserId()));

		request.getRequestDispatcher("user/profile.jsp").forward(request, response);
	}

	private int getCartCount(int userId) {
		int cartId = cartDao.getCartIdByUser(userId);
		return cartId == -1 ? 0 : cartItemDao.getTotalQty(cartId);
	}
}
