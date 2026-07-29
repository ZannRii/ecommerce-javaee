package service;

import dao.OrderDao;
import model.Order;

public class OrderTrackingService {

	private OrderDao orderDAO;

	public OrderTrackingService() {

		orderDAO = new OrderDao();

	}
	public String trackOrder(int orderId, int userId) {

		try {
			

			Order order = orderDAO.findOrderById(orderId, userId);

			if (order == null) {

				return "Sorry, I cannot find this order.";

			}

			return "Your order #" + order.getOrderId() + " is currently " + order.getStatus() + ". Delivery address: "
					+ order.getAddress();

		} catch (Exception e) {

			e.printStackTrace();

			return "Something went wrong while checking your order.";

		}

	}

}