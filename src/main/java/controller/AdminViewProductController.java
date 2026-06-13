package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDao;
import model.Product;

/**
 * Servlet implementation class AdminViewProductController
 */
@WebServlet("/admin/view-product")
public class AdminViewProductController extends HttpServlet { 	
	 private static final long serialVersionUID = 1L;

	    private ProductDao productDao = new ProductDao();

	    @Override
	    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	            throws ServletException, IOException {

	        List<Product> products = productDao.findAll();

	        req.setAttribute("products", products);

	        req.getRequestDispatcher("/admin/product-list.jsp")
	           .forward(req, resp);
	    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
