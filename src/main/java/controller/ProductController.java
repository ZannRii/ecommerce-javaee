package controller;

import dao.CartDao;
import dao.CartItemDao;
import dao.CategoryDao;
import dao.ProductDao;
import model.Product;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/home")
public class ProductController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ProductDao productDao = new ProductDao();
	CategoryDao categoryDao = new CategoryDao();
	List<Product> products = new ArrayList<Product>();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String keyword = req.getParameter("keyword");
		String categoryId = req.getParameter("categoryId");

		if (keyword != null && !keyword.trim().isEmpty()) {

			products = productDao.searchProducts(keyword.trim());

		} else if (categoryId != null && !categoryId.trim().isEmpty()) {

			products = productDao.getProductsByCategory(Integer.parseInt(categoryId));

		} else {

			products = productDao.getAllProducts();
		}
		// cart count
		int cartCount = 0;
		User user = (User) req.getSession().getAttribute("user");

		if (user != null) {

			CartDao cartDao = new CartDao();
			CartItemDao cartItemDao = new CartItemDao();

			int cartId = cartDao.getCartIdByUser(user.getUserId());

			if (cartId != -1) {
				cartCount = cartItemDao.getTotalQty(cartId);
			}
		}

		req.setAttribute("products", products);
		req.setAttribute("categories", categoryDao.getAllCategories());
		req.setAttribute("cartCount", cartCount);
		req.setAttribute("keyword", keyword);

		req.getRequestDispatcher("user/home.jsp").forward(req, resp);
	}
}
