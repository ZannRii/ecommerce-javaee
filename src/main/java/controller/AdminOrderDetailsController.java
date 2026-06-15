package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDao;

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

		req.setAttribute("order", orderDao.getOrderById(orderId));

		req.setAttribute("items", orderDao.getOrderItems(orderId));

		req.getRequestDispatcher("/admin/order-details.jsp").forward(req, resp);
	}
}
