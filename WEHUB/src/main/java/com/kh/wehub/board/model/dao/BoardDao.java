package com.kh.wehub.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.board.model.vo.Comments;
import com.kh.wehub.board.model.vo.Notice;
import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface BoardDao {

	int noticeCount();

	List<Notice> selectNoticeList(RowBounds rowBounds);

	int updateNotice(Notice notice);

	int insertNotice(Notice notice);

	Notice selectNoticeDetail(int noticeNo);

	int insertComments(Map<Object, Object> map);

	List<Comments> selectComments(int noticeNo);

	int selectCommentsCount(int noticeNo);

	List<Member> findCommentsName(@Param("noticeNo") int noticeNo);

}
