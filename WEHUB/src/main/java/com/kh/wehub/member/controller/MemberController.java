package com.kh.wehub.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;

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
			model.setViewName("redirect:/home");
		}else {
			model.addObject("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			model.addObject("location", "/");
			model.setViewName("common/msg");
		}
		return model;
	}
	
	//메인 화면 띄우기
	@RequestMapping(value="home")
	public ModelAndView mainPage(ModelAndView model,
			@SessionAttribute("loginMember")Member loginMember) {
		
		model.addObject("loginMember", loginMember);
		model.setViewName("/home");
		
		
		
		return model;
	}
	
}