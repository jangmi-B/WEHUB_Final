package com.kh.wehub.message.model.service;

import java.util.List;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.message.model.vo.ReceiveMessage;

public interface MessageService {

	int getSendMsgCount(int userNo);

	List<ReceiveMessage> getSendList(PageInfo pageInfo, int userNo);

	
}
