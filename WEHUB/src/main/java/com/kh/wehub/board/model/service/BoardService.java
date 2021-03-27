package com.kh.wehub.board.model.service;

import java.util.List;

import com.kh.wehub.board.model.vo.Board;

public interface BoardService {

	List<Board> getBoardList(Board board);

	int saveBoard(Board board);

	Board findBoardByNo(int boardNo);
	
}
