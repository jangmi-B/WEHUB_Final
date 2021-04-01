package com.kh.wehub.message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.service.MessageService;
import com.kh.wehub.message.model.vo.ReceiveMessage;
import com.kh.wehub.message.model.vo.SendMessage;

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
	
	@ResponseBody
	@RequestMapping(value="/message/delete", method= {RequestMethod.GET})
	public void deleteComment(@RequestParam(value="receiveNo") int receiveNo) {
		
		int result = 0;
		result = service.deleteMsg(receiveNo);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/search/json", method = {RequestMethod.GET})
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
	@RequestMapping(value="/message/send", method = {RequestMethod.POST})
	public void noticeWrite(
			@SessionAttribute(name="loginMember", required=false) Member loginMember, 
			SendMessage sendMessage) { 
		
		int result = 0;
		int result2 = 0;
		ReceiveMessage recMsg = new ReceiveMessage();
		
		String[] arr = sendMessage.getUserName().split("_");
		
		sendMessage.setUserName(arr[0]);
		sendMessage.setRank(arr[1]);
		sendMessage.setDeptName(arr[2]);
		
		Map<String, Object> map = new HashMap<>();
		map.put("user_name", sendMessage.getUserName());
		map.put("dept_name", sendMessage.getDeptName());
		
		Member member = service.getSender(map);
		
		sendMessage.setReceiverNo(member.getUser_no());
		
		recMsg.setSenderNo(sendMessage.getSenderNo());
		recMsg.setReceiverNo(sendMessage.getReceiverNo());
		recMsg.setReceiveContent(sendMessage.getSendContent());
			
		result = service.sendMsg(sendMessage);
		result2 =service.recMsg(recMsg);

		if(result > 0 && result2 > 0) {
			System.out.println("전송완료");
		} else {
			System.out.println("전송실패");
		}
	}
	
}
