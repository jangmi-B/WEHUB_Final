package com.kh.wehub.board.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.board.model.vo.Notice;

@Mapper
public interface BoardDao {

	int noticeCount();

	List<Notice> selectNoticeList(RowBounds rowBounds);

	int updateNotice(Notice notice);

	int insertNotice(Notice notice);

	Notice selectNoticeDetail(int noticeNo);

}
