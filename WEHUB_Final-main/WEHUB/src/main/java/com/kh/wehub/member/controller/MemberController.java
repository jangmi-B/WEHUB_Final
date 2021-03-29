package com.kh.wehub.member.controller;

import java.util.HashMap;
import java.util.Map;

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
	@RequestMapping(value="member/findPwd")
	public String findPWD() {
		log.info("findID go!!");
		
		return "member/findPwd";
	}
	
	@RequestMapping(value="member/findID", method={RequestMethod.POST})
	public ModelAndView findID(ModelAndView model,@ModelAttribute Member member) {
		

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
	
	
	@RequestMapping(value="member/findPwd",method={RequestMethod.POST})
	public ModelAndView findPWD(ModelAndView model,@ModelAttribute Member member) {
		
		String findPWD =service.findPWD(member);
		if(findPWD!=null) {
		//model.addObject("userPwd" , findPWD);
		log.info("찾은 pwd");
		model.addObject("msg","찾은 pwd는"+ findPWD);
		}else {
			model.addObject("msg", "찾은 비밀번호는 존재하지 않습니다");
		}
		model.setViewName("common/msg");
		//model.setViewName("redirect:/");
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
	public ModelAndView signUpForm(ModelAndView model, @ModelAttribute Member member) {

		log.info(member.toString());
		
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
		
		return "member/signUpForm";
	}
	
	// 회원 수정
	@RequestMapping("member/memModify")
	public String memModify() {
		log.info("회원 수정 페이지 요청");
		
		return "member/memModify";
	}
	
	@RequestMapping("/member/update")
	public ModelAndView update(@ModelAttribute Member member,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember,
			ModelAndView model) {
		
		int result = 0;
		
		if(loginMember.getUser_id().equals(member.getUser_id())) {
			member.setUser_no(loginMember.getUser_no());
			
			result = service.saveMember(member);
//			log.info("result 값 받아오나욘? " + result);
			
			if(result > 0) {
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
}
