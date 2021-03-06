package com.kh.wehub.board.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.board.model.service.BoardService;
import com.kh.wehub.board.model.vo.Comments;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@Autowired
	private MessageService messageService;
	
	@RequestMapping(value = "/notice/list", method = {RequestMethod.GET})
	public ModelAndView noticeList(
			ModelAndView model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit,
			@RequestParam(value = "notice_search", required=false)String searchText,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember){
		
		List<Notice> list = null;
		List<Notice> staticList = null; //??????
		
		//?????? ????????? ??? ????????? ?????? ??????
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());

		int noticeCount = service.getBoardCount(searchText);
		
		PageInfo pageInfo = new PageInfo(page, 10, noticeCount, listLimit);
		
		list = service.getNoticeList(pageInfo,searchText);
		staticList = service.getStaticList();
		
		if(searchText != null) {
			model.addObject("notice_search",searchText);
		}
		
		for(int i = 0; i < list.size(); i++) {
			int count = service.getCommentsCount(list.get(i).getNoticeNo());
			
			list.get(i).setNoticCommentCount(count);
		}
		
		model.addObject("list", list);
		model.addObject("staticList", staticList);
		model.addObject("pageInfo", pageInfo);
		model.addObject("unreadCheck",unreadCheck);
		
		model.setViewName("/board/board_notice_list");
		
		return model;
		
	}
	
	@RequestMapping(value = "notice/write", method = {RequestMethod.GET})
	public String noticeWriteView(@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		System.out.println(loginMember);
		
		return "/board/board_notice_write"; 
	}
	
	@RequestMapping(value = "notice/write", method = {RequestMethod.POST})
	public ModelAndView noticeWrite(
			@SessionAttribute(name="loginMember", required=false) Member loginMember, 
			HttpServletRequest request, Notice notice, @RequestParam("upfile") MultipartFile upfile, ModelAndView model) {
		
		
		if(notice.getNoticeType() == null) {
			notice.setNoticeType("N");
		} else {
			notice.setNoticeType("Y");
		}
		
		//?????? ????????? ??? ????????? ?????? ??????
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(notice.getUserId())) {
			notice.setNoticeWriterNo(loginMember.getUser_no());
			
//			System.out.println(loginMember.getUser_no());
			
			if(upfile != null && !upfile.isEmpty()) {
				// ????????? ???????????? ?????? ??????
				String renameFileName = saveFile(upfile, request);
				
				System.out.println(renameFileName);
				
				if(renameFileName != null) {
					notice.setNoticeOriginalFileName(upfile.getOriginalFilename());
					notice.setNoticeRenamedFileName(renameFileName);
				}
			}
			
			result = service.saveBoard(notice);
			
//			System.out.println(result);
			
			if(result > 0) {
				model.addObject("msg", "???????????? ??????????????? ?????????????????????.");
				model.addObject("location", "/notice/list");
				model.addObject("unreadCheck",unreadCheck);
			} else {
				model.addObject("msg", "????????? ????????? ?????????????????????.");
				model.addObject("location", "/notice/list");
				model.addObject("unreadCheck",unreadCheck);
			}
			
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/home");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	@RequestMapping(value = "notice/update", method = {RequestMethod.GET})
	public ModelAndView updateView(@RequestParam("noticeNo") int noticeNo, ModelAndView model) {
		Notice notice = service.findNoticeByNo(noticeNo);
		
		System.out.println(notice);
		
		model.addObject("notice", notice);
		model.setViewName("board/board_notice_update");
		
		return model;
	}
	
	@RequestMapping(value = "notice/update", method= {RequestMethod.POST})
	public ModelAndView noticeUpdate(
			@SessionAttribute(name = "loginMember", required = false)Member loginMember,
			@RequestParam("reloadFile") MultipartFile reloadFile, HttpServletRequest request,
			Notice notice, ModelAndView model){
		
		//?????? ????????? ??? ????????? ?????? ??????
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
		
		if(notice.getNoticeType() == null) {
			notice.setNoticeType("N");
		} else {
			notice.setNoticeType("Y");
		}
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(notice.getUserId())) {
			if(reloadFile != null && !reloadFile.isEmpty()) {
				if(notice.getNoticeRenamedFileName() != null) {
					//????????? ????????? ?????? ??????
					deleteFile(notice.getNoticeRenamedFileName(), request);
				}
				
				String renameFileName = saveFile(reloadFile, request);
				
				if(renameFileName != null) {
					notice.setNoticeOriginalFileName(reloadFile.getOriginalFilename());
					notice.setNoticeRenamedFileName(renameFileName);
				}
			}
			
			result = service.saveBoard(notice);
			
			if(result > 0 ) {
				model.addObject("msg", "???????????? ????????? ?????????????????????.");
				model.addObject("location", "/notice/view?noticeNo="+notice.getNoticeNo());
			} else {
				model.addObject("msg", "???????????? ????????? ?????????????????????.");
				model.addObject("location", "/notice/view?noticeNo="+notice.getNoticeNo());
			}
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/notice/list");
		}
		
		model.addObject("unreadCheck",unreadCheck);
		model.setViewName("common/msg");
		
		return model;
	}
	
	@RequestMapping(value ="notice/delete", method= {RequestMethod.GET})
	public ModelAndView noticeDelete(
			@SessionAttribute(name = "loginMember", required = false)Member loginMember,
			@RequestParam("noticeNo") int noticeNo, ModelAndView model){
		
		Notice notice = service.findNoticeByNo(noticeNo);
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(notice.getUserId())) {
			
			result = service.deleteNotice(notice);
			
			if(result > 0 ) {
				model.addObject("msg", "???????????? ????????? ?????????????????????.");
				model.addObject("location", "/notice/list");
			} else {
				model.addObject("msg", "???????????? ????????? ?????????????????????.");
				model.addObject("location", "/notice/view?noticeNo="+ noticeNo);
			}
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/notice/list");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	
	private void deleteFile(String fileName, HttpServletRequest request) {
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/notice";
		
		log.info("Root Path : " + rootPath);
		log.info("Save Path : " + savePath);
		
		File file = new File(savePath + "/" + fileName);
		
		if(file.exists()) {
			file.delete();
		}
	}
	
	
	private String saveFile(MultipartFile file, HttpServletRequest request) {
		String renamePath = null; 
		String originalFileName = null; 
		String renameFileName = null;
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/notice";
		
		log.info("Root Path : " + rootPath);
		log.info("Save Path : " + savePath);
		
		//SavePath??? ????????? ???????????? ????????? ????????? ???????????? ??????
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		originalFileName = file.getOriginalFilename();
		renameFileName = 
				LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + 
				originalFileName.substring(originalFileName.lastIndexOf(".")); //???????????? ?????? ?????? ??????????????? ?????????????????? -1?????? ???????????? ??????????????????.
		renamePath = savePath + "/" + renameFileName;
		
		try {
			//???????????? ?????? ???????????? ????????? ????????? ????????????.
			file.transferTo(new File(renamePath));
		} catch (IOException e) {
			System.out.println("?????? ???????????? : " + e.getMessage());
			e.printStackTrace();
		}
		
		return renameFileName;
	}
	
	// ????????? ????????????
	@RequestMapping(value = "notice/view", method = {RequestMethod.GET})
	public ModelAndView view(@RequestParam("noticeNo") int noticeNo, ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false)Member loginMember,
			HttpServletResponse response, HttpServletRequest request) {
		
		//????????? ??????
		Cookie[] cookies = request.getCookies();
		String boardHistory = "";
		boolean hasRead = false;
		
		if(cookies != null) {
			String name = null;
			String value = null;
			
			for(Cookie cookie : cookies) {
				name = cookie.getName();
				value = cookie.getValue();
				
				//boardHistory??? ???????????? ??????
				if("boardHistory".equals(name)) {
					boardHistory = value;//??????????????? ??? ??????
					if(value.contains("|" + noticeNo + "|")) {
						//?????? ?????????
						hasRead = true;
						 
						break;
					}
				}
			}
		}
		
		if(!hasRead) {
			Cookie cookie = new Cookie("boardHistory", boardHistory + "|" + noticeNo + "|");
			
			cookie.setMaxAge(-1);
			response.addCookie(cookie);
		}
		
		Notice notice = service.findNoticeByNo(noticeNo);
//		System.out.println("???" + notice);
		
		//?????? ????????? ??? ????????? ?????? ??????
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
		
		if(!hasRead) {
			// DB???????????? ????????????
			
			int noticeReadCount = notice.getNoticeReadCount() + 1;
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("noticeNo", noticeNo);
			map.put("noticeReadCount", noticeReadCount);
			
			notice.setNoticeReadCount(service.updateReadCount(map));
			
		}
		
		notice = service.findNoticeByNo(noticeNo);
//		System.out.println("???" + notice);
		
		int count = service.getCommentsCount(noticeNo);
		notice.setNoticCommentCount(count);
		
		System.out.println("notice????????? ?????? : " + notice);
		
		//?????? ????????? ?????? ?????? ????????????
		List<Comments> comments = service.findComments(noticeNo);
		
		for(int i = 0; i < comments.size(); i++) {
			List<Member> name = service.findCommentName(noticeNo);
			
			comments.get(i).setUserName(name.get(i).getUser_name());
			comments.get(i).setUser_imgRename(name.get(i).getUser_imgRename());
			System.out.println("name : " + name);
			System.out.println(name.get(i).getUser_imgRename());
		}
		System.out.println(comments);
		
		model.addObject("unreadCheck", unreadCheck);
		model.addObject("loginMember", loginMember);
		model.addObject("comments", comments);
		model.addObject("notice", notice);
		model.setViewName("/board/board_notice_detail");
		
		return model;
	}
	
	@RequestMapping(value="notice/comments", method = {RequestMethod.GET})
	public ModelAndView saveComment(ModelAndView model, @SessionAttribute("loginMember") Member member,
			Comments comment)
			{
		int result = 0;
		
		int noticeNo = comment.getCommentNoticeNO();
		
		result = service.saveComments(comment, member);
		
		System.out.println(comment);
		
		if(result > 0) {
			model.addObject("msg","??????????????????!");
			model.addObject("location", "/notice/view?noticeNo="+noticeNo);
		}else {
			model.addObject("msg","??????????????????!");
			model.addObject("location", "/notice/view?noticeNo="+noticeNo);
		}
		model.setViewName("/common/msg");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="notice/comments/update", method = {RequestMethod.POST}, produces = "application/String; charset=utf-8")
	public String updateComment(@RequestParam(value="comments") String comments, @RequestParam(value="commentsNo") int commentsNo) {
		
		int result = 0;
		
		String str = comments;
		result = service.updateComments(commentsNo, comments);
		
		if(result > 0) {
			System.out.println("????????????");
		}else {
			System.out.println("????????????");
		}
		
		return str;
	}
	
	@ResponseBody
	@RequestMapping(value="/notice/comments/delete", method= {RequestMethod.GET})
	public void deleteComment(@RequestParam(value="commentsNo") int commentsNo) {
		
		int result = 0;
		System.out.println(commentsNo);
		
		result = service.deleteComments(commentsNo);
		
		if(result > 0) {
			System.out.println("????????????");
		}else {
			System.out.println("????????????");
		}
	}
	
	
	
	@RequestMapping(value="notice/fileDown", method = { RequestMethod.GET })
	public ResponseEntity<Resource> fileDown(
		@RequestParam("oriname") String oriname, @RequestParam("rename") String rename,
		@RequestHeader(name="user-agent") String header) {
		
		try {
			Resource resource = resourceLoader.getResource("resources/upload/notice/" + rename);
			File file = resource.getFile();
			boolean isMSIE = header.indexOf("Trident")!=-1||header.indexOf("MSIE")!=-1;
			String encodeRename = "";
			
			if(isMSIE) {
				encodeRename = URLEncoder.encode(oriname, "UTF-8");
				encodeRename = encodeRename.replaceAll("\\+", "%20");
			}else {
				encodeRename = new String(oriname.getBytes("UTF-8"),"ISO-8859-1");
			}
			
			return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=\"" + encodeRename + "\"")
					.header(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()))
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM.toString())
					.body(resource);
		} catch (IOException e) {
			e.printStackTrace();
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

}
