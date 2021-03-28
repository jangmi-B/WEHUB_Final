package com.kh.wehub.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.board.model.dao.BoardDao;
import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.board.model.vo.Reply;

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
			
			System.out.println("이건 업데이트_Implements 메소드 board.getBoardNo() : " + board.getBoardNo());
			result = boardDao.updateBoard(board);
		} else {
			System.out.println("이건 인서트_Implements 메소드 board.getBoardNo() : " + board.getBoardNo());
			result = boardDao.insertBoard(board);
		}
		
		return result;
	}

	@Override
	public Board findBoardByNo(int boardNo) {
	
		return boardDao.selectBoardDetail(boardNo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		
		return boardDao.deleteBoard(boardNo);
	}


	@Override
	public List<Reply> getBoardReplyList(Reply reply) {

		return boardDao.selectBoardReplyList(reply);
	}

	
	
}
