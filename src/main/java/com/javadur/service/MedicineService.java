package com.javadur.service;

import com.javadur.entity.Medicine;
import com.javadur.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MedicineService {

    @Autowired
    private MedicineRepository medicineRepository;

    public List<Medicine> getAllMedicines() {
        return medicineRepository.findAll();
    }

    public Medicine getMedicine(Long id) {
        return medicineRepository.findById(id).orElse(null);
    }

    public List<Medicine> searchByIngredient(String ingredient) {
        return medicineRepository.findByIngredientContainingIgnoreCase(ingredient);
    }

    public List<Medicine> searchByEfficacy(String efficacy) {
        return medicineRepository.findByEfficacy(efficacy);
    }

    public List<Medicine> searchByName(String name) {
        return medicineRepository.findByNameContainingIgnoreCase(name);
    }

    public Medicine saveMedicine(Medicine medicine) {
        return medicineRepository.save(medicine);
    }
}
