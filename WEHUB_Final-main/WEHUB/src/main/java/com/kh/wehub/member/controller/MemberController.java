//package com.kh.wehub.member.controller;
//
//import java.util.Locale;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.SessionAttributes;
//import org.springframework.web.bind.support.SessionStatus;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.kh.wehub.member.model.service.MemberService;
//import com.kh.wehub.member.model.vo.Member;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Controller
//
//@SessionAttributes("loginMember")
//public class MemberController {
//	@Autowired
//	private MemberService service;
//	
////	@RequestMapping(value = "/login", method = {RequestMethod.GET})
//	@RequestMapping(value = "/login1", method = {RequestMethod.GET})
//	public String login(HttpServletRequest request) {
//		log.info("멤버컨트롤러 시작?");
//		System.out.println("멤버컨트롤러 보내는척");
////		String userId = request.getParameter("user_id");
////		String userPwd = request.getParameter("user_pwd");
////		
////		log.info("{}, {}" , userId, userPwd);
//		
//		return "member/login";
//	}
//	
//	@RequestMapping(value="/login1", method={RequestMethod.POST})
//	public ModelAndView login(ModelAndView model, @RequestParam("user_id") String userId, 
//												  @RequestParam("user_pwd") String userPwd) {
//		log.info("로그인 요청");
//	System.out.println("login 요청");
//			log.info("{}, {}" , userId, userPwd);
//		
//		Member loginMember = service.login(userId, userPwd);
//		
//
//		if(loginMember != null) {
//			model.addObject("loginMember" , loginMember);
//			model.setViewName("/main");
//		}else {
//			model.addObject("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
//			model.addObject("location", "/");
//			model.setViewName("common/msg");
//		}
//		return model;
//	}
//	
//	@RequestMapping("/logout")
//	public String logout(SessionStatus status) {
//		// 세션 삭제함.
//		
//		log.info("status.isComplete() " +status.isComplete());
//		status.setComplete();
//		log.info("status.isComplete() " +status.isComplete());
//		
//		return "redirect:/";
//		
//	}
//	@RequestMapping(value="member/signUpForm")
//	public String signUpForm() {
//		log.info("회원가입 페이지 요청");
//		return "member/signUpForm";}
//	
//	///////////////////////
//	@RequestMapping(value="member/signUpForm",method= {RequestMethod.POST})
//	
//	public ModelAndView signUpForm(ModelAndView model , @ModelAttribute Member member) {
//
//		log.info(member.toString());
//		
//		int result = service.saveMember(member);
//
//		log.info(member.toString());
//		log.info("email : "+ member.getEmail());
//	
//		// 회원가입 정상 유뮤
//		if(result>0) {
//			
//			model.addObject("msg","회원 가입 정상적 완료.");
//			model.addObject("location","/");
//			
//		}else {
//			model.addObject("msg","회원 가입 Fail.");
//			model.addObject("location","/member/signUpForm");
//		}
//		
//		model.setViewName("common/msg");
//	
//	return model;
//}
//	////////////////////
//	
//	@RequestMapping(value="member/findIDorPwd")
//		public String findIdorPwd() {
//		log.info("wanna go findIDorPwd");
//		return "member/findIDorPwd";
//		}
//	@RequestMapping(value="member/findID")
//	public String findID() {
//	log.info("findID go!!");
//	return "member/findID";
//	}
//	
//	@RequestMapping(value="member/findPwd")
//	public String findPWD() {
//	log.info("findPWD go!!");
//	return "member/findPwd";
//	}
//
//	@RequestMapping(value="main")
//	public String mainPage() {
//
//		return "/main";
//	}
//
//
//
//}

package com.kh.wehub.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class MemberController {

	@Autowired
	private MemberService service;
	
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
	@RequestMapping(value="member/findPwd")
	public String findPWD() {
		log.info("findID go!!");
		
		return "member/findPwd";
	}
	
	@RequestMapping(value="member/findID", method={RequestMethod.POST})
	public ModelAndView findID(ModelAndView model,@ModelAttribute Member member) {
		

		String findID =service.findID(member);
		
			model.addObject("userID" , findID);
			log.info("찾은 아이디");
			System.out.println("찾은 아이디는"+findID);
			model.addObject("msg", "찾은 아이디는 "+findID);
		
			model.setViewName("common/msg");
		//	model.setViewName("redirect:/");
		
		return model;
	}
	
	
	@RequestMapping(value="member/findPwd",method={RequestMethod.POST})
	public ModelAndView findPWD(ModelAndView model,@ModelAttribute Member member) {
		
		String findPWD =service.findPWD(member);
		
		model.addObject("userPwd" , findPWD);
		log.info("찾은 pwd");
		System.out.println("찾은 pwd는"+findPWD);
		model.addObject("msg","찾은 pwd는"+ findPWD);
		model.setViewName("common/msg");
		//model.setViewName("redirect:/");
	return model;
	}
	
}