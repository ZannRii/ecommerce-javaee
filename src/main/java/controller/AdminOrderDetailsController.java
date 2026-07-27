package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDao;
import model.Order;

/**
 * Servlet implementation class AdminOrderDetailsController
 */
@WebServlet("/admin/order-details")
public class AdminOrderDetailsController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OrderDao orderDao = new OrderDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int orderId = Integer.parseInt(req.getParameter("id"));

		Order order = orderDao.getOrderById(orderId);

		req.setAttribute("order", order);

		req.setAttribute("items", orderDao.getOrderItems(orderId));
		req.setAttribute("allowedStatuses", getAllowedStatuses(order == null ? null : order.getStatus()));
		req.setAttribute("error", req.getParameter("error"));
		req.setAttribute("success", req.getParameter("success"));

		req.getRequestDispatcher("/admin/order-details.jsp").forward(req, resp);
	}

	private List<String> getAllowedStatuses(String status) {
		if ("PENDING".equals(status)) {
			return Arrays.asList("SHIPPED", "CANCELLED");
		}
		if ("SHIPPED".equals(status)) {
			return Arrays.asList("DELIVERED");
		}
		return Collections.emptyList();
	}
}
