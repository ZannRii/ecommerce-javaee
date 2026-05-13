package dao;

import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;
import model.User;

public class UserDAO {

    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // REGISTER
    public boolean register(User user) {
        boolean success = false;
        try {
            String sql = "INSERT INTO users(name, email, password,phone, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, "CUSTOMER");

            int rows = ps.executeUpdate();
            if (rows > 0) success = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // LOGIN
    public User login(String email, String password) {
        User user = null;

        try {
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
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    
    public boolean emailExists(String email) {
        boolean exists = false;
        try {
            String sql = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) exists = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }
    
    
}