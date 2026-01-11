package com.javadur.controller;

import com.javadur.entity.Medicine;
import com.javadur.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/medicine")
public class MedicineController {

    @Autowired
    private MedicineService medicineService;

    @GetMapping
    public String index() {
        return "medicine/index";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) String ingredient,
                        Model model) {
        if (ingredient != null && !ingredient.trim().isEmpty()) {
            List<Medicine> medicines = medicineService.searchByIngredient(ingredient);
            model.addAttribute("medicines", medicines);
            model.addAttribute("searchType", "ingredient");
            model.addAttribute("searchTerm", ingredient);
        }
        return "medicine/search";
    }

    @GetMapping("/efficacy")
    public String efficacy(@RequestParam(required = false) String efficacy,
                          Model model) {
        if (efficacy != null && !efficacy.trim().isEmpty()) {
            List<Medicine> medicines = medicineService.searchByEfficacy(efficacy);
            model.addAttribute("medicines", medicines);
            model.addAttribute("searchType", "efficacy");
            model.addAttribute("searchTerm", efficacy);
        }
        return "medicine/efficacy";
    }

    @GetMapping("/{id}")
    public String view(@PathVariable Long id, Model model) {
        Medicine medicine = medicineService.getMedicine(id);
        if (medicine == null) {
            return "redirect:/medicine";
        }
        model.addAttribute("medicine", medicine);
        return "medicine/view";
    }
}
