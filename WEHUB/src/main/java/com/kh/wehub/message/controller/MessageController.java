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
	
	/////////////////받은쪽지///////////////////
	
	@RequestMapping(value = "/message/list", method = {RequestMethod.GET})
	public ModelAndView msgList(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgSearchText", required=false)String msgSearchText,
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
		
		msgCount = service.getMsgCount(map);
		
		pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		receiveList = service.getReceiveList(pageInfo, map);
		
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
	public void deleteMsg(@RequestParam(value="receiveNo") int receiveNo) {
		
		int result = 0;
		result = service.deleteMsg(receiveNo);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
	
	//////////////// 쪽지쓰기 /////////////////
	
	//자동완성
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
	
	// 쪽지보내기
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
	
	
///////////////////	보낸메세지함///////////////////////
	
	@RequestMapping(value = "/message/sendList", method = {RequestMethod.GET})
	public ModelAndView sendMsgList(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgSearchText", required=false)String msgSearchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int msgCount = 0;
		PageInfo pageInfo = null;
		List<SendMessage> sendList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgSearchList", msgSearchList);
		map.put("msgSearchText", msgSearchText);
		map.put("senderNo", loginMember.getUser_no());
		
		System.out.println(map.toString());

		msgCount = service.getSendMsgCount(map);
		
		System.out.println(msgCount);
		
		pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		sendList = service.getSendList(pageInfo, map);
		
		System.out.println(sendList.toString());
		
		if(msgSearchList == null && msgSearchText == null) {
			model.addObject("pageInfo",pageInfo);
			model.addObject("sendList", sendList);
		}else {
			model.addObject("map", map);
			model.addObject("pageInfo", pageInfo);
			model.addObject("sendList", sendList);
		}
		
		model.setViewName("message/message_send");
		
		return model;
	}
	
	// 보낸메세지 삭제
	@ResponseBody
	@RequestMapping(value="/sendMessage/delete", method= {RequestMethod.GET})
	public void deleteSendMsg(@RequestParam(value="sendNo") int sendNo) {
		
		int result = 0;
		result = service.deleteSendMsg(sendNo);
		
		if(result > 0) {
			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
	
////////////// 체크된 항목들 삭제 ////////////////////
	
	@ResponseBody
	@RequestMapping(value="/message/deleteSelected", method= {RequestMethod.POST})
	public void deleteSelected(@RequestParam(value = "arr[]") List<Integer> arr) {
		System.out.println(arr);
		System.out.println(arr.size());
		
		int result = 0;
//		result = service.deleteCheckSendMsg(arr);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
}
