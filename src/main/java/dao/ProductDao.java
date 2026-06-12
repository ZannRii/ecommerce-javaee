package dao;

import model.Product;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class ProductDao {

	public List<Product> getAllProducts() {

		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM products";

		try {

			Connection con = DBConnection.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Product p = new Product();

				p.setProductId(rs.getInt("product_id"));
				p.setName(rs.getString("name"));
				p.setDescription(rs.getString("description"));
				p.setPrice(rs.getDouble("price"));
				p.setStockQuantity(rs.getInt("stock_quantity"));
				p.setImageUrl(rs.getString("image_url"));
				p.setCategoryId(rs.getInt("category_id"));
				products.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return products;
	}

	// For Product Detail
	public Product findById(int id) {

		Product product = null;

		try {
			String sql = "SELECT * FROM products WHERE product_id = ?";
			Connection con = DBConnection.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				product = new Product();
				product.setProductId(rs.getInt("product_id"));
				product.setName(rs.getString("name"));
				product.setDescription(rs.getString("description"));
				product.setPrice(rs.getDouble("price"));
				product.setStockQuantity(rs.getInt("stock_quantity"));
				product.setImageUrl(rs.getString("image_url"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return product;
	}

	public void updateStock(int productId, int stock) {

		String sql = "UPDATE products SET stock_quantity=? WHERE product_id=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, stock);
			ps.setInt(2, productId);

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int countProducts() {

		String sql = "SELECT COUNT(*) FROM products";

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

	public void insert(Product p) {

		String sql = "INSERT INTO products(name, description, price, stock_quantity, image_url, category_id) "
				+ "VALUES(?,?,?,?,?,?)";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setInt(4, p.getStockQuantity());
			ps.setString(5, p.getImageUrl());
			ps.setInt(6, p.getCategoryId());

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}