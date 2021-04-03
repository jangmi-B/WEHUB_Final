package com.kh.wehub.board.model.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.wehub.board.model.vo.Board;
import com.kh.wehub.board.model.vo.Reply;
import com.kh.wehub.member.model.vo.Member;

public interface BoardService {

	List<Board> selectBoardDetail(String keyword);

	int saveBoard(Board board);

	Board findBoardByNo(int boardNo);

	int deleteBoard(int boardNo);

	List<Reply> getBoardReplyList(Reply reply);

	int saveReply(int boardNo, String replyContent, int user_no);

	Reply findReplyByNo(int replyNo);

	int updateReply(String replyContent, int replyNo);

	int deleteReply(int replyNo);

	List<Board> selectBoardDetail();

}
