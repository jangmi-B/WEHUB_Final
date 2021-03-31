package com.kh.wehub.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.board.model.vo.Reply;

@Mapper
public interface BoardDao {
	
	List<Board> selectBoardList();
	
	Board selectBoardList(int boardNo);
	
	List<Board> selectBoardDetail();

	int insertBoard(Board board);

	int updateBoard(Board board);

	Board selectBoardDetail(int boardNo);

	int deleteBoard(int boardNo);

	List<Reply> selectBoardReplyList(Reply reply);

	int updateReply(Reply reply);

	int insertReply(Map<Object, Object> map);

	Reply selectReplyList(int replyNo);

	int deleteReply(int replyNo);

}
