package controller;

import dao.CartDao;
import dao.CartItemDao;
import dao.ProductDao;
import model.Product;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // --------------------
        // PRODUCTS
        // --------------------
        List<Product> products = productDao.getAllProducts();
        req.setAttribute("products", products);

        // --------------------
        // CART COUNT
        // --------------------
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

        req.setAttribute("cartCount", cartCount);

        // --------------------
        // FORWARD
        // --------------------
        req.getRequestDispatcher("user/home.jsp").forward(req, resp);
    }
}