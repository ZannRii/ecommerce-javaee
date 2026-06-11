package controller;

import dao.CartDao;
import dao.CartItemDao;
import dao.ProductDao;
import model.Product;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/cart")
public class CartController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CartDao cartDao = new CartDao();
	private CartItemDao cartItemDao = new CartItemDao();
	private ProductDao productDao = new ProductDao();

	// VIEW CART
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User user = (User) req.getSession().getAttribute("user");
		if (user == null) {
			resp.sendRedirect("login.jsp");
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
		req.setAttribute("cartCount", cartCount);
		int cartId = cartDao.getCartIdByUser(user.getUserId());
		Product product = productDao.findById(user.getUserId());

		req.setAttribute("product", product);
		req.setAttribute("items", cartItemDao.getCartItems(cartId));
		req.setAttribute("total", cartItemDao.getTotal(cartId));

		req.getRequestDispatcher("cart/cartDetails.jsp").forward(req, resp);
	}

	// ADD / REMOVE / UPDATE
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User user = (User) req.getSession().getAttribute("user");

		if (user == null) {
			resp.sendRedirect("login.jsp");
			return;
		}
		int cartId = cartDao.getCartIdByUser(user.getUserId());

		if (cartId == -1) {
			cartId = cartDao.createCart(user.getUserId());
		}

		String action = req.getParameter("action");

		if ("add".equals(action)) {

			int productId = Integer.parseInt(req.getParameter("productId"));

			int qty = Integer.parseInt(req.getParameter("quantity"));

			Product product = productDao.findById(productId);

			if (product.getStockQuantity() >= qty) {

				productDao.updateStock(productId, product.getStockQuantity() - qty);

				cartItemDao.addOrUpdate(cartId, productId, qty);
			}

		} else if ("remove".equals(action)) {

			int productId = Integer.parseInt(req.getParameter("productId"));

			int qty = cartItemDao.getQuantity(cartId, productId);

			Product product = productDao.findById(productId);

			productDao.updateStock(productId, product.getStockQuantity() + qty);

			cartItemDao.remove(cartId, productId);

		} else if ("update".equals(action)) {

			int productId = Integer.parseInt(req.getParameter("productId"));

			int newQty = Integer.parseInt(req.getParameter("quantity"));

			int oldQty = cartItemDao.getQuantity(cartId, productId);

			int diff = newQty - oldQty;

			Product product = productDao.findById(productId);

			if (diff > 0) {

				productDao.updateStock(productId, product.getStockQuantity() - diff);

			} else if (diff < 0) {

				productDao.updateStock(productId, product.getStockQuantity() + Math.abs(diff));
			}

			cartItemDao.updateQty(cartId, productId, newQty);
		}

		resp.sendRedirect("home");
	}
}