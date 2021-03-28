package com.kh.wehub.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.board.model.vo.Reply;

public interface BoardService {

	List<Board> getBoardList(Board board);

	int saveBoard(Board board);

	Board findBoardByNo(int boardNo);

	int deleteBoard(int boardNo);

	List<Reply> getBoardReplyList(Reply reply);
}
