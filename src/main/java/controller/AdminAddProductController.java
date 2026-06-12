package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDao;
import dao.ProductDao;
import model.Category;
import model.Product;

/**
 * Servlet implementation class AdminAddProductController
 */
@WebServlet("/admin/add-product")
public class AdminAddProductController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ProductDao productDao = new ProductDao();
    private CategoryDao categoryDao = new CategoryDao();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Product p = new Product();
		p.setName(req.getParameter("name"));
		p.setPrice(Double.parseDouble(req.getParameter("price")));
		p.setStockQuantity(Integer.parseInt(req.getParameter("stock")));
		p.setDescription(req.getParameter("description"));
		p.setImageUrl(req.getParameter("imageUrl"));
		p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));

		productDao.insert(p);

		resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		List<Category> categories = categoryDao.getAllCategories();

		req.setAttribute("categories", categories);
		req.getRequestDispatcher("/admin/add-product.jsp").forward(req, resp);
	}
}
