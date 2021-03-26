package com.kh.wehub.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;

public interface BoardService {

	int getBoardCount(String searchText);

	List<Notice> getNoticeList(PageInfo pageInfo, String searchText);
	
	List<Notice> getStaticList();

	int saveBoard(Notice notice);

	Notice findNoticeByNo(int noticeNo);

	int deleteNotice(Notice notice);

	int updateReadCount(Map<String, Object> map);


}
