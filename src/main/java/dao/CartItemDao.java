package dao;
import java.sql.*;
import java.util.*;
import model.*;
import util.DBConnection;

public class CartItemDao {

    // ADD OR UPDATE (VERY IMPORTANT)
    public void addOrUpdate(int cartId, int productId, int qty) {

        String checkSql =
            "SELECT quantity FROM cart_items WHERE cart_id=? AND product_id=?";

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(checkSql);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int oldQty = rs.getInt("quantity");

                String updateSql =
                    "UPDATE cart_items SET quantity=? WHERE cart_id=? AND product_id=?";

                PreparedStatement ups = con.prepareStatement(updateSql);
                ups.setInt(1, oldQty + qty);
                ups.setInt(2, cartId);
                ups.setInt(3, productId);
                ups.executeUpdate();

            } else {

                String insertSql =
                    "INSERT INTO cart_items(cart_id, product_id, quantity) VALUES(?,?,?)";

                PreparedStatement ips = con.prepareStatement(insertSql);
                ips.setInt(1, cartId);
                ips.setInt(2, productId);
                ips.setInt(3, qty);
                ips.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // REMOVE ITEM
    public void removeItem(int cartId, int productId) {

        String sql = "DELETE FROM cart_items WHERE cart_id=? AND product_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // UPDATE QUANTITY
    public void updateQuantity(int cartId, int productId, int qty) {

        String sql =
            "UPDATE cart_items SET quantity=? WHERE cart_id=? AND product_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, qty);
            ps.setInt(2, cartId);
            ps.setInt(3, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET CART ITEMS (JOIN PRODUCT)
    public List<CartItem> getCartItems(int cartId) {

        List<CartItem> list = new ArrayList<>();

        String sql =
            "SELECT ci.cart_item_id, ci.quantity, " +
            "p.product_id, p.name, p.price, p.image_url " +
            "FROM cart_items ci " +
            "JOIN product p ON ci.product_id = p.product_id " +
            "WHERE ci.cart_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));

                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setProduct(p);

                int qty = rs.getInt("quantity");
                item.setQuantity(qty);

                item.setSubtotal(qty * p.getPrice());

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // TOTAL PRICE
    public double getTotal(int cartId) {

        double total = 0;

        for (CartItem item : getCartItems(cartId)) {
            total += item.getSubtotal();
        }

        return total;
    }
    // TOTAL QUANTITY
    public int getTotalQuantity(int cartId) {

        int totalQty = 0;

        String sql =
            "SELECT SUM(quantity) AS totalQty " +
            "FROM cart_items " +
            "WHERE cart_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalQty = rs.getInt("totalQty");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalQty;
    }
}