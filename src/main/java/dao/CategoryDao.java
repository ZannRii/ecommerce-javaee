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

	            list.add(c);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
}
