package com.pharmacy.service;

import com.pharmacy.dao.MedicineDAO;
import com.pharmacy.model.Medicine;

import java.sql.SQLException;
import java.util.List;

public class MedicineService {
    private MedicineDAO medicineDAO;

    public MedicineService() {
        this.medicineDAO = new MedicineDAO();
    }

    public List<Medicine> getAllMedicines() throws SQLException {
        return medicineDAO.findAll();
    }

    public Medicine getMedicine(int id) throws SQLException {
        return medicineDAO.findById(id);
    }

    public List<Medicine> searchByIngredient(String ingredient) throws SQLException {
        return medicineDAO.searchByIngredient(ingredient);
    }

    public List<Medicine> searchByEfficacy(String efficacy) throws SQLException {
        return medicineDAO.searchByEfficacy(efficacy);
    }

    public List<String> getEfficacyCategories() throws SQLException {
        return medicineDAO.getDistinctEfficacies();
    }
}
