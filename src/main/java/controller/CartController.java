package controller;

import dao.CartDao;
import dao.CartItemDao;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
@WebServlet("/cart")
public class CartController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private CartDao cartDao = new CartDao();
    private CartItemDao cartItemDao = new CartItemDao();

    // VIEW CART
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int cartId = cartDao.getCartIdByUser(user.getUserId());

        req.setAttribute("items", cartItemDao.getCartItems(cartId));
        req.setAttribute("total", cartItemDao.getTotal(cartId));

        req.getRequestDispatcher("cart/cartDetails.jsp").forward(req, resp);
    }

    // ADD / REMOVE / UPDATE
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        int cartId = cartDao.getCartIdByUser(user.getUserId());

        if (cartId == -1) {
            cartId = cartDao.createCart(user.getUserId());
        }

        String action = req.getParameter("action");

        if ("add".equals(action)) {

            cartItemDao.addOrUpdate(
                cartId,
                Integer.parseInt(req.getParameter("productId")),
                Integer.parseInt(req.getParameter("quantity"))
            );

        } else if ("remove".equals(action)) {

            cartItemDao.remove(
                cartId,
                Integer.parseInt(req.getParameter("productId"))
            );

        } else if ("update".equals(action)) {

            cartItemDao.updateQty(
                cartId,
                Integer.parseInt(req.getParameter("productId")),
                Integer.parseInt(req.getParameter("quantity"))
            );
        }

        resp.sendRedirect("home");
    }
}