package com.kh.wehub.message.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.vo.ReceiveMessage;
import com.kh.wehub.message.model.vo.SendMessage;

public interface MessageService {

	int getSendMsgCount(Map<String, Object> map);

	List<ReceiveMessage> getSendList(PageInfo pageInfo, Map<String, Object> map);

	int deleteMsg(int receiveNo);

	List<Member> getSearchMember(String user_name);

	int sendMsg(SendMessage sendMessage);

	Member getSender(Map<String, Object> map);

	int recMsg(ReceiveMessage recMsg);

	
}
