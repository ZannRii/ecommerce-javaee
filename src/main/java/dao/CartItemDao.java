package dao;

import java.sql.*;
import java.util.*;
import model.*;
import util.DBConnection;

public class CartItemDao {

	// ADD OR UPDATE
	public void addOrUpdate(int cartId, int productId, int qty) {

		String check = "SELECT quantity FROM cart_items WHERE cart_id=? AND product_id=?";
		String insert = "INSERT INTO cart_items(cart_id, product_id, quantity) VALUES(?,?,?)";
		String update = "UPDATE cart_items SET quantity=? WHERE cart_id=? AND product_id=?";

		try (Connection con = DBConnection.getConnection()) {

			PreparedStatement ps = con.prepareStatement(check);
			ps.setInt(1, cartId);
			ps.setInt(2, productId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				int newQty = rs.getInt("quantity") + qty;

				PreparedStatement ups = con.prepareStatement(update);
				ups.setInt(1, newQty);
				ups.setInt(2, cartId);
				ups.setInt(3, productId);
				ups.executeUpdate();

			} else {
				PreparedStatement ips = con.prepareStatement(insert);
				ips.setInt(1, cartId);
				ips.setInt(2, productId);
				ips.setInt(3, qty);
				ips.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// REMOVE
	public void remove(int cartId, int productId) {

		String sql = "DELETE FROM cart_items WHERE cart_id=? AND product_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, cartId);
			ps.setInt(2, productId);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// UPDATE QTY
	public void updateQty(int cartId, int productId, int qty) {

		String sql = "UPDATE cart_items SET quantity=? WHERE cart_id=? AND product_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, qty);
			ps.setInt(2, cartId);
			ps.setInt(3, productId);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// GET CART ITEMS
	public List<CartItem> getCartItems(int cartId) {

		List<CartItem> list = new ArrayList<>();

		String sql = "SELECT ci.cart_item_id, ci.quantity, p.product_id, p.name, p.price, p.image_url, p.stock_quantity "
				+ "FROM cart_items ci JOIN products p ON ci.product_id=p.product_id " + "WHERE ci.cart_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, cartId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Product p = new Product();
				p.setProductId(rs.getInt("product_id"));
				p.setName(rs.getString("name"));
				p.setPrice(rs.getDouble("price"));
				p.setImageUrl(rs.getString("image_url"));
				p.setStockQuantity(rs.getInt("stock_quantity"));
				
				CartItem item = new CartItem();
				item.setCartItemId(rs.getInt("cart_item_id"));
				item.setProduct(p);
				item.setQuantity(rs.getInt("quantity"));

				list.add(item);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// TOTAL PRICE
	public double getTotal(int cartId) {

		String sql = "SELECT SUM(ci.quantity * p.price) total "
				+ "FROM cart_items ci JOIN products p ON ci.product_id=p.product_id " + "WHERE ci.cart_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, cartId);
			ResultSet rs = ps.executeQuery();

			if (rs.next())
				return rs.getDouble("total");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	// TOTAL QUANTITY
	public int getTotalQty(int cartId) {

		String sql = "SELECT SUM(quantity) total FROM cart_items WHERE cart_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, cartId);
			ResultSet rs = ps.executeQuery();

			if (rs.next())
				return rs.getInt("total");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public void clearCart(int cartId) {

		String sql = "DELETE FROM cart_items WHERE cart_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, cartId);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int getQuantity(int cartId, int productId) {

		String sql = "SELECT quantity FROM cart_items WHERE cart_id=? AND product_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, cartId);
			ps.setInt(2, productId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getInt("quantity");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
}