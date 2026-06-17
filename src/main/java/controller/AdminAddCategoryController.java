package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDao;
import model.Category;

/**
 * Servlet implementation class AdminAddCategoryController
 */
@WebServlet("/admin/add-category")
public class AdminAddCategoryController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private CategoryDao categoryDao = new CategoryDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.getRequestDispatcher("/admin/add-category.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Category category = new Category();

		category.setName(req.getParameter("name"));
		category.setDescription(req.getParameter("description"));

		categoryDao.insert(category);

		resp.sendRedirect(req.getContextPath() + "/admin/view-category");
	}
}
