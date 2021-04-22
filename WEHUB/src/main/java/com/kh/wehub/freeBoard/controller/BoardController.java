package com.kh.wehub.freeBoard.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.freeBoard.model.service.BoardService;
import com.kh.wehub.freeBoard.model.vo.Board;
import com.kh.wehub.freeBoard.model.vo.Reply;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;

@Controller
@RequestMapping("/freeBoard")
@SessionAttributes("loginMember")
public class BoardController {
	@Autowired
	private BoardService service;
	
	@Autowired
	private MemberService service2;

	@RequestMapping(value = "/board", method = { RequestMethod.GET })
	public ModelAndView listView(@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			ModelAndView model, @RequestParam(value="keyword", required=false) String keyword) {
		
		List<Board> list = null;
		
		
		if(keyword != null) { 
			list = service.selectBoardDetail(keyword);
			
			if(list.isEmpty()) {
				model.addObject("msg", "조회된 게시물이 없습니다.");
				model.addObject("location", "/freeBoard/board");
				model.setViewName("common/msg");

				return model;
			}
			
		} else {
			list = service.selectBoardDetail();
		}
		
		System.out.println("@RequestParam(\"keyword\") String keyword" + keyword);
			
		System.out.println("list : " + list);

		model.addObject("list", list);
		model.setViewName("freeBoard/board");
		
		
		return model;
	}

	@RequestMapping(value = "/boardWrite", method = { RequestMethod.GET })
	public String writeView(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "freeBoard/boardWrite";
	}

	@RequestMapping(value = "/boardWrite", method = { RequestMethod.POST })
	public ModelAndView boardWrite(@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Board board, ModelAndView model) {
		int result = 0;

		if (loginMember.getUser_id().equals(board.getUserId())) {
			board.setBoardWriterNo(loginMember.getUser_no());

			result = service.saveBoard(board);

			if (result > 0) {
				model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
				model.addObject("location", "/freeBoard/board");
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

	@RequestMapping(value = "/update", method = { RequestMethod.GET })
	public ModelAndView updateView(@RequestParam("boardNo") int boardNo, ModelAndView model) {
		Board board = service.findBoardByNo(boardNo);

		model.addObject("board", board);
		model.setViewName("freeBoard/update");

		return model;
	}

	@RequestMapping(value = "/update", method = { RequestMethod.POST })
	public ModelAndView update(@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Board board, ModelAndView model) {
		int result = 0;

		if (loginMember.getUser_id().equals(board.getUserId())) {
			result = service.saveBoard(board);

			if (result > 0) {
				model.addObject("msg", "게시글이 정상적으로 수정되었습니다.");
				model.addObject("location", "/freeBoard/board");
			} else {
				model.addObject("msg", "게시글 수정에 실패하였습니다.");
				model.addObject("location", "/freeBoard/board");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/freeBoard/board");
		}

		model.setViewName("common/msg");

		return model;
	}

	@RequestMapping("/delete")
	public ModelAndView deleteBoard(ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			@RequestParam("boardNo") int boardNo) {
		Board board = service.findBoardByNo(boardNo);
		int result = 0;

		if (loginMember.getUser_id().equals(board.getUserId())) {
			result = service.deleteBoard(boardNo);

			if (result > 0) {
				model.addObject("msg", "정상적으로 게시글이 삭제되었습니다.");
				model.addObject("location", "/freeBoard/board");
			} else {
				model.addObject("msg", "잠시 후 다시 시도해주세요.");
				model.addObject("location", "/freeBoard/board");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/freeBoard/board");
		}

		model.setViewName("common/msg");

		return model;
	}
	
	@RequestMapping(value="/replyWrite", method={RequestMethod.GET}) 
	public ModelAndView replyWrite(@SessionAttribute(name="loginMember", required=false) Member loginMember,
				Board board, @RequestParam("boardNo") int boardNo, @RequestParam("replyContent") String replyContent,
					Reply reply, ModelAndView model, Member member) { 	
		
		member = service2.findMemberByUserIdForFreeBoard(loginMember.getUser_id());

		int result = 0;
		
		System.out.println(replyContent);
			
//		System.out.println("@RequestParam : " + boardNo);
//		System.out.println("@RequestParam replyContent : " + replyContent);
		
		if(loginMember.getUser_id().equals(member.getUser_id())) {
			/* reply.setBoardNo(board.getBoardNo()); */
			
			result = service.saveReply(boardNo, replyContent, loginMember.getUser_no());
     
//			System.out.println("result : " + result);
		 
			if(result > 0) { 
				model.addObject("msg", "댓글이 정상적으로 등록되었습니다.");
				model.addObject("location", "/freeBoard/board"); 
			} else { 
				model.addObject("msg", "댓글 등록에 실패하였습니다."); 
				model.addObject("location", "/freeBoard/board"); 
			}
   
		} else { 
//			System.out.println("loginMember.getUser_id() : " + loginMember.getUser_id());
//			System.out.println("board.getUserId() : " + board.getUserId());
	    	model.addObject("msg", "잘못된 접근입니다.");
	    	model.addObject("location", "/freeBoard/board"); 
		}
	
		model.setViewName("common/msg");
	
		return model; 
	}
	
	@RequestMapping(value = "/updateReply", method = { RequestMethod.GET })
	public ModelAndView updateReply(@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			Reply reply, ModelAndView model, Member member, @RequestParam("newReplyContent") String replyContent,
			@RequestParam("replyNo") int replyNo) {
		
		member = service2.findMemberByUserIdForFreeBoard(loginMember.getUser_id());
		
		int result = 0;
		
		System.out.println("@RequestParam(\"replyContent\") : " + replyContent);
		System.out.println("@RequestParam(\"replyNo\") : " + replyNo);

		if (loginMember.getUser_id().equals(member.getUser_id())) {
			result = service.updateReply(replyContent, replyNo);

			if (result > 0) {
				model.addObject("msg", "댓글이 정상적으로 수정되었습니다.");
				model.addObject("location", "/freeBoard/board");
			} else {
				model.addObject("msg", "댓글 수정에 실패하였습니다.");
				model.addObject("location", "/freeBoard/board");
			}
		} else {
			System.out.println(loginMember.getUser_id());
			System.out.println(member.getUser_id());
			
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/freeBoard/board");
		}

		model.setViewName("common/msg");

		return model;
	}
	
	@RequestMapping("/deleteReply")
	public ModelAndView deleteReply(ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			@RequestParam("replyNo") int replyNo, Member member) {
		
		Reply reply = service.findReplyByNo(replyNo);
		
		System.out.println(reply);
		
		member = service2.findMemberByUserIdForFreeBoard(loginMember.getUser_id());
		
		int result = 0;

		if (loginMember.getUser_id().equals(member.getUser_id())) {
			result = service.deleteReply(replyNo);

			if (result > 0) {
				model.addObject("msg", "정상적으로 댓글이 삭제되었습니다.");
				model.addObject("location", "/freeBoard/board");
			} else {
				model.addObject("msg", "정상적으로 댓글이 삭제되지 않았습니다. 다시 시도해주세요.");
				model.addObject("location", "/freeBoard/board");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/freeBoard/board");
		}

		model.setViewName("common/msg");

		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/infiniteScrollDown", method=RequestMethod.POST)
	public List<Board> infiniteScrollDown(@RequestParam("rownumdata") int rownumdata) {
		
		
		List<Board> list = null;
		
		int bnoToStart = rownumdata + 3;
		
		System.out.println("bnoToStart : " + bnoToStart);
		
		list = service.infiniteScrollDown(bnoToStart);
		
		System.out.println(list);
		
		return list;
	}
}
