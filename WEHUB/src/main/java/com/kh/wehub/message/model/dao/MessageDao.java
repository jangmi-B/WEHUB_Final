package com.kh.wehub.message.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.vo.ReceiveMessage;
import com.kh.wehub.message.model.vo.SendMessage;

@Mapper
public interface MessageDao {

	int getMessageCount(Map<String, Object> map);

	int deleteMessage(int receiveNo);
	
	int sendMsg(SendMessage sendMessage);
	
	int recMsg(ReceiveMessage recMsg);
	
	int getSendMessageCount(Map<String, Object> map);
	
	int deleteSendMessage(int sendNo);
	
	Member getSender(Map<String, Object> map);
	
	List<ReceiveMessage> selectMessageList(RowBounds rowBounds, Map<String, Object> map);

	List<Member> getSearchMember(String user_name);

	List<SendMessage> selectSendMsgList(RowBounds rowBounds, Map<String, Object> map);

	int deleteCheckMsg(List<Integer> checkList);

	int deleteCheckSendMsg(List<Integer> checkList);

	int getDeletedMessageCount(Map<String, Object> map);

	List<ReceiveMessage> selectDeletedMsgList(RowBounds rowBounds, Map<String, Object> map);

	int deletedMsgDelete(int receiveNo);

	int deleteCheckDeletedMsg(List<Integer> checkList);

}
