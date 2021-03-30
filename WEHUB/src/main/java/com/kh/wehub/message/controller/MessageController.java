package com.kh.wehub.message.controller;

import java.util.List;

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
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		List<ReceiveMessage> receiveList = null;
		
		int msgCount = service.getSendMsgCount(loginMember.getUser_no());
		System.out.println(msgCount);
		
		PageInfo pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		
		receiveList = service.getSendList(pageInfo, loginMember.getUser_no());
		System.out.println(receiveList);
		
		model.addObject("receiveList", receiveList);
		model.addObject("pageInfo",pageInfo);
		model.setViewName("message/message_list");
		
		return model;
	}
	
}
