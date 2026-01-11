package com.pharmacy.service;

import com.pharmacy.dao.UserDAO;
import com.pharmacy.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLException;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public User register(String username, String password, String name, String email) throws SQLException {
        // Check if username already exists
        if (userDAO.findByUsername(username) != null) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Hash password
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Create user
        User user = new User(username, hashedPassword, name, email);
        boolean success = userDAO.createUser(user);

        if (success) {
            return userDAO.findByUsername(username);
        }
        return null;
    }

    public User login(String username, String password) throws SQLException {
        User user = userDAO.findByUsername(username);
        
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public User getUserById(int id) throws SQLException {
        return userDAO.findById(id);
    }

    public boolean updateUser(User user) throws SQLException {
        return userDAO.updateUser(user);
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword) throws SQLException {
        User user = userDAO.findById(userId);
        
        if (user == null) {
            return false;
        }

        // Verify old password
        if (!BCrypt.checkpw(oldPassword, user.getPassword())) {
            return false;
        }

        // Hash new password
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        
        return userDAO.updatePassword(userId, hashedPassword);
    }
}
