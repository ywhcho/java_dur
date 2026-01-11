package com.javadur.controller;

import com.javadur.entity.Board;
import com.javadur.entity.User;
import com.javadur.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "0") int page,
                      @RequestParam(defaultValue = "10") int size,
                      Model model) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Board> boardPage = boardService.getAllBoards(pageable);
        model.addAttribute("boards", boardPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", boardPage.getTotalPages());
        model.addAttribute("totalItems", boardPage.getTotalElements());
        return "board/list";
    }

    @GetMapping("/{id}")
    public String view(@PathVariable Long id, Model model) {
        Board board = boardService.getBoard(id);
        if (board == null) {
            return "redirect:/board";
        }
        model.addAttribute("board", board);
        return "board/view";
    }

    @GetMapping("/create")
    public String createForm(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        return "board/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute Board board, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        board.setAuthor(user.getUsername());
        boardService.createBoard(board);
        return "redirect:/board";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        Board board = boardService.getBoard(id);
        if (board == null || !board.getAuthor().equals(user.getUsername())) {
            return "redirect:/board";
        }
        model.addAttribute("board", board);
        return "board/edit";
    }

    @PostMapping("/edit/{id}")
    public String update(@PathVariable Long id, 
                        @ModelAttribute Board board,
                        HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        Board existingBoard = boardService.getBoard(id);
        if (existingBoard == null || !existingBoard.getAuthor().equals(user.getUsername())) {
            return "redirect:/board";
        }
        board.setAuthor(existingBoard.getAuthor());
        board.setViewCount(existingBoard.getViewCount());
        board.setCreatedAt(existingBoard.getCreatedAt());
        boardService.updateBoard(id, board);
        return "redirect:/board/" + id;
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }
        Board board = boardService.getBoard(id);
        if (board == null || !board.getAuthor().equals(user.getUsername())) {
            return "redirect:/board";
        }
        boardService.deleteBoard(id);
        return "redirect:/board";
    }
}
