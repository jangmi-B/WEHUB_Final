package com.kh.wehub.member.controller;

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

import com.kh.wehub.board.model.service.BoardService;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.community.model.service.CommunityService;
import com.kh.wehub.community.model.vo.Community;
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
	
	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private BoardService boardService;
	
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
	@RequestMapping(value = "/main")
	public ModelAndView home(ModelAndView model,
			@SessionAttribute("loginMember")Member loginMember) {
		//세션유저
		model.addObject("loginMember",loginMember);
		
		//오늘 일정 Section
		DateTime dt = new DateTime();
		String today = dt.toString("yyyy M d");
		String[] arr = today.split(" ");
		
		List<DateData> todaySchedule = ScheduleService.todaySchedule(loginMember, arr);
		
		model.addObject("todaySchedule",todaySchedule);
		model.setViewName("/home");
		//---------------------------------------------------------------------------------
		//커뮤니티 Section
		List<Community> communityList = communityService.selectMainList();
		
		model.addObject("communityList", communityList);
		//---------------------------------------------------------------------------------
		//공지사항 Section
		List<Notice> NoticeList = boardService.selectList(); 
		System.out.println(NoticeList);
		model.addObject("NoticeList", NoticeList);
		
		
		return model;
	}

}
