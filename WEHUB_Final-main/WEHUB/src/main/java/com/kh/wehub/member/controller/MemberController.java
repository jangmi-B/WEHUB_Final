package com.kh.wehub.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.member.model.vo.MemberEnroll;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@RequestMapping(value = "home")
	public ModelAndView home(ModelAndView model,
			@SessionAttribute("loginMember")MemberEnroll loginMember) {
		
		model.addObject("loginMember", loginMember);
		model.setViewName("/home");
		
		return model;
	}
	
	@RequestMapping(value="/login", method={RequestMethod.POST})
	public ModelAndView login(ModelAndView model, @RequestParam("userId") String userId, 
												  @RequestParam("userPwd") String userPwd) {
		
		Member loginMember = null;
		
		loginMember = service.login(userId, userPwd);
		
		if(loginMember != null) {
			model.addObject("loginMember" , loginMember);
			model.setViewName("redirect:/home");
		}else {
			model.addObject("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			model.addObject("location", "/");
			model.setViewName("common/msg");
		}
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
	
	@RequestMapping(value = "member/signUpForm", method = {RequestMethod.POST})
	public ModelAndView signUpForm(ModelAndView model, @ModelAttribute MemberEnroll member) {
		System.out.println("제발");
		log.info("Why...?");
		log.info(member.toString());
		
		model.setViewName("member/signUpForm");
		
//		int result = service.saveMember(member);
		
		log.info(member.toString());
		
//		if(result > 0) {
//			model.addObject("msg", "회원가입이 정상적으로 되었습니다.");
//			model.addObject("location", "/"); // 홈으로 이동시키는 로케이션
//		} else { // 회원가입이 제대로 되지 않았을 때
//			model.addObject("msg", "회원가입을 실패하였습니다. 올바른 정보를 입력하여 주세요.");
//			model.addObject("location", "/member/enroll");
//		}
//		
//		model.setViewName("common/msg");
		
		return model;
	}
}
