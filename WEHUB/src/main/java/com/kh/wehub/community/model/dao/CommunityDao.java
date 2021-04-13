package com.kh.wehub.community.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.community.model.vo.Community;
import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface CommunityDao {

	int communityCount(String searchText);
	
	List<Community> selectList(RowBounds rowBounds, String searchText);
	
	Community selectView(int no);

	int insert(HashMap<Object, Object> map);

	int updateReadCount(Map<String, Object> map);

	int updateList(HashMap<Object, Object> map);

	int deleteList(int no);

	int CountMyPage(int user_no);

	List<Community> selectMyList(RowBounds rowBounds, String userId);







}
