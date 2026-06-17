package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Category;
import util.DBConnection;

public class CategoryDao {

	public List<Category> getAllCategories() {

		List<Category> list = new ArrayList<>();

		String sql = "SELECT * FROM categories";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Category c = new Category();
				c.setCategoryId(rs.getInt("category_id"));
				c.setName(rs.getString("name"));
				c.setDescription(rs.getString("description"));

				list.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean insert(Category category) {

		String sql = "INSERT INTO categories(name,description) VALUES(?,?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, category.getName());
			ps.setString(2, category.getDescription());

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// DELETE
	public boolean delete(int id) {

		String sql = "DELETE FROM categories WHERE category_id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// UPDATE
	public boolean update(Category c) {

		String sql = "UPDATE categories SET name=?, description=? WHERE category_id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, c.getName());
            ps.setString(2, c.getDescription());
            ps.setInt(3, c.getCategoryId());
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// FIND BY ID
	public Category findById(int id) {

		String sql = "SELECT * FROM categories WHERE category_id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				Category c = new Category();
				c.setCategoryId(rs.getInt("category_id"));
				c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
				return c;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}
}
