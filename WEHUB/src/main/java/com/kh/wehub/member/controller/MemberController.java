package com.kh.wehub.member.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.chrono.IsoChronology;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.joda.time.DateTime;
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
import com.kh.wehub.schedule.model.service.ScheduleService;
import com.kh.wehub.schedule.model.vo.DateData;

@Controller
@SessionAttributes("loginMember")
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private ScheduleService ScheduleService;
	
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
	@RequestMapping(value = "/home")
	public ModelAndView home(ModelAndView model,
			@SessionAttribute("loginMember")Member loginMember) {
			
		DateTime dt = new DateTime();
		String today = dt.toString("yyyy M d");
		String[] arr = today.split(" ");
		
		
		List<DateData> todaySchedule = ScheduleService.todaySchedule(loginMember, arr);
		
		System.out.println(todaySchedule.get(0).getSchedule_content());
		
		
		model.addObject("todaySchedule",todaySchedule);
		model.addObject("loginMember",loginMember);
		model.setViewName("/home");
		
		return model;
	}

}
