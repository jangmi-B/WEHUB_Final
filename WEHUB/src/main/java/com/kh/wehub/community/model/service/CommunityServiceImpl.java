package com.kh.wehub.community.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.community.model.dao.CommunityDao;
import com.kh.wehub.community.model.vo.Community;
import com.kh.wehub.member.model.vo.Member;

@Service
public class CommunityServiceImpl implements CommunityService {
	
	@Autowired
	private CommunityDao dao;

	@Override
	public List<Community> selectList(PageInfo pageInfo, String searchText, int userNo) {
		
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("searchText", searchText);
		map.put("userNo", userNo);
		
		return dao.selectList(rowBounds, map);
	}

	@Override
	public Community selectView(@Param("no") int no, @Param("userNo")int userNo) {
		
		return dao.selectView(no, userNo);
	}

	@Override
	public int insert(String title, String text, int user_no) {
		int result = 0;
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("title", title);
		map.put("text", text);
		map.put("user_no", user_no);
		
		result = dao.insert(map);
		
		
		return result;
	}

	@Override
	public int getCommunityCount(String searchText) {
		return dao.communityCount(searchText);
	}

	@Override
	public int updateReadCount(Map<String, Object> map) {
		return dao.updateReadCount(map);
	}

	@Override
	public int update(String title, String text, int no) {
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("title", title);
		map.put("text", text);
		map.put("no", no);
		
		int result = dao.updateList(map);
		
		return result;
	}

	@Override
	public int delete(int no) {
		
		return dao.deleteList(no);
	}

	@Override
	public int getCommunityCount_MyPage(int user_no) {
		
		return dao.CountMyPage(user_no);
	}

	@Override
	public List<Community> selectMyList(PageInfo pageInfo, Member loginMember) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		String userId = loginMember.getUser_id();
		
		return dao.selectMyList(rowBounds, userId);
	}

	@Override
	public int insertMark(@Param("no") int no, @Param("userNo")int userNo) {
		
		return dao.insertMark(no, userNo);
	}

	@Override
	public int deleteMark(@Param("no") int no, @Param("userNo")int userNo) {
		return dao.deleteMark(no, userNo);
	}

	@Override
	public int getCommunityCount_favPage() {
		return dao.getCommunityCount_favPage();
	}

	@Override
	public List<Community> selectFavList(PageInfo pageInfo, int user_no) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return dao.favList(rowBounds, user_no);
	}

	@Override
	public List<Community> selectMainList() {
		return dao.selectMainList();
	}

	@Override
	public Community updateView(@Param("no")int no,@Param("user_no") int user_no) {
		return dao.updateView(no,user_no);
	}



}
