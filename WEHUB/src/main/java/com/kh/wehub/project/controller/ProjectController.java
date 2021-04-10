package com.kh.wehub.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@RequestMapping(value = "/project/list", method = {RequestMethod.GET})
	public ModelAndView projectList(ModelAndView model,
			@RequestParam(value = "searchText", required=false)String searchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "12") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int projectCount = 0;
		PageInfo pageInfo = null;
		List<Project> projectList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", searchText);
		
		projectCount = service.getProjectCount(map);
		
		
		pageInfo = new PageInfo(page, 10, projectCount, listLimit);
		projectList = service.getProjectList(pageInfo, map);
		
		for(int i = 0; i < projectList.size(); i++) {
			String[] arr = projectList.get(i).getParticipant().split("/ ");
			
			projectList.get(i).setProjectCount(arr.length);
		}
		
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
		
		System.out.println(Project);
		
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
		System.out.println("arr : " + arr[0] + arr[1] + arr[2]);

		for(int i=0; i <arr.length; i++) {
			Message forMsg = new Message();
			
			String[] name = arr[i].split("_");
			System.out.println("name : " + name[0] + name[1] + name[2]);
			
			Member member = service.findReceiver(name[0], name[1], name[2]);
			
			System.out.println("member : " + member);
			
			forMsg.setMsgFrom(getMsgFrom);
			forMsg.setMsgTo(member.getUser_no());
			forMsg.setMsgContent(msgContent);
			forMsg.setRank(name[1]);
			forMsg.setDeptName(name[2]);
			
			System.out.println("forMsg : " + forMsg);
			
			message.add(i,forMsg);
			
			System.out.println("message 저장확인" + message);
		}
		
		System.out.println("message :" + message);
		
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
	public void makeFav(@RequestParam(value="proNum") int proNum) {
		
		int result = 0;
		Project project = service.findStatus(proNum);
		
		if(project.getStatus().equals("Y")) {
			result = service.makeFav(proNum);
		} else if(project.getStatus().equals("S")) {
			result = service.removeFav(proNum);
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
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchText", searchText);
		
		projectCount = service.getFavCount(map);
		
		pageInfo = new PageInfo(page, 10, projectCount, listLimit);
		projectList = service.getFavList(pageInfo, map);
		
		for(int i = 0; i < projectList.size(); i++) {
			String[] arr = projectList.get(i).getParticipant().split("/ ");
			
			projectList.get(i).setProjectCount(arr.length);
		}
		
		model.addObject("pageInfo", pageInfo);
		model.addObject("projectList",projectList);
		
		model.setViewName("project/project_fav");
		
		return model;
	}
	
}
