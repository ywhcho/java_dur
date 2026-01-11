package com.pharmacy.dao;

import com.pharmacy.model.Board;
import com.pharmacy.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

    public List<Board> findAll(int limit, int offset) throws SQLException {
        String sql = "SELECT b.*, u.name as author_name FROM board b " +
                     "JOIN users u ON b.author_id = u.id " +
                     "ORDER BY b.created_at DESC LIMIT ? OFFSET ?";
        
        List<Board> boards = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    boards.add(mapResultSetToBoard(rs));
                }
            }
        }
        return boards;
    }

    public Board findById(int id) throws SQLException {
        String sql = "SELECT b.*, u.name as author_name FROM board b " +
                     "JOIN users u ON b.author_id = u.id " +
                     "WHERE b.id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBoard(rs);
                }
            }
        }
        return null;
    }

    public int getTotalCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM board";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public boolean createBoard(Board board) throws SQLException {
        String sql = "INSERT INTO board (title, content, author_id) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, board.getTitle());
            stmt.setString(2, board.getContent());
            stmt.setInt(3, board.getAuthorId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateBoard(Board board) throws SQLException {
        String sql = "UPDATE board SET title = ?, content = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, board.getTitle());
            stmt.setString(2, board.getContent());
            stmt.setInt(3, board.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteBoard(int id) throws SQLException {
        String sql = "DELETE FROM board WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            return stmt.executeUpdate() > 0;
        }
    }

    private Board mapResultSetToBoard(ResultSet rs) throws SQLException {
        Board board = new Board();
        board.setId(rs.getInt("id"));
        board.setTitle(rs.getString("title"));
        board.setContent(rs.getString("content"));
        board.setAuthorId(rs.getInt("author_id"));
        board.setAuthorName(rs.getString("author_name"));
        board.setCreatedAt(rs.getTimestamp("created_at"));
        board.setUpdatedAt(rs.getTimestamp("updated_at"));
        return board;
    }
}
