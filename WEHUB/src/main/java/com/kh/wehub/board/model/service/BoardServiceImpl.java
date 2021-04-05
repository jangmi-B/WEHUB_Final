package com.kh.wehub.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<Board> selectBoardDetail(String keyword) {
		
		return boardDao.selectBoardDetail(keyword);
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
	
		return boardDao.selectBoardList(boardNo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		
		return boardDao.deleteBoard(boardNo);
	}


	@Override
	public List<Reply> getBoardReplyList(Reply reply) {

		return boardDao.selectBoardReplyList(reply);
	}

	@Override
	public int saveReply(int boardNo, String replyContent, int user_no) {
		int result = 0;
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("replyContent", replyContent);
		map.put("boardNo", boardNo);
		map.put("user_no", user_no);
		
		result = boardDao.insertReply(map);

		
		return result;
	}

	@Override
	public Reply findReplyByNo(int replyNo) {
		
		return boardDao.selectReplyList(replyNo);
	}

	@Override
	public int updateReply(String replyContent, int replyNo) {
		
		
		return boardDao.updateReply(replyContent, replyNo);
	}

	@Override
	public int deleteReply(int replyNo) {
		
		return boardDao.deleteReply(replyNo);
	}

	@Override
	public List<Board> selectBoardDetail() {
		return boardDao.selectBoardDetail();
	}

	@Override
	public List<Board> infiniteScrollDown(Integer bnoToStart) {
		
		return boardDao.infiniteScrollDown(bnoToStart);
	}

	
	
}
