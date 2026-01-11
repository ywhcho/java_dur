package com.pharmacy.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/", "/index", "/about"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if (path.equals("/about")) {
            request.getRequestDispatcher("/WEB-INF/views/about.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
        }
    }
}
