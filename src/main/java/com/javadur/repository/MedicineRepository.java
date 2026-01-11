package com.javadur.repository;

import com.javadur.entity.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {
    List<Medicine> findByIngredientContainingIgnoreCase(String ingredient);
    List<Medicine> findByEfficacy(String efficacy);
    List<Medicine> findByNameContainingIgnoreCase(String name);
}
