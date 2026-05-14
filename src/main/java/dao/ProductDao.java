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
}