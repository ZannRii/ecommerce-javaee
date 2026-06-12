package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDao;
import dao.ProductDao;
import dao.UserDAO;

/**
 * Servlet implementation class AdminDashboardController
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductDao productDao = new ProductDao();
	private UserDAO userDao = new UserDAO();
	private OrderDao orderDao = new OrderDao();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setAttribute("totalProducts", productDao.countProducts());

		req.setAttribute("totalUsers", userDao.countUsers());

		req.setAttribute("totalOrders", orderDao.countOrders());

		// req.setAttribute("totalRevenue",
		// orderDao.getTotalRevenue());

		req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
	}
}