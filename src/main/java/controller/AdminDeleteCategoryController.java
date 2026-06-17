package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDao;

/**
 * Servlet implementation class AdminDeleteCategoryController
 */
@WebServlet("/admin/delete-category")
public class AdminDeleteCategoryController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        categoryDao.delete(id);

        resp.sendRedirect(req.getContextPath() + "/admin/view-category");
    }
}
