package com.kh.wehub.message.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.message.model.vo.ReceiveMessage;

@Mapper
public interface MessageDao {

	int getMessageCount(int userNo);

	List<ReceiveMessage> selectMessageList(RowBounds rowBounds, int userNo);

}
