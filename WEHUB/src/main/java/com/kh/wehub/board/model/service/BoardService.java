package com.kh.wehub.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.board.model.vo.Reply;
import com.kh.wehub.member.model.vo.Member;

public interface BoardService {

	List<Board> selectBoardDetail();

	int saveBoard(Board board);

	Board findBoardByNo(int boardNo);

	int deleteBoard(int boardNo);

	List<Reply> getBoardReplyList(Reply reply);

	int saveReply(int boardNo, String replyContent, int user_no);

	Reply findReplyByNo(int replyNo);

	int updateReply(Reply reply);

	int deleteReply(int replyNo);

}
