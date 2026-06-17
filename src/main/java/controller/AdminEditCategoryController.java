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
 * Servlet implementation class AdminEditCategoryController
 */
@WebServlet("/admin/edit-category")
public class AdminEditCategoryController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CategoryDao categoryDao = new CategoryDao();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int id = Integer.parseInt(req.getParameter("id"));
        
		req.setAttribute("category", categoryDao.findById(id));

		req.getRequestDispatcher("/admin/edit-category.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		Category c = new Category();

		c.setCategoryId(Integer.parseInt(req.getParameter("id")));
		c.setName(req.getParameter("name"));
        c.setDescription(req.getParameter("description"));
		categoryDao.update(c);

		resp.sendRedirect(req.getContextPath() + "/admin/view-category");
	}
}
