package com.kh.wehub.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.board.model.service.BoardService;
import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.member.model.vo.Member;

@Controller
@RequestMapping("/board")
@SessionAttributes("loginMember")
public class BoardController {
	@Autowired
	private BoardService service;
	
	@RequestMapping(value="/board", method={RequestMethod.GET})
	public ModelAndView listView(@SessionAttribute(name="loginMember", required=false) Member loginMember, ModelAndView model) {
		Board board = new Board();		
		List<Board> list = null;
		
		list = service.getBoardList(board);
		
		System.out.println(list);
		
		System.out.println("board.getUserId() : " + board.getUserId());
		System.out.println("loginMember.getUser_id() : " + loginMember.getUser_id());
		
		model.addObject("list", list);
		model.setViewName("board/board");
		
		return model;
	}
	
	@RequestMapping(value="/boardWrite", method={RequestMethod.GET})
	public String writeView() {
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value="/boardWrite", method={RequestMethod.POST})
	public ModelAndView boardWrite(@SessionAttribute(name="loginMember", required=false) Member loginMember, Board board, ModelAndView model) {
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(board.getUserId())) {
			board.setBoardWriterNo(loginMember.getUser_no());
			
			result = service.saveBoard(board);
			
			System.out.println(loginMember.getUser_no());
			
			if(result > 0) {
				model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
				model.addObject("location", "/board/board");
			} else {	
				model.addObject("msg", "게시글 등록에 실패하였습니다.");
				model.addObject("location", "/");
			}
			
		} else {	
			System.out.println(loginMember.getUser_no());
			
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/");
		}

		model.setViewName("common/msg");
		
		return model;
	}
	
	@RequestMapping(value="/update", method={RequestMethod.GET})
	public ModelAndView updateView(@RequestParam("boardNo") int boardNo, ModelAndView model) {
		Board board = service.findBoardByNo(boardNo);
		
		model.addObject("board", board);
		model.setViewName("board/update");
		
		return model;
	}
	
	@RequestMapping(value="/update", method={RequestMethod.POST})
	public ModelAndView update(@SessionAttribute(name="loginMember", required=false) Member loginMember, Board board, ModelAndView model) {
		int result = 0;
		
		System.out.println(loginMember.getUser_id());
		System.out.println(board.getUserId());
		
		if(loginMember.getUser_id().equals(board.getUserId())) {
			result = service.saveBoard(board);
			
			if(result > 0) {
				model.addObject("msg", "게시글이 정상적으로 수정되었습니다.");
				model.addObject("location", "/board/board");
			} else {
				model.addObject("msg", "게시글 수정에 실패하였습니다.");
				model.addObject("location", "/board/board");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/board/board");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
}





















