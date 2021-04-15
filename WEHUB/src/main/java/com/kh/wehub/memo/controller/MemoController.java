package com.kh.wehub.memo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memo.model.service.MemoService;

@Controller
@SessionAttributes("loginMember")
public class MemoController {
	
	@Autowired
	private MemoService service;
	
	@RequestMapping(value = "/home/memo", method={RequestMethod.POST})
	public ModelAndView homeMemo(ModelAndView model,
			@SessionAttribute("loginMember")Member loginMember,
			@RequestParam(value = "memoArray[]") List<String> memoList) {
		
		int result = 0;
		int getMemo = 0;
		
		String memo = memoList.stream().map(n -> String.valueOf(n)).collect(Collectors.joining("_"));
		
		Map<String, Object> map = new HashMap<>();
		map.put("memo", memo);
		map.put("userNo", loginMember.getUser_no());
		
		getMemo = service.getMemoCount(loginMember.getUser_no());
		
		if(getMemo > 0) {
			result = service.updateMemo(map);
		} else {
			result = service.insertMemo(map);
		}
		
		if(result > 0) {
			System.out.println("변경성공");
		}else {
			System.out.println("변경실패");
		}
		
		model.setViewName("/home");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value = "/home/memo/clear", method={RequestMethod.POST})
	public void deleteSendMsg(@SessionAttribute("loginMember")Member loginMember) {
		
		int result = 0;
		int userNo = loginMember.getUser_no();
		
		result = service.clearMemo(userNo);
		
		if(result > 0) {
			System.out.println("변경성공");
		}else {
			System.out.println("변경실패");
		}
		
	}
}
