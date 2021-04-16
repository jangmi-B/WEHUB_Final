package com.kh.wehub.member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memberInfo.model.vo.InsertNewMember;
import com.kh.wehub.memo.model.service.MemoService;
import com.kh.wehub.memo.model.vo.Memo;
import com.kh.wehub.message.model.service.MessageService;
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.project.model.service.ProjectService;
import com.kh.wehub.project.model.vo.Project;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private MemoService memoService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private ProjectService projectService;
	
	@RequestMapping(value="/login", method={RequestMethod.POST})
	public ModelAndView login(ModelAndView model, @RequestParam("userId") String userId, 
												  @RequestParam("userPwd") String userPwd) {
		
		Member loginMember = null;
		
		loginMember = service.login(userId, userPwd);
		
		if(loginMember != null) {
			model.addObject("loginMember" , loginMember);
			model.setViewName("redirect:/main");
		}else {
			model.addObject("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			model.addObject("location", "/");
			model.setViewName("common/msg");
		}
		return model;
	}
	
	//메인 화면 띄우기
	@RequestMapping(value = "/main")
	public ModelAndView home(ModelAndView model,
			@SessionAttribute("loginMember")Member loginMember) {
		
		// project리스트 가져오기
		List<Project> projectList = null;
		
		projectList = projectService.homeProjectList(loginMember.getUser_no());
		
		for(int i = 0; i < projectList.size(); i++) {
			String[] arr = projectList.get(i).getParticipant().split("/ ");
			
			projectList.get(i).setProjectCount(arr.length);
		}

		
		//쪽지 리스트 가져오기
		List<Message> receiveList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgTo", loginMember.getUser_no());
		
		receiveList = messageService.getHomeReceiveList(loginMember.getUser_no());
		
		
		//쪽지 아이콘 색 변하게 하는 코드
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
		
		
		// memo리스트 가져오기
		String[] array = null;
		String content = null;
		List<String> memoContent = new ArrayList<>();
		List<Memo> memoList = memoService.getMemoList(loginMember.getUser_no());
		
		if(!memoList.isEmpty()) {
			content = memoList.get(0).getMemoContent();
			
			array = content.split("_");
			
			for(int i=0; i<array.length; i++) {
				memoContent.add(array[i]);
			}
		} 
		
		model.addObject("projectList",projectList);
		model.addObject("receiveList",receiveList);
		model.addObject("unreadCheck",unreadCheck);
		model.addObject("memoContent",memoContent);
		model.addObject("loginMember",loginMember);
		model.setViewName("/main");
		
		return model;
	}
	
	// 회원가입
		@RequestMapping("member/BeforeSignUp")
		public String BeforeSignUp() {
			log.info("회원가입 동의 페이지 요청");
			
			return "member/BeforeSignUp";
		}
		
		@RequestMapping("member/signUpForm")
		public String enrollView() {
			log.info("회원가입 작성 페이지 요청");
			
			return "member/signUpForm";
		}
		
		@RequestMapping(value = "/member/signUpForm", method = {RequestMethod.GET})
		public void enrollViewUpfile() {
			log.info("회원가입 작성 페이지 요청");
			
//			return "member/signUpForm";
		}
		
		@RequestMapping(value = "/member/signUpForm", method = {RequestMethod.POST})
		public ModelAndView signUpForm(
				@SessionAttribute(name = "loginMember", required = false) Member loginMember, 
				HttpServletRequest request,@ModelAttribute Member member, ModelAndView model,
				@RequestParam("user_img") MultipartFile upfile) {

			log.info(member.toString());
			
			System.out.println(upfile.getOriginalFilename());
			
			System.out.println("회원가입 멤버확인 "+member);
			
			if(upfile != null && !upfile.isEmpty()) {
				String renameFileName = saveFile(upfile, request);
				
				System.out.println(renameFileName);
				
				if(renameFileName != null) {
					member.setUser_imgOriname(upfile.getOriginalFilename());
					member.setUser_imgRename(renameFileName);
					
					System.out.println(", imgOriname : " + member.getUser_imgOriname() + " / imgRename : " + member.getUser_imgRename());
				}
			}
			
			int result = service.saveMember(member);
			
			log.info(member.toString());
			
			model.setViewName("member/signUpForm");
			
			if(result > 0) {
				model.addObject("msg", "회원가입이 정상적으로 되었습니다.");
				model.addObject("location", "/"); // 로그인창으로 이동시키는 로케이션
			} else {
				model.addObject("msg", "회원가입을 실패하였습니다. 올바른 정보를 입력하여 주세요.");
				model.addObject("location", "/member/signUpForm");
			}
			
			model.setViewName("common/msg");
			
			return model;
		}
		
		// 아이디 체크
		@RequestMapping("member/idCheck")
		@ResponseBody
		public Object idCheck(@RequestParam("user_id")String user_id) {
			
			log.info("컨트롤러에 찍히나..User_id : {}", user_id);
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("validate", service.validate(user_id));
			
			System.out.println(map);
			
			return map;
		}
		
		// 회원가입할 때 사번으로 임시회원을 조회해오는 코드입니다
		@RequestMapping("member/findNewMem")
		@ResponseBody
		public Object findNewMem(@RequestParam("value")String userNo) {
			
			InsertNewMember member = service.getNewMember(userNo);
			
			Map<String, Object> map = new HashMap<>();
			
			if(member != null) {
				map.put("member", member);
			} else {
				map.put("member", 0);
			}
			return map;
			
		}
		
		private String saveFile(MultipartFile file, HttpServletRequest request) {
			String renamePath = null; 
			String originalFileName = null;
			String renameFileName = null;
			String rootPath = request.getSession().getServletContext().getRealPath("resources");
			String savePath = rootPath + "/upload/userProfileImg";				
			
			log.info("Root Path : " + rootPath);
			log.info("Save Path : " + savePath);
			
			File folder = new File(savePath); // Save Path가 실제로 존재하지 않으면 폴더를 생성하는 로직
			
			if(!folder.exists()) {
				folder.mkdirs();
			}
			
			originalFileName = file.getOriginalFilename();
			renameFileName = 
					LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + 
					originalFileName.substring(originalFileName.lastIndexOf("."));
			renamePath = savePath + "/" + renameFileName;
			
			try {
				file.transferTo(new File(renamePath)); // 업로드 한 파일 데이터를 지정한 파일에 저장한다.
			}catch (IOException e) {
				System.out.println("파일 전송 에러 : " + e.getMessage());
				e.printStackTrace();
			}
			
			return renameFileName;
		}
		
		private void deleteImgFile(String fileName, HttpServletRequest request) {
			String rootPath = request.getSession().getServletContext().getRealPath("resources");
			String savePath = rootPath + "/upload/userProfileImg";				
			
			log.info("Root Path : " + rootPath);
			log.info("Save Path : " + savePath);
			
			File file =  new File(savePath + "/" + fileName);
			
			if(file.exists()) {
				file.delete();
			}	
		}
	
}
