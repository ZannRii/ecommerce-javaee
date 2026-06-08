package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDao;
import dao.CartItemDao;
import dao.ProductDao;
import model.CartItem;
import model.Product;
import model.User;

/**
 * Servlet Filter implementation class CheckoutController
 */
@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductDao productDao = new ProductDao();
	private CartDao cartDao = new CartDao();
	private CartItemDao cartItemDao = new CartItemDao();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String type = request.getParameter("type");
		User user = (User) request.getSession().getAttribute("user");

		if (user == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int cartCount = 0;
		if (user != null) {

			CartDao cartDao = new CartDao();
			CartItemDao cartItemDao = new CartItemDao();

			int cartId = cartDao.getCartIdByUser(user.getUserId());

			if (cartId != -1) {
				cartCount = cartItemDao.getTotalQty(cartId);
			}
		}
		request.setAttribute("cartCount", cartCount);

		if ("buyNow".equals(type)) {

			int productId = Integer.parseInt(request.getParameter("productId"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			Product product = productDao.findById(productId);

			double total = product.getPrice() * quantity;

			request.setAttribute("type", "buyNow");
			request.setAttribute("product", product);
			request.setAttribute("quantity", quantity);
			request.setAttribute("total", total);

		} else {

			int cartId = cartDao.getCartIdByUser(user.getUserId());

			List<CartItem> cartItems = cartItemDao.getCartItems(cartId);

			double total = cartItemDao.getTotal(cartId);

			request.setAttribute("type", "cart");
			request.setAttribute("cartItems", cartItems);
			request.setAttribute("total", total);
		}
		request.getRequestDispatcher("checkout/checkout.jsp").forward(request, response);
	}
}
