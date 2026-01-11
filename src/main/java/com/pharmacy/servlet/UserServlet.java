package com.pharmacy.servlet;

import com.pharmacy.model.User;
import com.pharmacy.service.UserService;
import com.pharmacy.util.SecurityUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserServlet", urlPatterns = {"/user/*"})
public class UserServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        switch (pathInfo) {
            case "/login":
                showLoginPage(request, response);
                break;
            case "/register":
                showRegisterPage(request, response);
                break;
            case "/logout":
                logout(request, response);
                break;
            case "/profile":
                showProfilePage(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();

        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        switch (pathInfo) {
            case "/login":
                login(request, response);
                break;
            case "/register":
                register(request, response);
                break;
            case "/profile":
                updateProfile(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
    }

    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
    }

    private void showProfilePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            User user = userService.login(username, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                String redirect = request.getParameter("redirect");
                if (redirect != null && !redirect.isEmpty()) {
                    response.sendRedirect(redirect);
                } else {
                    response.sendRedirect(request.getContextPath() + "/");
                }
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/WEB-INF/views/user/login.jsp").forward(request, response);
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Validate inputs
        if (!SecurityUtil.isValidUsername(username)) {
            request.setAttribute("error", "Invalid username. Use 3-20 alphanumeric characters.");
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
            return;
        }

        if (!SecurityUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
            return;
        }

        if (!SecurityUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email address.");
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
            return;
        }

        try {
            User user = userService.register(username, password, name, email);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                request.setAttribute("error", "Registration failed");
                request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        if (!SecurityUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email address.");
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
            return;
        }

        user.setName(name);
        user.setEmail(email);

        try {
            if (userService.updateUser(user)) {
                session.setAttribute("user", user);
                request.setAttribute("success", "Profile updated successfully");
            } else {
                request.setAttribute("error", "Failed to update profile");
            }
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/");
    }
}
