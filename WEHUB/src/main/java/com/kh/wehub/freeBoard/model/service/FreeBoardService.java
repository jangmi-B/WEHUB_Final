package com.kh.wehub.freeBoard.model.service;

import java.util.List;

import com.kh.wehub.freeBoard.model.vo.Board;
import com.kh.wehub.freeBoard.model.vo.Reply;

public interface FreeBoardService {

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

	List<Board> infiniteScrollDown(int bnoToStart);

	List<Board> selectBoardDetail(int rownumdata);

	List<Board> selectBoardDetailKeyword(String keyword);

}
