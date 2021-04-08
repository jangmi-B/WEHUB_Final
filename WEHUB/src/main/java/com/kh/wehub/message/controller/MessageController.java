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
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.message.model.vo.ReceiveMessage;
import com.kh.wehub.message.model.vo.SendMessage;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("loginMember")
public class MessageController {
	
	@Autowired
	private MessageService service;
	
// 1. 받은 메세지함
	@RequestMapping(value = "/message/list", method = {RequestMethod.GET})
	public ModelAndView msgList(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgSearchText", required=false)String msgSearchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int msgCount = 0;
		PageInfo pageInfo = null;
		List<Message> receiveList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgSearchList", msgSearchList);
		map.put("msgSearchText", msgSearchText);
		map.put("msgTo", loginMember.getUser_no());
		
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
	public void deleteMsg(@RequestParam(value="msgNo") int msgNo) {
		
		int result = 0;
		result = service.deleteMsg(msgNo);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/message/readCheck", method= {RequestMethod.GET})
	public void readCheckMsg(@RequestParam(value="msgNo") int msgNo) {
		
		int result = 0;
		result = service.readCheckMsg(msgNo);
		
		if(result > 0) {
//			System.out.println("변경성공");
		}else {
			System.out.println("변경실패");
		}
	}
	
	
// 2. 쪽지쓰기
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
			Message Message) { 
		
		int result = 0;
		int result2 = 0;
		
		String[] arr = Message.getUserName().split("_");
		
		Message.setUserName(arr[0]);
		Message.setRank(arr[1]);
		Message.setDeptName(arr[2]);
		
		Map<String, Object> map = new HashMap<>();
		map.put("user_name", Message.getUserName());
		map.put("dept_name", Message.getDeptName());
		
		Member member = service.getReceiver(map);
		
		Message.setMsgTo(member.getUser_no());
		
		result = service.sendMsg(Message);

		if(result > 0) {
//			System.out.println("전송완료");
		} else {
			System.out.println("전송실패");
		}
	}
	
	
// 3. 보낸 메세지함
	
	@RequestMapping(value = "/message/sendList", method = {RequestMethod.GET})
	public ModelAndView sendMsgList(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgSearchText", required=false)String msgSearchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int msgCount = 0;
		PageInfo pageInfo = null;
		List<Message> sendList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgSearchList", msgSearchList);
		map.put("msgSearchText", msgSearchText);
		map.put("msgFrom", loginMember.getUser_no());

		msgCount = service.getSendMsgCount(map);
		
		pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		sendList = service.getSendList(pageInfo, map);
		
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
	public void deleteSendMsg(@RequestParam(value="msgNo") int msgNo) {
		
		int result = 0;
		result = service.deleteSendMsg(msgNo);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
	
// 4. 체크항목 삭제
	//받은메세지 삭제
	@ResponseBody
	@RequestMapping(value="/message/deleteSelected", method= {RequestMethod.POST})
	public void deleteSelected(@RequestParam(value = "arr[]") List<Integer> checkList) {
		
		int result = 0;
		result = service.deleteCheckMsg(checkList);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
	//보낸메세지 삭제
	@ResponseBody
	@RequestMapping(value="/message/deleteSendSelected", method= {RequestMethod.POST})
	public void deleteSendSelected(@RequestParam(value = "arr[]") List<Integer> checkList) {
//		System.out.println(checkList);
//		System.out.println(checkList.size());
		
		int result = 0;
		result = service.deleteCheckSendMsg(checkList);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
	//휴지통 삭제
	@ResponseBody
	@RequestMapping(value="/deletedmessage/deleteSelected", method= {RequestMethod.POST})
	public void deletedMsgSelected(@RequestParam(value = "arr[]") List<Integer> checkList) {
		
		int result = 0;
		result = service.deleteCheckDeletedMsg(checkList);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}

	// 체크항목 읽지않음으로 표시 
	@ResponseBody
	@RequestMapping(value="/message/readCheckSelected", method= {RequestMethod.POST})
	public void readCheckSelected(@RequestParam(value = "arr[]") List<Integer> checkList) {
		
		int result = 0;
		result = service.readCheckSelected(checkList);
		
		if(result > 0) {
//			System.out.println("변경성공");
		}else {
			System.out.println("변경실패");
		}
	}
	
	// 체크항목 보관함이동	
	@ResponseBody
	@RequestMapping(value="/message/saveSelected", method= {RequestMethod.POST})
	public void saveSelected(@RequestParam(value = "arr[]") List<Integer> checkList) {
		
		int result = 0;
		result = service.saveSelected(checkList);
		
		if(result > 0) {
//		System.out.println("변경성공");
		}else {
		System.out.println("변경실패");
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/message/saveSendSelected", method= {RequestMethod.POST})
	public void saveSendSelected(@RequestParam(value = "arr[]") List<Integer> checkList) {
		
		int result = 0;
		result = service.saveSendSelected(checkList);
		
		if(result > 0) {
//		System.out.println("변경성공");
		}else {
		System.out.println("변경실패");
		}
	}
	
//5. 휴지통
	
	@RequestMapping(value = "/message/deletedList", method = {RequestMethod.GET})
	public ModelAndView deletedMsgList(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgSearchText", required=false)String msgSearchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int msgCount = 0;
		PageInfo pageInfo = null;
		List<Message> deletedList = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgSearchList", msgSearchList);
		map.put("msgSearchText", msgSearchText);
		map.put("msgTo", loginMember.getUser_no());
		
		msgCount = service.getDeletedMsgCount(map);
		
		pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		deletedList = service.getDeletedList(pageInfo, map);
		
		if(msgSearchList == null && msgSearchText == null) {
			model.addObject("pageInfo",pageInfo);
			model.addObject("deletedList", deletedList);
		}else {
			model.addObject("map", map);
			model.addObject("pageInfo", pageInfo);
			model.addObject("deletedList",deletedList);
		}
		
		model.setViewName("message/deletedMessage");
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value="/deletedmessage/delete", method= {RequestMethod.GET})
	public void deletedMsgDelete(@RequestParam(value="msgNo") int msgNo) {
		
		int result = 0;
		result = service.deletedMsgDelete(msgNo);
		
		if(result > 0) {
//			System.out.println("삭제성공");
		}else {
			System.out.println("삭제실패");
		}
	}
	
// 6. 보관함	
	//받은편지 보관함
	@RequestMapping(value = "/message/saveListRec", method = {RequestMethod.GET})
	public ModelAndView saveMsgList(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgSearchText", required=false)String msgSearchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int msgCount = 0;
		PageInfo pageInfo = null;
		List<Message> saveMessage = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgSearchList", msgSearchList);
		map.put("msgSearchText", msgSearchText);
		map.put("msgTo", loginMember.getUser_no());
		
		msgCount = service.getSaveRecCount(map);
		
		pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		saveMessage = service.getSaveList(pageInfo, map);
		
		if(msgSearchList == null && msgSearchText == null) {
			model.addObject("pageInfo",pageInfo);
			model.addObject("saveMessage", saveMessage);
		}else {
			model.addObject("map", map);
			model.addObject("pageInfo", pageInfo);
			model.addObject("saveMessage",saveMessage);
		}
		
		model.setViewName("message/savemessage_rec");
		
		return model;
	}

	//	보낸편지 보관함
	@RequestMapping(value = "/message/saveListSend", method = {RequestMethod.GET})
	public ModelAndView saveListSend(ModelAndView model,
			@RequestParam(value = "msgSearchList", required=false)String msgSearchList,
			@RequestParam(value = "msgSearchText", required=false)String msgSearchText,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "15") int listLimit,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		int msgCount = 0;
		PageInfo pageInfo = null;
		List<Message> saveSendMessage = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msgSearchList", msgSearchList);
		map.put("msgSearchText", msgSearchText);
		map.put("msgFrom", loginMember.getUser_no());

		msgCount = service.saveSendMsgCount(map);
		
		pageInfo = new PageInfo(page, 10, msgCount, listLimit);
		saveSendMessage = service.getSaveSendList(pageInfo, map);
		
		if(msgSearchList == null && msgSearchText == null) {
			model.addObject("pageInfo",pageInfo);
			model.addObject("saveSendMessage", saveSendMessage);
		}else {
			model.addObject("map", map);
			model.addObject("pageInfo", pageInfo);
			model.addObject("saveSendMessage", saveSendMessage);
		}
		
		model.setViewName("message/saveMessage_send");
		
		return model;
	}
}
