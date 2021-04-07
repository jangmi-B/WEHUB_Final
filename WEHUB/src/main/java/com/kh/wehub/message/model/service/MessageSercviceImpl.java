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
import com.kh.wehub.message.model.vo.Message;
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
	public List<Message> getReceiveList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectMessageList(rowBounds, map);
	}

	@Override
	@Transactional
	public int deleteMsg(int msgNo) {
		
		return MessageDao.deleteMessage(msgNo);
	}
	
	@Override
	public int readCheckMsg(int msgNo) {
		
		return MessageDao.readCheckMsg(msgNo);
	}
	
	@Override
	public int saveSelected(List<Integer> checkList) {
		
		return MessageDao.saveSelected(checkList);
	}
	
	@Override
	public List<Member> getSearchMember(String user_name) {
		
		return MessageDao.getSearchMember(user_name);
	}

	@Override
	@Transactional
	public int sendMsg(Message Message) {
		
		int result = 0;
		
		result = MessageDao.sendMsg(Message);
		
		return result;
	}

	@Override
	public Member getReceiver(Map<String, Object> map) {
		
		return MessageDao.getReceiver(map);
	}

	@Override
	public int getSendMsgCount(Map<String, Object> map) {
		
		return MessageDao.getSendMessageCount(map);
	}

	@Override
	public List<Message> getSendList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectSendMsgList(rowBounds, map);
	}

	@Override
	@Transactional
	public int deleteSendMsg(int msgNo) {
		
		return MessageDao.deleteSendMessage(msgNo);
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
	public List<Message> getDeletedList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectDeletedMsgList(rowBounds, map);
	}

	@Override
	@Transactional
	public int deletedMsgDelete(int msgNo) {
		
		return MessageDao.deletedMsgDelete(msgNo);
	}

	@Override
	public int deleteCheckDeletedMsg(List<Integer> checkList) {
		
		return MessageDao.deleteCheckDeletedMsg(checkList);
	}

	@Override
	public int readCheckSelected(List<Integer> checkList) {
		
		return  MessageDao.readCheckSelected(checkList);
	}

	@Override
	public List<Message> getSaveList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectRecSaveList(rowBounds, map);
	}

	@Override
	public List<Message> getSaveSendList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.saveSendMsgList(rowBounds, map);
	}

	@Override
	public int saveSendSelected(List<Integer> checkList) {
		
		return MessageDao.saveSendSelected(checkList);
	}

	@Override
	public int getSaveRecCount(Map<String, Object> map) {
		
		return MessageDao.getSaveRecCount(map);
	}

	@Override
	public int saveSendMsgCount(Map<String, Object> map) {
		
		return MessageDao.saveSendMsgCount(map);
	}


}
