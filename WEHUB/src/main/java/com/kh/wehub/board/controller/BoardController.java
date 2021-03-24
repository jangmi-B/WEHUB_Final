package com.kh.wehub.board.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.board.model.service.BoardService;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@RequestMapping(value = "/notice/list", method = {RequestMethod.GET})
	public ModelAndView noticeList(
			ModelAndView model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember){
		
		List<Notice> list = null;
		int noticeCount = service.getBoardCount();
		PageInfo pageInfo = new PageInfo(page, 10, noticeCount, listLimit);
		
//		System.out.println(noticeCount);
		
		list = service.getNoticeList(pageInfo);
		
		model.addObject("list", list);
		model.addObject("pageInfo", pageInfo);
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
		
		System.out.println(upfile.getOriginalFilename());
		System.out.println(notice);
		System.out.println(loginMember);
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(notice.getUserId())) {
			notice.setNoticeWriterNo(loginMember.getUser_no());
			
			System.out.println(loginMember.getUser_no());
			
			if(upfile != null && !upfile.isEmpty()) {
				// 파일을 저장하는 로직 작성
				String renameFileName = saveFile(upfile, request);
				
				System.out.println(renameFileName);
				
				if(renameFileName != null) {
					notice.setNoticeOriginalFileName(upfile.getOriginalFilename());
					notice.setNoticeRenamedFileName(renameFileName);
				}
			}
			
			result = service.saveBoard(notice);
			
			if(result > 0) {
				model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
				model.addObject("location", "/notice/list");
			} else {
				model.addObject("msg", "게시글 등록에 실패하였습니다.");
				model.addObject("location", "/notice/list");
			}
			
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
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
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(notice.getUserId())) {
			if(reloadFile != null && !reloadFile.isEmpty()) {
				if(notice.getNoticeRenamedFileName() != null) {
					//기존에 저장된 파일 삭제
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
				model.addObject("msg", "공지사항 수정을 완료하였습니다.");
				model.addObject("location", "/notice/view?noticeNo="+notice.getNoticeNo());
			} else {
				model.addObject("msg", "공지사항 수정에 실패하였습니다.");
				model.addObject("location", "/notice/view?noticeNo="+notice.getNoticeNo());
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/notice/list");
		}
		
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
				model.addObject("msg", "공지사항 삭제를 완료하였습니다.");
				model.addObject("location", "/notice/list");
			} else {
				model.addObject("msg", "공지사항 삭제에 실패하였습니다.");
				model.addObject("location", "/notice/view?noticeNo="+ noticeNo);
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
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
		
		//SavePath가 실제로 존재하지 않으면 폴더를 생성하는 로직
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		originalFileName = file.getOriginalFilename();
		renameFileName = 
				LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + 
				originalFileName.substring(originalFileName.lastIndexOf(".")); //확장자가 없는 파일 확인하려면 삼항연산자로 -1인지 아닌지로 체크가능하다.
		renamePath = savePath + "/" + renameFileName;
		
		try {
			//업로드한 파일 데이터를 지정한 파일에 저장한다.
			file.transferTo(new File(renamePath));
		} catch (IOException e) {
			System.out.println("파일 전송에러 : " + e.getMessage());
			e.printStackTrace();
		}
		
		return renameFileName;
	}
	
	@RequestMapping(value = "notice/view", method = {RequestMethod.GET})
	public ModelAndView view(@RequestParam("noticeNo") int noticeNo, ModelAndView model) {
		
		Notice notice = service.findNoticeByNo(noticeNo);
		
		model.addObject("notice", notice);
		model.setViewName("/board/board_notice_detail");
		
		return model;
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
