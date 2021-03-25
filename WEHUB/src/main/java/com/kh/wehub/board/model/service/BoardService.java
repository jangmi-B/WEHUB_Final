package com.kh.wehub.board.model.service;

import java.util.List;

import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.common.util.PageInfo;

public interface BoardService {

	int getBoardCount(String searchText);

	List<Notice> getNoticeList(PageInfo pageInfo, String searchText);

	int saveBoard(Notice notice);

	Notice findNoticeByNo(int noticeNo);

	int deleteNotice(Notice notice);



}
