package com.kh.wehub.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.service.MessageService;
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.project.model.service.ProjectService;
import com.kh.wehub.project.model.vo.Project;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class ProjectController {
	
	@Autowired
	private ProjectService service;
	
	@Autowired
	private MessageService messageService;
	
	@RequestMapping(value = "/project/list", method = {RequestMethod.GET})
	public ModelAndView projectList(ModelAndView model,
			@RequestParam(value = "searchText", required=false)String searchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "12") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int projectCount = 0;
		PageInfo pageInfo = null;
		List<Project> projectList = null;
		
		//쪽지 아이콘 색 변하게 하는 코드
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", searchText);
		map.put("userNo", loginMember.getUser_no());
		
		projectCount = service.getProjectCount(map);
		
		pageInfo = new PageInfo(page, 10, projectCount, listLimit);
		projectList = service.getProjectList(pageInfo, map);
		
		for(int i = 0; i < projectList.size(); i++) {
			String[] arr = projectList.get(i).getParticipant().split("/ ");
			
			projectList.get(i).setProjectCount(arr.length);
		}
		
		List<Integer> projectNoList = projectList.stream().map(project -> project.getProjectNo()).collect(Collectors.toList());
		
//		System.out.println(projectNoList);	
//		System.out.println(loginMember.getUser_no());
		
		model.addObject("unreadCheck", unreadCheck);
		model.addObject("pageInfo", pageInfo);
		model.addObject("projectList",projectList);
		
		model.setViewName("project/project_list");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/search/projectMem", method = {RequestMethod.GET})
	public String searchJson(@RequestParam(value="userName") String userName) {
		
		List<Member> memSearch = service.getSearchMember(userName);
		
		JsonArray array = new JsonArray();
		for(int i=0; i < memSearch.size(); i++) {
			array.add(memSearch.get(i).getUser_name() + "_" + memSearch.get(i).getRank() + "_" +memSearch.get(i).getDept_name());
		}
		
		Gson gson = new Gson();
	
		return gson.toJson(array);	
	}
	
	@ResponseBody
	@RequestMapping(value="/project/make", method = {RequestMethod.POST})
	public void noticeWrite(
			@SessionAttribute(name="loginMember", required=false) Member loginMember, 
			Project Project) { 
		
		int result = 0;
		
		result = service.makeProject(Project);

		if(result > 0) {
			System.out.println("전송완료");
		} else {
			System.out.println("전송실패");
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/project/message", method = {RequestMethod.POST})
	public void noticeWrite(
			@SessionAttribute(name="loginMember", required=false) Member loginMember, 
			Message msg) { 
		
		int result = 0;
		List<Message> message = new ArrayList<Message>();
		
		int getMsgFrom = msg.getMsgFrom();
		String msgContent = msg.getMsgContent();
		
		String[] arr = msg.getUserName().split("/ ");

		for(int i=0; i <arr.length; i++) {
			Message forMsg = new Message();
			
			String[] name = arr[i].split("_");
			
			for(int num = 0; num < name.length; num++) {
				System.out.println(name[i]);
			}
			
			Member member = service.findReceiver(name[0], name[1], name[2]);
			
			forMsg.setMsgFrom(getMsgFrom);
			forMsg.setMsgTo(member.getUser_no());
			forMsg.setMsgContent(msgContent);
			forMsg.setRank(name[1]);
			forMsg.setDeptName(name[2]);
			
			message.add(i,forMsg);
			
			System.out.println(member);
		}
		Map<String, Object> map = new HashMap<>();
		map.put("list", message);
		
		result = service.sendProjectMsg(map);

		if(result > 0) {
			System.out.println("전송완료");
		} else {
			System.out.println("전송실패");
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="/project/makeFav", method= {RequestMethod.POST})
	public void makeFav(@SessionAttribute(name="loginMember", required=false) Member loginMember, 
			@RequestParam(value="proNum") int proNum) {
		
		int result = 0;
		
		Map<String,Object> map = new HashMap<>();
		map.put("proNum", proNum);
		map.put("userNo", loginMember.getUser_no());
		
		//있으면 n으로
		
		int Bookmark  = service.findStatus(map);
		
		if(Bookmark == 0) {
			result = service.makeFav(map);
		} else {
			result = service.removeFav(map);
		}
		
		if(result > 0) {
			System.out.println("변경성공");
		}else {
			System.out.println("변경실패");
		}
	}
	
	@RequestMapping(value = "/project/participant", method = {RequestMethod.GET})
	public ModelAndView projectParticipant(ModelAndView model,
			@RequestParam(value = "searchText", required=false)String searchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "12") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int projectCount = 0;
		PageInfo pageInfo = null;
		List<Project> projectList = null;
		
		//쪽지 아이콘 색 변하게 하는 코드
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
				
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", searchText);
		map.put("userName", loginMember.getUser_name());
		map.put("rank", loginMember.getRank());
		map.put("deptName", loginMember.getDept_name());
		map.put("userNo", loginMember.getUser_no());
		
		projectCount = service.getParticipantCount(map);
		
		pageInfo = new PageInfo(page, 10, projectCount, listLimit);
		projectList = service.getParticipantList(pageInfo, map);
		
		for(int i = 0; i < projectList.size(); i++) {
			String[] arr = projectList.get(i).getParticipant().split("/ ");
			
			projectList.get(i).setProjectCount(arr.length);
		}
		
		model.addObject("unreadCheck", unreadCheck);
		model.addObject("pageInfo", pageInfo);
		model.addObject("projectList",projectList);
		
		model.setViewName("project/project_participant");
		
		return model;
	}
	
	@RequestMapping(value = "/project/favorite", method = {RequestMethod.GET})
	public ModelAndView projectFavList(ModelAndView model,
			@RequestParam(value = "searchText", required=false)String searchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "12") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int projectCount = 0;
		PageInfo pageInfo = null;
		List<Project> projectList = null;
		
		//쪽지 아이콘 색 변하게 하는 코드
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", searchText);
		map.put("userNo", loginMember.getUser_no());
		
		projectCount = service.getFavCount(map);
		
		pageInfo = new PageInfo(page, 10, projectCount, listLimit);
		projectList = service.getFavList(pageInfo, map);
		
		for(int i = 0; i < projectList.size(); i++) {
			String[] arr = projectList.get(i).getParticipant().split("/ ");
			
			projectList.get(i).setProjectCount(arr.length);
		}
		
		model.addObject("unreadCheck", unreadCheck);
		model.addObject("pageInfo", pageInfo);
		model.addObject("projectList",projectList);
		
		model.setViewName("project/project_fav");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/project/close", method= {RequestMethod.POST})
	public void closeProject(@RequestParam(value="proNo") int proNo) {
		int result = 0;
		result = service.closeProject(proNo);
		
		if(result > 0) {
//			System.out.println("종료성공");
		}else {
//			System.out.println("종료실패");
		}
	}
	
	@RequestMapping(value = "/project/endList", method = {RequestMethod.GET})
	public ModelAndView projectEndList(ModelAndView model,
			@RequestParam(value = "searchText", required=false)String searchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "12") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int projectCount = 0;
		PageInfo pageInfo = null;
		List<Project> projectList = null;
		
		//쪽지 아이콘 색 변하게 하는 코드
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(loginMember.getUser_no());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", searchText);
		map.put("userNo", loginMember.getUser_no());
		
		projectCount = service.getEndProjectCount(map);
		
		pageInfo = new PageInfo(page, 10, projectCount, listLimit);
		projectList = service.getEndProjectList(pageInfo, map);
		
		for(int i = 0; i < projectList.size(); i++) {
			String[] arr = projectList.get(i).getParticipant().split("/ ");
			
			projectList.get(i).setProjectCount(arr.length);
		}
		
		List<Integer> projectNoList = projectList.stream().map(project -> project.getProjectNo()).collect(Collectors.toList());
		
//		System.out.println(projectNoList);	
//		System.out.println(loginMember.getUser_no());
		
		model.addObject("unreadCheck", unreadCheck);
		model.addObject("pageInfo", pageInfo);
		model.addObject("projectList",projectList);
		
		model.setViewName("project/project_end");
		
		return model;
	}
	
}
