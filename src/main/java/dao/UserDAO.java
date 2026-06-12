package dao;

import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;
import model.User;
import util.DBConnection;

public class UserDAO {

    // REGISTER
    public boolean register(User user) {
        boolean success = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO users(name, email, password, phone, role) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, "CUSTOMER");

            success = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }

    // LOGIN
    public User login(String email, String password) {

        User user = null;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM users WHERE email=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String hashedPassword = rs.getString("password");

                if (BCrypt.checkpw(password, hashedPassword)) {

                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // EMAIL CHECK
    public boolean emailExists(String email) {

        boolean exists = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT 1 FROM users WHERE email=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            exists = rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }
    
    public boolean updateProfile(User user) {

        String sql =
            "UPDATE users SET name=?, phone=?, email=? WHERE user_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getEmail());
            ps.setInt(4, user.getUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    public int countUsers() {

		String sql = "SELECT COUNT(*) FROM users";

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
}