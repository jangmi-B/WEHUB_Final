package com.kh.wehub.member.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.service.UserMailSendService;
import com.kh.wehub.member.model.vo.Member;



import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class MemberController {
		
	@Autowired
	private MemberService service;

	@RequestMapping(value="/loginn", method={RequestMethod.POST})
	public ModelAndView login(@SessionAttribute(name="loginMember", required=false)Member loginMember , 
												ModelAndView model, 
												@RequestParam(name="userId") String userId, 
												@RequestParam(name="userPwd") String userPwd) {
	
		loginMember = service.login(userId, userPwd);
		log.info("loginmember in mcontroller :"+ loginMember);
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
	@RequestMapping(value="main")
	public ModelAndView mainPage(ModelAndView model,
			@SessionAttribute("loginMember")Member loginMember) {
		
		model.addObject("loginMember", loginMember);
		model.setViewName("/main");
		
		return model;
	}
	
	@RequestMapping("/logout")
	public String logout(SessionStatus status) {
		
		// 세션 삭제함.
		log.info("status.isComplete() " +status.isComplete());
		status.setComplete();
		log.info("status.isComplete() " +status.isComplete());
		
		return "redirect:/";
	}
	
	@RequestMapping(value="member/findIDorPwd")
	public String findIdorPwd() {
		
		log.info("wanna go findIDorPwd");
		
		return "member/findIDorPwd";
	}
	
	@RequestMapping(value="member/findID")
	public String findID() {
		
		log.info("findID go!!");
		
		return "member/findID";
	}

	@RequestMapping(value="member/findID", method={RequestMethod.POST})
	public ModelAndView findID(ModelAndView model,@ModelAttribute Member member) {
		
		log.info("in controller email, user_id : "+member.getEmail()+" "+member.getPhone());
		String findID =service.findID(member);
		
		if(findID!=null) {
			model.addObject("userID" , findID);
			log.info("찾은 아이디");
			System.out.println("찾은 아이디는"+findID);
			model.addObject("msg", "찾은 아이디는 "+findID);
		}else {
			model.addObject("msg", "찾은 아이디는 존재하지 않습니다");
		}
			model.setViewName("common/msg");
		//	model.setViewName("redirect:/");
		
		return model;
	}
	
//	@RequestMapping(value="member/findPwd",method={RequestMethod.POST})
//	public ModelAndView findPWD(ModelAndView model,@ModelAttribute Member member) {
//		
//		String findPWD =service.findPWD(member);
//		if(findPWD!=null) {
//		//model.addObject("userPwd" , findPWD);
//		log.info("찾은 pwd");
//		model.addObject("msg","찾은 pwd는"+ findPWD);
//		}else {
//			model.addObject("msg", "찾은 비밀번호는 존재하지 않습니다");
//		}
//		model.setViewName("common/msg");
//		//model.setViewName("redirect:/");
//	return model;
//	}
	
	/* 비밀번호 찾기 */
	@RequestMapping(value="member/findPwd")
	public String findPWD() {
		log.info("findPwd go!!");
		
		return "member/findPwd";
	}

    @Autowired
    private UserMailSendService mailsender;

//    .@responseBody는 리턴 값을 http 몸체로 변환하는데 사용하는데 , Ajax 처리할 시 
//    @responseBody 어노테이션을 붙여줬음.

//
//	 @RequestMapping(value = "member/findPwd", method = RequestMethod.POST)
//	  
//	  @ResponseBody public String
//	  findPwd(@RequestParam(value="user_id",required=false)String user_id,
//			  @RequestParam(value="email" ,required = false)String email,
//			  									HttpServletRequest request )
//	 
//	 { 	log.info("wanna go findPwd");
//	 	log.info("in controller email, user_id : "+email+" "+user_id);
//	 	mailsender.mailSendWithPassword(user_id, email, request);
//	
//	  	return "member/findPwd"; }
    
	 @RequestMapping(value = "member/findPwd", method = RequestMethod.POST)
	 
	 @ResponseBody public String
	 findPwd(@RequestParam(value="user_id",required=false)String user_id,
			 @RequestParam(value="email" ,required = false)String email,
			 HttpServletRequest request )
	 
	 { 	
		 log.info("wanna go findPwd");
		 log.info("in controller email, user_id : "+email+" "+user_id);
	 mailsender.mailSendWithPassword(user_id, email, request);
	 
	 return "member/findPwd"; }
	 
    
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
		
//		return "member/signUpForm";
	}
	
	@RequestMapping(value = "/member/signUpForm", method = {RequestMethod.POST})
	public ModelAndView signUpForm(
			@SessionAttribute(name = "loginMember", required = false) Member loginMember, 
			HttpServletRequest request,@ModelAttribute Member member, ModelAndView model,
			@RequestParam("user_img") MultipartFile upfile) {

		log.info(member.toString());
		
		System.out.println(upfile.getOriginalFilename());
		
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
	
	// 회원 수정
	@RequestMapping(value="member/memModify", method = {RequestMethod.GET})
	public String memModify() {
		log.info("회원 수정 페이지 요청");
		
		return "member/memModify";
	}
	
	@RequestMapping(value="/member/update", method = {RequestMethod.POST})
	public ModelAndView update(@ModelAttribute Member member, ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			@RequestParam("user_img") MultipartFile reloadImgFile, HttpServletRequest request) {
		
		System.out.println();
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(member.getUser_id())) {
			member.setUser_no(loginMember.getUser_no());
			
			if(reloadImgFile != null && !reloadImgFile.isEmpty()) {
				if(member.getUser_imgRename() != null) {
					deleteImgFile(member.getUser_imgRename(), request);
				}
				
				String renameFileName = saveFile(reloadImgFile, request);
				
				if(renameFileName != null) {
					member.setUser_imgOriname(reloadImgFile.getOriginalFilename());
					member.setUser_imgRename(renameFileName);
				}
			}
			
			result = service.saveMember(member);
//			log.info("result 값 받아오나욘? " + result);
			
//			String memAdress = loginMember.getAddress();
//			System.out.println(memAdress);
//			String[] adressArr = memAdress.split(",");
//			System.out.println(adressArr[0]);
//			System.out.println(adressArr[1]);
			
			if(result > 0) {
				System.out.println(loginMember.getUser_id().equals(member.getUser_id()) + ",  result : " + result);
				model.addObject("loginMember", service.findMemberByUserId(loginMember.getUser_id()));
				model.addObject("msg", "회원정보 수정을 완료했습니다.");
				model.addObject("location", "/member/memModify");				
			} else {
				model.addObject("msg", "회원정보 수정에 실패 했습니다.");
				model.addObject("location", "/member/memModify");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	// 회원 삭제
	@RequestMapping("/member/delete")
	public ModelAndView delete(ModelAndView model,
			@SessionAttribute(name="loginMember", required = false) Member loginMember,
			@RequestParam("user_id")String userId) {
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(userId)) {
			result = service.deleteMember(userId);
			
			if(result > 0) {
				model.addObject("msg", "정상적으로 탈퇴되었습니다.");
				model.addObject("location", "/logout");				
			} else {
				model.addObject("msg", "회원 탈퇴를 실패하였습니다.");
				model.addObject("location", "/member/memModify");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/");
		}
		
		model.setViewName("common/msg");
		
		return model;
	}
	
	// 회원 비밀번호 변경 테스트
	@RequestMapping("/member/updatePassword")
	public String memAdress() {
		log.info("회원 비밀번호 변경 페이지 요청");
		
		return "/member/updatePassword";
	}
	
	@RequestMapping("/member/updatePass")
	public ModelAndView updateUserPass(@ModelAttribute Member member, ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		log.info("회원 비밀번호 변경 컨트롤러 요청");
		
		int result = 0;
		
		System.out.println(result);
		System.out.println("loginMember.getUser_id().equals(member.getUser_id()) : " + loginMember.getUser_id().equals(member.getUser_id()));
		System.out.println("loginMember.getUser_id() : " +  loginMember.getUser_id() + ",  member.getUser_id() : " +  member.getUser_id());
		System.out.println("loginMember.getUser_no() : " +  loginMember.getUser_no() + ",  member.getUser_no() : " +  member.getUser_no());
		
		/* 세팅 */
		member.setUser_no(loginMember.getUser_no());
		member.setUser_id(loginMember.getUser_id());
		
		System.out.println("member.getUser_no() : " + member.getUser_no());
		System.out.println("member.getUser_ID() : " + member.getUser_id());
		
		result = service.updateUserPassword(member);
		
		System.out.println(result);
		
		if(loginMember.getUser_id().equals(member.getUser_id())) {
			member.setUser_no(loginMember.getUser_no());
			if(result > 0) {
				System.out.println(loginMember.getUser_id().equals(member.getUser_id()) + ",  result : " + result);
				model.addObject("loginMember", service.findMemberByUserId(loginMember.getUser_id()));
				model.addObject("msg", "회원정보 수정을 완료했습니다.");
				model.addObject("location", "/member/updatePassword");				
			} else {
				model.addObject("msg", "회원정보 수정에 실패 했습니다.");
				model.addObject("location", "/member/updatePassword");
			}
		} else {
			model.addObject("msg", "잘못된 접근입니다.");
			model.addObject("location", "/");
		}
		
		model.setViewName("common/msg");
		
		return model;
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
