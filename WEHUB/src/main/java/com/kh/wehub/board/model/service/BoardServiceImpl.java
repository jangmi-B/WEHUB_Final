package com.kh.wehub.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.board.model.dao.BoardDao;
import com.kh.wehub.board.model.vo.Board;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao boardDao;

	@Override
	public List<Board> getBoardList(Board board) {
		
		return boardDao.selectBoardList(board);
	}

	@Override
	public int saveBoard(Board board) {
		int result = 0;
		
		if(board.getBoardNo() != 0) {
			result = boardDao.updateBoard(board);
		} else {
			result = boardDao.insertBoard(board);
		}
		
		return result;
	}

	@Override
	public Board findBoardByNo(int boardNo) {
	
		return boardDao.selectBoardDetail(boardNo);
	}
	
	
}
