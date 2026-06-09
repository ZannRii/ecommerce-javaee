package controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CartDao;
import dao.CartItemDao;
import dao.OrderDao;
import dao.ProductDao;
import model.CartItem;
import model.Product;
import model.User;

@WebServlet("/place-order")
public class OrderController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OrderDao orderDao = new OrderDao();
	private ProductDao productDao = new ProductDao();
	private CartDao cartDao = new CartDao();
	private CartItemDao cartItemDao = new CartItemDao();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = (User) request.getSession().getAttribute("user");

		String type = request.getParameter("type");
		String address = request.getParameter("address");

		if ("buyNow".equals(type)) {

			int productId = Integer.parseInt(request.getParameter("productId"));

			int quantity = Integer.parseInt(request.getParameter("quantity"));

			Product product = productDao.findById(productId);

			double total = product.getPrice() * quantity;

			int orderId = orderDao.createOrder(user.getUserId(), total);

			orderDao.addOrderItem(orderId, productId, quantity, product.getPrice());

		} else {

			int cartId = cartDao.getCartIdByUser(user.getUserId());

			List<CartItem> items = cartItemDao.getCartItems(cartId);

			double total = cartItemDao.getTotal(cartId);

			int orderId = orderDao.createOrder(user.getUserId(), total);

			for (CartItem item : items) {

				orderDao.addOrderItem(orderId, item.getProduct().getProductId(), item.getQuantity(),
						item.getProduct().getPrice());
			}

			// Clear cart after successful order
			cartItemDao.clearCart(cartId);

			// Reset cart count in session
			request.getSession().setAttribute("cartCount", 0);
		}

		request.getRequestDispatcher("order/order-success.jsp").forward(request, response);
	}
}