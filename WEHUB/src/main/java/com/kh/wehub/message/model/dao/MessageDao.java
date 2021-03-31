package com.kh.wehub.message.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.message.model.vo.ReceiveMessage;

@Mapper
public interface MessageDao {

	int getMessageCount(Map<String, Object> map);

	List<ReceiveMessage> selectMessageList(RowBounds rowBounds, Map<String, Object> map);

}
