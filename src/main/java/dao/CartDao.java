package dao;

import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.CartItem;
import model.Product;

public class CartDao {

    public int getCartIdByUser(int userId) {

        String sql = "SELECT cart_id FROM cart WHERE user_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("cart_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    public int createCart(int userId) {

        String sql = "INSERT INTO cart(user_id) VALUES(?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);
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
    
    public List<CartItem> getCartItems(int userId) {

        List<CartItem> cartItems = new ArrayList<>();

        String sql =
            "SELECT ci.cart_item_id, ci.quantity, " +
            "p.product_id, p.name, p.price, p.image_url, p.stock_quantity " +
            "FROM cart_items ci " +
            "JOIN cart c ON ci.cart_id = c.cart_id " +
            "JOIN products p ON ci.product_id = p.product_id " +
            "WHERE c.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStockQuantity(rs.getInt("stock_quantity"));

                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProduct(product);

                cartItems.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }
}