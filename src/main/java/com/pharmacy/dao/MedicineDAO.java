package com.pharmacy.dao;

import com.pharmacy.model.Medicine;
import com.pharmacy.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {

    public List<Medicine> findAll() throws SQLException {
        String sql = "SELECT * FROM medicine ORDER BY name";
        
        List<Medicine> medicines = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                medicines.add(mapResultSetToMedicine(rs));
            }
        }
        return medicines;
    }

    public Medicine findById(int id) throws SQLException {
        String sql = "SELECT * FROM medicine WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMedicine(rs);
                }
            }
        }
        return null;
    }

    public List<Medicine> searchByIngredient(String ingredient) throws SQLException {
        String sql = "SELECT * FROM medicine WHERE ingredient LIKE ? ORDER BY name";
        
        List<Medicine> medicines = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + ingredient + "%");
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    medicines.add(mapResultSetToMedicine(rs));
                }
            }
        }
        return medicines;
    }

    public List<Medicine> searchByEfficacy(String efficacy) throws SQLException {
        String sql = "SELECT * FROM medicine WHERE efficacy LIKE ? ORDER BY name";
        
        List<Medicine> medicines = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + efficacy + "%");
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    medicines.add(mapResultSetToMedicine(rs));
                }
            }
        }
        return medicines;
    }

    public List<String> getDistinctEfficacies() throws SQLException {
        String sql = "SELECT DISTINCT efficacy FROM medicine ORDER BY efficacy";
        
        List<String> efficacies = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                efficacies.add(rs.getString("efficacy"));
            }
        }
        return efficacies;
    }

    private Medicine mapResultSetToMedicine(ResultSet rs) throws SQLException {
        Medicine medicine = new Medicine();
        medicine.setId(rs.getInt("id"));
        medicine.setName(rs.getString("name"));
        medicine.setIngredient(rs.getString("ingredient"));
        medicine.setEfficacy(rs.getString("efficacy"));
        medicine.setUsage(rs.getString("usage"));
        medicine.setPrecautions(rs.getString("precautions"));
        medicine.setCreatedAt(rs.getTimestamp("created_at"));
        return medicine;
    }
}
