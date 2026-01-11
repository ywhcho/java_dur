package com.pharmacy.servlet;

import com.pharmacy.model.Board;
import com.pharmacy.model.User;
import com.pharmacy.service.BoardService;
import com.pharmacy.util.SecurityUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "BoardServlet", urlPatterns = {"/board/*"})
public class BoardServlet extends HttpServlet {
    private BoardService boardService;
    private static final int PAGE_SIZE = 10;

    @Override
    public void init() throws ServletException {
        boardService = new BoardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/list")) {
            listBoards(request, response);
        } else if (pathInfo.equals("/create")) {
            showCreateForm(request, response);
        } else if (pathInfo.startsWith("/view/")) {
            viewBoard(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            showEditForm(request, response);
        } else if (pathInfo.startsWith("/delete/")) {
            deleteBoard(request, response);
        } else {
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

        if (pathInfo.equals("/create")) {
            createBoard(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            updateBoard(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listBoards(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        try {
            List<Board> boards = boardService.getBoardList(page, PAGE_SIZE);
            int totalPages = boardService.getTotalPages(PAGE_SIZE);
            int totalCount = boardService.getTotalCount();

            request.setAttribute("boards", boards);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCount", totalCount);

            request.getRequestDispatcher("/WEB-INF/views/board/list.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load board list");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void viewBoard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        int boardId = Integer.parseInt(pathInfo.substring(pathInfo.lastIndexOf('/') + 1));

        try {
            Board board = boardService.getBoard(boardId);
            
            if (board == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            request.setAttribute("board", board);
            request.getRequestDispatcher("/WEB-INF/views/board/view.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load board");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/board/create.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        int boardId = Integer.parseInt(pathInfo.substring(pathInfo.lastIndexOf('/') + 1));

        try {
            Board board = boardService.getBoard(boardId);
            
            if (board == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            if (board.getAuthorId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            request.setAttribute("board", board);
            request.getRequestDispatcher("/WEB-INF/views/board/edit.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to load board");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void createBoard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
            request.setAttribute("error", "Title and content are required");
            request.getRequestDispatcher("/WEB-INF/views/board/create.jsp").forward(request, response);
            return;
        }

        // Escape HTML to prevent XSS
        title = SecurityUtil.escapeHtml(title);
        content = SecurityUtil.escapeHtml(content);

        try {
            if (boardService.createBoard(title, content, user.getId())) {
                response.sendRedirect(request.getContextPath() + "/board/list");
            } else {
                request.setAttribute("error", "Failed to create board");
                request.getRequestDispatcher("/WEB-INF/views/board/create.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/WEB-INF/views/board/create.jsp").forward(request, response);
        }
    }

    private void updateBoard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        int boardId = Integer.parseInt(pathInfo.substring(pathInfo.lastIndexOf('/') + 1));

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
            request.setAttribute("error", "Title and content are required");
            try {
                Board board = boardService.getBoard(boardId);
                request.setAttribute("board", board);
            } catch (SQLException e) {
                // Ignore
            }
            request.getRequestDispatcher("/WEB-INF/views/board/edit.jsp").forward(request, response);
            return;
        }

        // Escape HTML to prevent XSS
        title = SecurityUtil.escapeHtml(title);
        content = SecurityUtil.escapeHtml(content);

        try {
            if (boardService.updateBoard(boardId, title, content, user.getId())) {
                response.sendRedirect(request.getContextPath() + "/board/view/" + boardId);
            } else {
                request.setAttribute("error", "Failed to update board");
                Board board = boardService.getBoard(boardId);
                request.setAttribute("board", board);
                request.getRequestDispatcher("/WEB-INF/views/board/edit.jsp").forward(request, response);
            }
        } catch (SecurityException e) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/WEB-INF/views/board/edit.jsp").forward(request, response);
        }
    }

    private void deleteBoard(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        
        String pathInfo = request.getPathInfo();
        int boardId = Integer.parseInt(pathInfo.substring(pathInfo.lastIndexOf('/') + 1));

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        try {
            if (boardService.deleteBoard(boardId, user.getId())) {
                response.sendRedirect(request.getContextPath() + "/board/list");
            } else {
                request.setAttribute("error", "Failed to delete board");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            }
        } catch (SecurityException e) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
