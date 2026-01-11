package com.pharmacy.servlet;

import com.pharmacy.model.Medicine;
import com.pharmacy.service.MedicineService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "MedicineServlet", urlPatterns = {"/medicine/*"})
public class MedicineServlet extends HttpServlet {
    private MedicineService medicineService;

    @Override
    public void init() throws ServletException {
        medicineService = new MedicineService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/search")) {
            showSearchPage(request, response);
        } else if (pathInfo.startsWith("/view/")) {
            viewMedicine(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showSearchPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");

        try {
            List<String> efficacies = medicineService.getEfficacyCategories();
            request.setAttribute("efficacies", efficacies);

            if (keyword != null && !keyword.trim().isEmpty()) {
                List<Medicine> medicines;
                
                if ("ingredient".equals(searchType)) {
                    medicines = medicineService.searchByIngredient(keyword);
                    request.setAttribute("searchType", "ingredient");
                } else if ("efficacy".equals(searchType)) {
                    medicines = medicineService.searchByEfficacy(keyword);
                    request.setAttribute("searchType", "efficacy");
                } else {
                    medicines = medicineService.getAllMedicines();
                }
                
                request.setAttribute("medicines", medicines);
                request.setAttribute("keyword", keyword);
            }

            request.getRequestDispatcher("/WEB-INF/views/medicine/search.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load medicine information");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void viewMedicine(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        int medicineId = Integer.parseInt(pathInfo.substring(pathInfo.lastIndexOf('/') + 1));

        try {
            Medicine medicine = medicineService.getMedicine(medicineId);
            
            if (medicine == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            request.setAttribute("medicine", medicine);
            request.getRequestDispatcher("/WEB-INF/views/medicine/view.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load medicine information");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
