package com.kh.wehub.message.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.vo.ReceiveMessage;
import com.kh.wehub.message.model.vo.SendMessage;

public interface MessageService {

	int getMsgCount(Map<String, Object> map);

	int deleteMsg(int receiveNo);
	
	int sendMsg(SendMessage sendMessage);
	
	int recMsg(ReceiveMessage recMsg);
	
	int getSendMsgCount(Map<String, Object> map);
	
	int deleteSendMsg(int sendNo);
	
	Member getSender(Map<String, Object> map);
	
	List<ReceiveMessage> getReceiveList(PageInfo pageInfo, Map<String, Object> map);

	List<Member> getSearchMember(String user_name);

	List<SendMessage> getSendList(PageInfo pageInfo, Map<String, Object> map);

}
