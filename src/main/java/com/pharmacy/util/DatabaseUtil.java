package com.pharmacy.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseUtil {
    private static String url;
    private static String username;
    private static String password;
    private static String driver;

    static {
        try {
            Properties props = new Properties();
            InputStream input = DatabaseUtil.class.getClassLoader()
                    .getResourceAsStream("db.properties");
            
            if (input == null) {
                throw new RuntimeException("Unable to find db.properties");
            }
            
            props.load(input);
            
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
            driver = props.getProperty("db.driver");
            
            Class.forName(driver);
            
            input.close();
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Failed to initialize database configuration", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
