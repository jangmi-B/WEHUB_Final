package com.kh.wehub.message.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.wehub.board.model.dao.BoardDao;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.dao.MessageDao;
import com.kh.wehub.message.model.vo.ReceiveMessage;
import com.kh.wehub.message.model.vo.SendMessage;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MessageSercviceImpl implements MessageService {
	
	@Autowired
	private MessageDao MessageDao;

	@Override
	public int getMsgCount(Map<String, Object> map) {
		
		return MessageDao.getMessageCount(map);
	}

	@Override
	public List<ReceiveMessage> getReceiveList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectMessageList(rowBounds, map);
	}

	@Override
	@Transactional
	public int deleteMsg(int receiveNo) {
		
		return MessageDao.deleteMessage(receiveNo);
	}

	@Override
	public List<Member> getSearchMember(String user_name) {
		
		return MessageDao.getSearchMember(user_name);
	}

	@Override
	@Transactional
	public int sendMsg(SendMessage sendMessage) {
		
		int result = 0;
		
		result = MessageDao.sendMsg(sendMessage);
		
		return result;
	}

	@Override
	public Member getSender(Map<String, Object> map) {
		
		return MessageDao.getSender(map);
	}

	@Override
	@Transactional
	public int recMsg(ReceiveMessage recMsg) {
		int result = 0;
		
		result = MessageDao.recMsg(recMsg);
		
		return result;
	}

	@Override
	public int getSendMsgCount(Map<String, Object> map) {
		
		return MessageDao.getSendMessageCount(map);
	}

	@Override
	public List<SendMessage> getSendList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectSendMsgList(rowBounds, map);
	}

	@Override
	@Transactional
	public int deleteSendMsg(int sendNo) {
		
		return MessageDao.deleteSendMessage(sendNo);
	}

	@Override
	@Transactional
	public int deleteCheckMsg(List<Integer> checkList) {
		
		return MessageDao.deleteCheckMsg(checkList);
	}

	@Override
	@Transactional
	public int deleteCheckSendMsg(List<Integer> checkList) {
		
		return  MessageDao.deleteCheckSendMsg(checkList);
	}

	@Override
	public int getDeletedMsgCount(Map<String, Object> map) {
		
		return MessageDao.getDeletedMessageCount(map);
	}

	@Override
	public List<ReceiveMessage> getDeletedList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectDeletedMsgList(rowBounds, map);
	}

	@Override
	@Transactional
	public int deletedMsgDelete(int receiveNo) {
		
		return MessageDao.deletedMsgDelete(receiveNo);
	}

	@Override
	public int deleteCheckDeletedMsg(List<Integer> checkList) {
		
		return MessageDao.deleteCheckDeletedMsg(checkList);
	}

	@Override
	public int readCheckMsg(int msgNo) {
		
		return MessageDao.readCheckMsg(msgNo);
	}

	@Override
	public int readCheckSelected(List<Integer> checkList) {
		
		return  MessageDao.readCheckSelected(checkList);
	}

}
