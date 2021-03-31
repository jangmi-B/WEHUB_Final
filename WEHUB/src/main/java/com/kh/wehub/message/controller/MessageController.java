package com.kh.wehub.message.controller;

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

import com.kh.wehub.board.model.service.BoardService;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.service.MessageService;
import com.kh.wehub.message.model.vo.ReceiveMessage;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class MessageController {
	
	@Autowired
	private MessageService service;
	
	@RequestMapping(value = "/message/list", method = {RequestMethod.GET})
	public ModelAndView msgList(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgsSearchText", required=false)String msgSearchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int msgCount = 0;
		PageInfo pageInfo = null;
		List<ReceiveMessage> receiveList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgSearchList", msgSearchList);
		map.put("msgSearchText", msgSearchText);
		map.put("receiverNo", loginMember.getUser_no());
		
		msgCount = service.getSendMsgCount(map);
		
		pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		receiveList = service.getSendList(pageInfo, map);
		
		if(msgSearchList == null && msgSearchText == null) {
			model.addObject("pageInfo",pageInfo);
			model.addObject("receiveList", receiveList);
		}else {
			model.addObject("map", map);
			model.addObject("pageInfo", pageInfo);
			model.addObject("receiveList",receiveList);
		}
		
		model.setViewName("message/message_list");
		
		return model;
	}
	
}
