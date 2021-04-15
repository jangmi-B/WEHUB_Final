package com.kh.wehub.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memo.model.service.MemoService;
import com.kh.wehub.memo.model.vo.Memo;
import com.kh.wehub.message.model.service.MessageService;
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.project.model.service.ProjectService;
import com.kh.wehub.project.model.vo.Project;

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
		model.setViewName("/home");
		
		return model;
	}
	
}
