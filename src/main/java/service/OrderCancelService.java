package service;

import dao.OrderDao;

public class OrderCancelService {

	private OrderDao orderDao;

	public OrderCancelService() {
		orderDao = new OrderDao();
	}

	public String cancelOrder(int orderId, int userId) throws Exception {

		boolean success = orderDao.cancelOrder(orderId, userId);

		if (success) {
			return "Order #" + orderId + " has been cancelled.";
		}

		return "Unable to cancel order.";
	}
}