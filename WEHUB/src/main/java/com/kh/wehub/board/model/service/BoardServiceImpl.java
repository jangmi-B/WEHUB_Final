package com.kh.wehub.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.wehub.board.model.dao.BoardDao;
import com.kh.wehub.board.model.vo.Comments;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;

	@Override
	public int getBoardCount(String searchText) {
		
		return boardDao.noticeCount(searchText);
	}

	@Override
	public List<Notice> getNoticeList(PageInfo pageInfo, String searchText) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return boardDao.selectNoticeList(rowBounds,searchText);
	}
	
	@Override
	public List<Notice> getStaticList() {
		
		return boardDao.selectStaticNotice();
	}

	@Override
	@Transactional
	public int saveBoard(Notice notice) {
		int result = 0;
		
		if(notice.getNoticeNo() != 0) {
			result = boardDao.updateNotice(notice);
		} else {
			result = boardDao.insertNotice(notice);
		}
		
		return result;
	}

	@Override
	public Notice findNoticeByNo(int noticeNo) {
		
		
		return boardDao.selectNoticeDetail(noticeNo);
	}

	@Override
	@Transactional
	public int deleteNotice(Notice notice) {
		
		return boardDao.deleteNotice(notice);
	}

	@Override
	public int updateReadCount(Map<String, Object> map) {
		
		return boardDao.updateReadCount(map);
	}

	@Override
	@Transactional
	public int saveComments(Comments comment, Member member) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("commentNoticeNo", comment.getCommentNoticeNO());
		map.put("userName", member.getUser_no());
		map.put("commentContent", comment.getCommentContent());
		
		return boardDao.insertComments(map);
	}

	@Override
	public List<Comments> findComments(int noticeNo) {
		
		return boardDao.selectComments(noticeNo);
	}

	@Override
	public int getCommentsCount(int noticeNo) {
		
		return boardDao.selectCommentsCount(noticeNo);
	}

	@Override
	public List<Member> findCommentName(int noticeNo) {
		
		return boardDao.findCommentsName(noticeNo);
	}

	@Override
	public int updateComments(int commentsNo, String comments) {
		
		int result = 0;
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("comments", comments);
		map.put("commentsNo", commentsNo);
		
		
		result = boardDao.updateComments(map);
		
		return result;
	}

	@Override
	public int deleteComments(int commentsNo) {
		
		int result = 0;
		
		result = boardDao.deleteComments(commentsNo);
		
		return result;
	}




}
