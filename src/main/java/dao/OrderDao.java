package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import util.DBConnection;

public class OrderDao {
	public int createOrder(int userId, double total) {

		String sql = "INSERT INTO orders(user_id,total_amount,status) VALUES(?,?,?)";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			ps.setInt(1, userId);
			ps.setDouble(2, total);
			ps.setString(3, "PENDING");

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

	
}
