package com.pharmacy.service;

import com.pharmacy.dao.BoardDAO;
import com.pharmacy.model.Board;

import java.sql.SQLException;
import java.util.List;

public class BoardService {
    private BoardDAO boardDAO;

    public BoardService() {
        this.boardDAO = new BoardDAO();
    }

    public List<Board> getBoardList(int page, int pageSize) throws SQLException {
        int offset = (page - 1) * pageSize;
        return boardDAO.findAll(pageSize, offset);
    }

    public Board getBoard(int id) throws SQLException {
        return boardDAO.findById(id);
    }

    public int getTotalPages(int pageSize) throws SQLException {
        int totalCount = boardDAO.getTotalCount();
        return (int) Math.ceil((double) totalCount / pageSize);
    }

    public int getTotalCount() throws SQLException {
        return boardDAO.getTotalCount();
    }

    public boolean createBoard(String title, String content, int authorId) throws SQLException {
        Board board = new Board(title, content, authorId);
        return boardDAO.createBoard(board);
    }

    public boolean updateBoard(int id, String title, String content, int userId) throws SQLException {
        Board board = boardDAO.findById(id);
        
        if (board == null) {
            return false;
        }

        // Check if user is the author
        if (board.getAuthorId() != userId) {
            throw new SecurityException("Not authorized to update this post");
        }

        board.setTitle(title);
        board.setContent(content);
        
        return boardDAO.updateBoard(board);
    }

    public boolean deleteBoard(int id, int userId) throws SQLException {
        Board board = boardDAO.findById(id);
        
        if (board == null) {
            return false;
        }

        // Check if user is the author
        if (board.getAuthorId() != userId) {
            throw new SecurityException("Not authorized to delete this post");
        }

        return boardDAO.deleteBoard(id);
    }
}
