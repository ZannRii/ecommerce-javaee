package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDao;

/**
 * Servlet implementation class AdminOrdersController
 */
@WebServlet("/admin/orders")
public class AdminOrdersController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private OrderDao orderDao = new OrderDao();

    protected void doGet(
        HttpServletRequest req,
        HttpServletResponse resp)
        throws ServletException, IOException {

        req.setAttribute(
            "orders",
            orderDao.getAllOrders()
        );

        req.getRequestDispatcher(
            "/admin/orders.jsp"
        ).forward(req, resp);
    }
}
