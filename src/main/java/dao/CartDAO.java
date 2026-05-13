package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import util.DBConnection;

public class CartDAO {

    Connection con = DBConnection.getConnection();

    // ADD OR UPDATE CART
    public void addToCart(int userId, int productId, int quantity) {

        try {

            // 1. get cart id
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT cart_id FROM cart WHERE user_id=?"
            );
            ps1.setInt(1, userId);
            ResultSet rs = ps1.executeQuery();

            int cartId;

            if (rs.next()) {
                cartId = rs.getInt("cart_id");
            } else {
                PreparedStatement ps2 = con.prepareStatement(
                    "INSERT INTO cart(user_id) VALUES(?)",
                    Statement.RETURN_GENERATED_KEYS
                );
                ps2.setInt(1, userId);
                ps2.executeUpdate();

                ResultSet keys = ps2.getGeneratedKeys();
                keys.next();
                cartId = keys.getInt(1);
            }

            // 2. check product exists
            PreparedStatement ps3 = con.prepareStatement(
                "SELECT quantity FROM cart_items WHERE cart_id=? AND product_id=?"
            );
            ps3.setInt(1, cartId);
            ps3.setInt(2, productId);

            ResultSet rs2 = ps3.executeQuery();

            if (rs2.next()) {
                // update quantity
                PreparedStatement ps4 = con.prepareStatement(
                    "UPDATE cart_items SET quantity = quantity + ? WHERE cart_id=? AND product_id=?"
                );
                ps4.setInt(1, quantity);
                ps4.setInt(2, cartId);
                ps4.setInt(3, productId);
                ps4.executeUpdate();

            } else {
                // insert new item
                PreparedStatement ps5 = con.prepareStatement(
                    "INSERT INTO cart_items(cart_id, product_id, quantity) VALUES(?,?,?)"
                );
                ps5.setInt(1, cartId);
                ps5.setInt(2, productId);
                ps5.setInt(3, quantity);
                ps5.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET CART COUNT
    public int getCartItemCount(int userId) {

        int count = 0;

        try {
            PreparedStatement ps = con.prepareStatement(
                "SELECT SUM(ci.quantity) AS total " +
                "FROM cart c JOIN cart_items ci ON c.cart_id = ci.cart_id " +
                "WHERE c.user_id=?"
            );

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}