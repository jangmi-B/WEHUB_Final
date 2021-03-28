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
import com.kh.wehub.board.model.vo.Reply;
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
					
		
		Reply reply = new Reply();
		List<Reply> list2 = null;		
		
		list2 = service.getBoardReplyList(reply);	
		
		model.addObject("list", list);
		model.addObject("list2", list2);
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
	
			if(result > 0) {
				model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
				model.addObject("location", "/board/board");
			} else {	
				model.addObject("msg", "게시글 등록에 실패하였습니다.");
				model.addObject("location", "/");
			}
			
		} else {	
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
	
	@RequestMapping("/delete")
	public ModelAndView deleteBoard(ModelAndView model, @SessionAttribute(name="loginMember", required=false) Member loginMember, @RequestParam("boardNo") int boardNo) {
		Board board = service.findBoardByNo(boardNo);
		int result = 0;

		if(loginMember.getUser_id().equals(board.getUserId())) {
			result = service.deleteBoard(boardNo);
			
			if(result > 0) {
				model.addObject("msg", "정상적으로 게시글이 삭제되었습니다.");
				model.addObject("location", "/board/board");
			} else {
				model.addObject("msg", "잠시 후 다시 시도해주세요.");
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





















