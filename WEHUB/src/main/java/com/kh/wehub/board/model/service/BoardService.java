package com.kh.wehub.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.board.model.vo.Comments;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

public interface BoardService {

	int getBoardCount();

	List<Notice> getNoticeList(PageInfo pageInfo);

	int saveBoard(Notice notice);

	Notice findNoticeByNo(int noticeNo);

	//댓글 수
	int getCommentsCount(int noticeNo);
	
	int saveComments(Comments comment, Member member);

	List<Comments> findComments(int noticeNo);

	List<Member> findCommentName(int noticeNo);

	// 댓글 수정
	int updateComments(int commentsNo, String comments);
	// 댓글 삭제
	int deleteComments(int commentsNo);



}
