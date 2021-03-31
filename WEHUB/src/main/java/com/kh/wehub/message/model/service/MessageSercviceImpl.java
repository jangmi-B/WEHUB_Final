package com.kh.wehub.message.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.board.model.dao.BoardDao;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.message.model.dao.MessageDao;
import com.kh.wehub.message.model.vo.ReceiveMessage;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MessageSercviceImpl implements MessageService {
	
	@Autowired
	private MessageDao MessageDao;

	@Override
	public int getSendMsgCount(Map<String, Object> map) {
		
		return MessageDao.getMessageCount(map);
	}

	@Override
	public List<ReceiveMessage> getSendList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return MessageDao.selectMessageList(rowBounds, map);
	}

}
