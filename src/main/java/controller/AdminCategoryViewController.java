package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDao;

/**
 * Servlet implementation class AdminCategoryViewController
 */
@WebServlet("/admin/view-category")
public class AdminCategoryViewController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute(
            "categories",
            categoryDao.getAllCategories()
        );

        req.getRequestDispatcher(
            "/admin/category-list.jsp"
        ).forward(req, resp);
    }
}