package com.kh.wehub.community.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.google.gson.JsonObject;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.community.model.dao.CommunityDao;
import com.kh.wehub.community.model.service.CommunityService;
import com.kh.wehub.community.model.vo.Community;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.service.MessageService;
import com.kh.wehub.message.model.vo.Message;

@Controller
@SessionAttributes("loginMember")
public class CommunityController {
	
	@Autowired
	private CommunityService service;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private CommunityDao dao;
	
	@Autowired MessageService MsgService;

	@RequestMapping(value="community/list", method= {RequestMethod.GET})
	public ModelAndView communityList(@SessionAttribute("loginMember") Member loginMember,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit,
			ModelAndView model, @RequestParam(value = "CM_searchText", required = false) String CM_searchText) {
		
		int communityCount = service.getCommunityCount(CM_searchText);
		
		PageInfo pageInfo = new PageInfo(page, 10, communityCount, listLimit);
		
		List<Community> list = service.selectList(pageInfo, CM_searchText, loginMember.getUser_no());
		
		//쪽지 리스트 가져오기
		List<Message> receiveList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgTo", loginMember.getUser_no());
		
		receiveList = messageService.getHomeReceiveList(loginMember.getUser_no());
		
		if(CM_searchText != null) {
			model.addObject("CM_searchText",CM_searchText);
		}
		
		System.out.println(list);
		
		model.addObject("list", list);
		model.addObject("pageInfo", pageInfo);
		model.addObject("receiveList",receiveList);
		model.setViewName("/community/community_list");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="community/view", method= {RequestMethod.GET})
	public HashMap<Object, Object> View(@RequestParam("no") int no, ModelAndView model,
			HttpServletRequest req, HttpServletResponse resp, @SessionAttribute("loginMember") Member loginMember) {
		
				//조회수 로직
				Cookie[] cookies = req.getCookies();
				String boardHistory = "";
				boolean hasRead = false;
				
				if(cookies != null) {
					String name = null;
					String value = null;
					
					for(Cookie cookie : cookies) {
						name = cookie.getName();
						value = cookie.getValue();
						
						//boardHistory인 쿠키값을 찾기
						if("boardHistory".equals(name)) {
							boardHistory = value;//현재저장된 값 대입
							if(value.contains("|" + no + "|")) {
								//읽은 게시글
								hasRead = true;
								 
								break;
							}
						}
					}
				}
			if(!hasRead) {
				Cookie cookie = new Cookie("boardHistory", boardHistory + "|" + no + "|");
				
				cookie.setMaxAge(-1);
				resp.addCookie(cookie);
			}
		
		Community view = service.selectView(no, loginMember.getUser_no());
		
		if(!hasRead) {
			// DB저장로직 작성하기
			
			int CommunityReadCount = view.getCm_readCount() + 1;
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("no", no);
			map.put("CommunityReadCount", CommunityReadCount);
			
			view.setCm_readCount(service.updateReadCount(map));
			
		}
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("view", view);
		map.put("loginMember", loginMember);
		
		return map;
		
	}
	
	@RequestMapping(value="community/writeView", method= {RequestMethod.GET})
	@ResponseBody
	public Member loginMember(@SessionAttribute("loginMember") Member member) {
		
		return member;
	}
	
	@RequestMapping(value="community/write", method= {RequestMethod.POST})
	@ResponseBody
	public String write(@SessionAttribute("loginMember") Member member, 
			@RequestParam("title") String title, @RequestParam("text") String text) {
		
		int result = 0;
		
		result = service.insert(title, text, member.getUser_no());
		
		return null;
	}
	
	@RequestMapping(value="community/update", method= {RequestMethod.POST})
	@ResponseBody
	public String update(@SessionAttribute("loginMember") Member member,
			@RequestParam("title") String title, @RequestParam("text") String text,
			@RequestParam("no") int no) {
		
		int result = 0;
		
		result = service.update(title, text, no);
		
		return "/community/community_list";
	}
	
	@RequestMapping(value="community/updateView", method= {RequestMethod.GET})
	@ResponseBody
	public HashMap<Object, Object> updateView(@SessionAttribute("loginMember") Member member,
			@RequestParam(value="no") int no) {
		
		Community view = service.updateView(no, member.getUser_no());
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("view", view);
		map.put("member", member);
		
		return map;
	}
	
	@RequestMapping(value="community/delete", method= {RequestMethod.POST})
	@ResponseBody
	public String update(@SessionAttribute("loginMember") Member member,
			@RequestParam("no") int no) {
		
		int result = 0;
		
		result = service.delete(no);
		
		return "/community/community_list";
	}
	
	@RequestMapping(value="community/myList", method= {RequestMethod.GET})
	public ModelAndView MyList(@SessionAttribute("loginMember") Member loginMember,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit,
			ModelAndView model) {
		
		int communityCount = service.getCommunityCount_MyPage(loginMember.getUser_no());
		
		PageInfo pageInfo = new PageInfo(page, 10, communityCount, listLimit);
		
		List<Community> list = service.selectMyList(pageInfo, loginMember);
		
		
		model.addObject("list", list);
		model.addObject("pageInfo", pageInfo);
		model.setViewName("/community/community_myList");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/community/Msgsend", method = {RequestMethod.POST})
	public void noticeWrite(
			@SessionAttribute(name="loginMember", required=false) Member loginMember, 
			Message Message) { 
		
		int result = 0;
		
		result = MsgService.sendMsg(Message);

		if(result > 0) {
			System.out.println("전송완료");
		} else {
			System.out.println("전송실패");
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="/community/bookmark", method= {RequestMethod.POST})
	public void CM_bookMark(@RequestParam("no") int no, @RequestParam("userNo") int userNo) {
		
		int result = 0;
		
		System.out.println(userNo);
		
		result = service.insertMark(no, userNo);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/community/deleteMark", method= {RequestMethod.POST})
	public void CM_deleteMark(@RequestParam("no") int no, @RequestParam("userNo") int userNo) {
		
		int result = 0;
		
		System.out.println(userNo);
		
		result = service.deleteMark(no, userNo);
		
	}
	
	@RequestMapping(value="community/favList", method= {RequestMethod.GET})
	public ModelAndView favList(@SessionAttribute("loginMember") Member loginMember,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "10") int listLimit,
			ModelAndView model) {
		
		int communityFavCount = service.getCommunityCount_favPage();
		
		PageInfo pageInfo = new PageInfo(page, 10, communityFavCount, listLimit);
		
		List<Community> list = service.selectFavList(pageInfo, loginMember.getUser_no());
		
		model.addObject("list", list);
		model.addObject("pageInfo", pageInfo);
		model.setViewName("/community/community_favList");
		
		return model;
	}
	
	
	
	@RequestMapping(value="community/upload", method= {RequestMethod.POST})
	public String upload(@RequestParam MultipartFile upload, HttpServletRequest request, HttpServletResponse response) 
					throws Exception{
		
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/community/";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
//		System.out.println(upload.getOriginalFilename());
		// 한글깨짐을 방지하기위해 문자셋 설정
        response.setCharacterEncoding("utf-8");
 
        // 마찬가지로 파라미터로 전달되는 response 객체의 한글 설정
        response.setContentType("text/html; charset=utf-8");
 
//        System.out.println(UUID.randomUUID().toString()+loginMember.getUser_id());
        
        String originalFileName = upload.getOriginalFilename();
		String renameFileName = 
					LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + 
					originalFileName.substring(originalFileName.lastIndexOf("."));
		
		System.out.println(renameFileName);
        // 업로드한 파일 이름
        String fileName = renameFileName;
 
        // 파일을 바이트 배열로 변환
        byte[] bytes = upload.getBytes();
 
        // 이미지를 업로드할 디렉토리(배포 디렉토리로 설정)
        String uploadPath = savePath;
		
        OutputStream out = new FileOutputStream(new File(uploadPath + fileName));
        
        // 서버로 업로드
        // write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다.
        // 지정된 바이트를 출력 스트립에 쓴다 (출력하기 위해서)
        out.write(bytes);
 
        // 서버=>클라이언트로 텍스트 전송(자바스크립트 실행)
        PrintWriter printWriter = response.getWriter();
        
        String fileUrl = request.getContextPath() + "/resources/upload/community/" + fileName;
        
        JsonObject json = new JsonObject();
        
        json.addProperty("uploaded", 1);
        json.addProperty("fileName", fileName);
        json.addProperty("url", fileUrl);
        
        printWriter.println(json);
        
        printWriter.flush();	
        printWriter.close();
		
        return null;
	}

}
