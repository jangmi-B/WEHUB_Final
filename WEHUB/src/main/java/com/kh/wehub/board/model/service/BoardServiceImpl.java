package com.kh.wehub.board.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.board.model.dao.BoardDao;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;

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
	public int deleteNotice(Notice notice) {
		
		return boardDao.deleteNotice(notice);
	}


}
