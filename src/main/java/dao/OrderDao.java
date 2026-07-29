package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import model.Order;
import model.OrderItem;
import model.OrderItemDetail;
import model.User;
import util.DBConnection;

public class OrderDao {
	public int createOrder(int userId, double total, String address) {

		String sql = "INSERT INTO orders(user_id,total_amount,status,address) VALUES(?,?,?,?)";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			ps.setInt(1, userId);
			ps.setDouble(2, total);
			ps.setString(3, "PENDING");
			ps.setString(4, address);
			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1;
	}

	public void addOrderItem(int orderId, int productId, int quantity, double price) {

		String sql = "INSERT INTO order_items(order_id,product_id,quantity,price_at_purchase) VALUES(?,?,?,?)";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, orderId);
			ps.setInt(2, productId);
			ps.setInt(3, quantity);
			ps.setDouble(4, price);

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<OrderItemDetail> getFullOrderHistory(int userId) {
		List<OrderItemDetail> orderList = new ArrayList<>();
		// LinkedHashMap maintains the database retrieval order (newest orders first)
		Map<Integer, OrderItemDetail> orderMap = new LinkedHashMap<>();

		String sql = "SELECT o.order_id, o.total_amount, o.status, o.address, o.created_at, "
				+ "       oi.quantity, oi.price_at_purchase, p.name AS product_name, p.image_url " + "FROM orders o "
				+ "JOIN order_items oi ON o.order_id = oi.order_id "
				+ "JOIN products p ON oi.product_id = p.product_id " + "WHERE o.user_id = ? "
				+ "ORDER BY o.created_at DESC";

		// Using your project's DBConnection utility class
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, userId);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					int orderId = rs.getInt("order_id");

					// Group items belonging to the same order
					OrderItemDetail order = orderMap.get(orderId);
					if (order == null) {
						order = new OrderItemDetail();
						order.setOrderId(orderId);
						order.setTotalAmount(rs.getBigDecimal("total_amount"));
						order.setStatus(rs.getString("status"));
						order.setAddress(rs.getString("address"));
						order.setCreatedAt(rs.getTimestamp("created_at"));
						orderMap.put(orderId, order);
					}

					// Build item detail map
					Map<String, Object> item = new HashMap<>();
					item.put("productName", rs.getString("product_name"));
					item.put("imageUrl", rs.getString("image_url"));
					item.put("quantity", rs.getInt("quantity"));
					item.put("priceAtPurchase", rs.getBigDecimal("price_at_purchase"));

					order.getItems().add(item);
				}
			}

			// Convert the map values directly into our final list output
			orderList.addAll(orderMap.values());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return orderList;
	}

	public void cancelOrder(int orderId) {

		String getItems = "SELECT product_id, quantity FROM order_items WHERE order_id=?";

		String updateOrder = "UPDATE orders SET status='CANCELLED' WHERE order_id=?";

		String updateStock = "UPDATE products SET stock_quantity = stock_quantity + ? WHERE product_id=?";

		try (Connection conn = DBConnection.getConnection()) {

			// 1. restore stock
			PreparedStatement ps1 = conn.prepareStatement(getItems);
			ps1.setInt(1, orderId);
			ResultSet rs = ps1.executeQuery();

			while (rs.next()) {

				int productId = rs.getInt("product_id");
				int qty = rs.getInt("quantity");

				PreparedStatement ps2 = conn.prepareStatement(updateStock);
				ps2.setInt(1, qty);
				ps2.setInt(2, productId);
				ps2.executeUpdate();
			}

			// 2. cancel order
			PreparedStatement ps3 = conn.prepareStatement(updateOrder);
			ps3.setInt(1, orderId);
			ps3.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int countOrders() {

		String sql = "SELECT COUNT(*) FROM orders";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public List<Order> getAllOrders() {

		List<Order> orders = new ArrayList<>();

		String sql = "SELECT o.*, u.name " + "FROM orders o " + "JOIN users u ON o.user_id=u.user_id "
				+ "ORDER BY o.created_at DESC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Order order = new Order();

				order.setOrderId(rs.getInt("order_id"));
				order.setTotalAmount(rs.getDouble("total_amount"));
				order.setStatus(rs.getString("status"));
				order.setCreatedAt(rs.getTimestamp("created_at"));

				User user = new User();
				user.setName(rs.getString("name"));

				order.setUser(user);

				orders.add(order);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return orders;
	}

	public Order getOrderById(int orderId) {

		Order order = null;

		String sql = "SELECT o.*, u.name, u.email, u.phone " + "FROM orders o "
				+ "JOIN users u ON o.user_id = u.user_id " + "WHERE o.order_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, orderId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				order = new Order();

				order.setOrderId(rs.getInt("order_id"));
				order.setTotalAmount(rs.getDouble("total_amount"));
				order.setStatus(rs.getString("status"));
				order.setCreatedAt(rs.getTimestamp("created_at"));
				order.setAddress(rs.getString("address"));

				User user = new User();
				user.setUserId(rs.getInt("user_id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPhone(rs.getString("phone"));

				order.setUser(user);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return order;
	}

	// get order item
	public List<OrderItem> getOrderItems(int orderId) {

		List<OrderItem> items = new ArrayList<>();

		String sql = "SELECT oi.quantity, oi.price_at_purchase, " + "p.name, p.image_url " + "FROM order_items oi "
				+ "JOIN products p ON oi.product_id = p.product_id " + "WHERE oi.order_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, orderId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				OrderItem item = new OrderItem();

				item.setQuantity(rs.getInt("quantity"));
				item.setPriceAtPurchase(rs.getDouble("price_at_purchase"));

				// product info (for UI)
				item.setProductName(rs.getString("name"));
				item.setImageUrl(rs.getString("image_url"));

				items.add(item);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return items;
	}

	// allowed transitions
	private static final Map<String, List<String>> allowedTransitions = new HashMap<>();

	static {
		allowedTransitions.put("PENDING", Arrays.asList("SHIPPED", "CANCELLED"));

		allowedTransitions.put("SHIPPED", Arrays.asList("DELIVERED"));

		allowedTransitions.put("DELIVERED", Arrays.asList());

		allowedTransitions.put("CANCELLED", Arrays.asList());
	}

	// Update status
	public boolean updateOrderStatus(int orderId, String newStatus) {

		Connection conn = null;

		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);

			// 1. get current status
			String sql = "SELECT status FROM orders WHERE order_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, orderId);

			ResultSet rs = ps.executeQuery();

			if (!rs.next()) {
				conn.rollback();
				return false;
			}

			String currentStatus = rs.getString("status");

			// 2. validate transition
			List<String> allowedNext = allowedTransitions.get(currentStatus);

			if (allowedNext == null || !allowedNext.contains(newStatus)) {
				conn.rollback();
				return false;
			}

			// 3. STOCK RESTORE (ONLY IF CANCEL)
			if (newStatus.equals("CANCELLED")) {
				restoreStock(conn, orderId);
			}

			// 4. update order
			String updateSql = "UPDATE orders SET status = ? WHERE order_id = ?";

			PreparedStatement ps2 = conn.prepareStatement(updateSql);
			ps2.setString(1, newStatus);
			ps2.setInt(2, orderId);

			ps2.executeUpdate();

			conn.commit();
			return true;

		} catch (Exception e) {

			try {
				if (conn != null)
					conn.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
			}

			e.printStackTrace();

		} finally {
			try {
				if (conn != null)
					conn.setAutoCommit(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	// STOCK RESTORE LOGIC
	private void restoreStock(Connection conn, int orderId) throws Exception {

		String sql = "SELECT product_id, quantity FROM order_items WHERE order_id = ?";

		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, orderId);

		ResultSet rs = ps.executeQuery();

		String updateStock = "UPDATE products SET stock_quantity = stock_quantity + ? WHERE product_id = ?";

		PreparedStatement ps2 = conn.prepareStatement(updateStock);

		while (rs.next()) {

			ps2.setInt(1, rs.getInt("quantity"));
			ps2.setInt(2, rs.getInt("product_id"));

			ps2.executeUpdate();
		}
	}

	// for chat
	public Order findOrderById(int orderId, int userId) throws Exception {

		String sql = "SELECT order_id, user_id, total_amount, status, address, created_at FROM orders WHERE order_id = ? AND user_id = ?";

		Connection con = DBConnection.getConnection();

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, orderId);

		ps.setInt(2, userId);

		ResultSet rs = ps.executeQuery();

		Order order = null;

		if (rs.next()) {

			order = new Order();

			order.setOrderId(rs.getInt("order_id"));

			order.setUserId(rs.getInt("user_id"));

			order.setTotalAmount(rs.getDouble("total_amount"));

			order.setStatus(rs.getString("status"));

			order.setAddress(rs.getString("address"));

			order.setCreatedAt(rs.getTimestamp("created_at"));

		}

		con.close();

		return order;

	}

	// for chat
	public boolean cancelOrder(int orderId, int userId) throws Exception {

		String sql = "UPDATE orders SET status = 'CANCELLED' WHERE order_id = ? AND user_id = ?";

		Connection con = DBConnection.getConnection();

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, orderId);

		ps.setInt(2, userId);

		int rows = ps.executeUpdate();

		con.close();

		return rows > 0;
	}

}
