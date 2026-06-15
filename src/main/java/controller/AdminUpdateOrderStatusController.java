package controller;

import java.io.IOException;
import javax.servlet.ServletException;
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

		orderDao.updateOrderStatus(orderId, status);

		resp.sendRedirect(req.getContextPath() + "/admin/order-details?id=" + orderId);
	}
}