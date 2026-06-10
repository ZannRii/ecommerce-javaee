package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.OrderDao;
import model.OrderItemDetail;
import model.User;

/**
 * Servlet implementation class OrderViewController
 */
@WebServlet("/my-orders")
public class OrderViewController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDao orderDAO = new OrderDao();
       
    public OrderViewController() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
       
        User user = (User) request.getSession().getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<OrderItemDetail> detailedOrders = orderDAO.getFullOrderHistory(user.getUserId());
            
            request.setAttribute("detailedOrders", detailedOrders);
                   
            request.getRequestDispatcher("order/my-orders.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // Handle failure gracefully by routing to a generic error tracking block
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch your orders.");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
