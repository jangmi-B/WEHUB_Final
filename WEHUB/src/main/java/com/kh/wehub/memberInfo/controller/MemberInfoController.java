package com.kh.wehub.memberInfo.controller;

import java.util.HashMap;
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

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.service.MemberService;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memberInfo.model.service.MemberInfoService;
import com.kh.wehub.memberInfo.model.vo.InsertNewMember;
import com.kh.wehub.message.model.service.MessageService;

@Controller
@SessionAttributes("loginMember")
public class MemberInfoController {

	@Autowired
	private MemberInfoService service;
	
	@Autowired
	private MessageService messageService;
	
	// 인명관리 화면 띄우기
	@RequestMapping(value="memberInfo/list", method= {RequestMethod.GET})
	public ModelAndView memberInfo(ModelAndView model,
			@RequestParam(value="page", required=false, defaultValue = "1") int page,
			@RequestParam(value="listLimit", required=false, defaultValue = "10") int listLimit,
			@RequestParam(value="searchList" ,required=false) String searchList,
			@RequestParam(value="searchText" ,required=false) String searchText,
			@SessionAttribute(name="loginMember", required=false) Member memberInfo
			) {
		
		int count = 0;
		int searchCount = 0;
		
		//쪽지 아이콘 색 변하게 하는 코드
		int unreadCheck = 0;
		unreadCheck = messageService.getUnreadCheck(memberInfo.getUser_no());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchList", searchList);
		map.put("searchText", searchText);
		
		if(searchList == null && searchText == null) {
			count = service.infoCount();
			PageInfo info = new PageInfo(page, 10, count, 10);
			model.addObject("info", info);
			model.addObject("unreadCheck", unreadCheck);
			model.addObject("SearchList", service.SearchList(info,searchList,searchText));
		}else {
			searchCount = service.infoSearchCount(searchList, searchText);
			PageInfo info = new PageInfo(page, 10, searchCount, 10);
			model.addObject("map", map);
			model.addObject("info", info);
			model.addObject("unreadCheck", unreadCheck);
			model.addObject("SearchList", service.SearchList(info,searchList,searchText));
		}
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value ="/insertNewMember", method= {RequestMethod.POST})
	public InsertNewMember insertMember(
			@RequestParam("newName") String newName,
			@RequestParam("newRank") String newRank,
			@RequestParam("newDept") String newDept) {
		
		System.out.println(newName);
		System.out.println(newRank);
		System.out.println(newDept);
		
		int result = service.insertMember(newName, newRank, newDept);
		
		if(result > 0) {
			System.out.println("신규맴버 등록성공");
		}else {
			System.out.println("실패");
		}
		
		return null;
	}
}
