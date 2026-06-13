package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDao;

/**
 * Servlet implementation class DeleteProductController
 */
@WebServlet("/admin/delete-product")
public class DeleteProductController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int productId = Integer.parseInt(req.getParameter("id"));

        productDao.delete(productId);

        resp.sendRedirect(req.getContextPath() + "/admin/view-product");
    }
}
