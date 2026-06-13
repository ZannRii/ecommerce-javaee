package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDao;
import dao.ProductDao;
import model.Product;

/**
 * Servlet implementation class AdminEditProductController
 */
@WebServlet("/admin/edit-product")
public class AdminEditProductController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductDao productDao = new ProductDao();
	private CategoryDao categoryDao = new CategoryDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int productId = Integer.parseInt(req.getParameter("id"));

		Product product = productDao.findById(productId);

		req.setAttribute("product", product);
		req.setAttribute("categories", categoryDao.getAllCategories());

		req.getRequestDispatcher("/admin/edit-product.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Product p = new Product();

		p.setProductId(Integer.parseInt(req.getParameter("productId")));

		p.setName(req.getParameter("name"));
		p.setPrice(Double.parseDouble(req.getParameter("price")));

		p.setStockQuantity(Integer.parseInt(req.getParameter("stock")));

		p.setDescription(req.getParameter("description"));

		p.setImageUrl(req.getParameter("imageUrl"));

		p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));

		productDao.update(p);

		resp.sendRedirect(req.getContextPath() + "/admin/view-product");
	}
}
