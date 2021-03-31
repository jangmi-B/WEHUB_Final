package com.kh.wehub.message.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.message.model.vo.ReceiveMessage;

public interface MessageService {

	int getSendMsgCount(Map<String, Object> map);

	List<ReceiveMessage> getSendList(PageInfo pageInfo, Map<String, Object> map);

	
}
