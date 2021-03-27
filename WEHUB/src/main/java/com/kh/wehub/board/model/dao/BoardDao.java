package com.kh.wehub.board.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.board.model.vo.Reply;

@Mapper
public interface BoardDao {
	
	List<Board> selectBoardList(Board board);

	int insertBoard(Board board);

	int updateBoard(Board board);

	Board selectBoardDetail(int boardNo);

	int deleteBoard(int boardNo);

	List<Reply> selectBoardReplyList(Reply reply);

}
