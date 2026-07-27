package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDao;

/**
 * Servlet implementation class UpdateOrderStatusController
 */
@WebServlet("/admin/update-order-status")
public class AdminUpdateOrderStatusController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OrderDao orderDao = new OrderDao();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		int orderId = Integer.parseInt(req.getParameter("orderId"));
		String status = req.getParameter("status");

		boolean updated = orderDao.updateOrderStatus(orderId, status);

		if (!updated) {
			String message = URLEncoder.encode(
					"Invalid status update. Allowed flow is PENDING to SHIPPED or CANCELLED, then SHIPPED to DELIVERED.",
					StandardCharsets.UTF_8.name());
			resp.sendRedirect(req.getContextPath() + "/admin/order-details?id=" + orderId + "&error=" + message);
			return;
		}

		String message = URLEncoder.encode("Order status updated successfully.", StandardCharsets.UTF_8.name());
		resp.sendRedirect(req.getContextPath() + "/admin/order-details?id=" + orderId + "&success=" + message);
	}
}
