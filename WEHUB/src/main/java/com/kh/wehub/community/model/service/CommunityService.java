package com.kh.wehub.community.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.community.model.vo.Community;
import com.kh.wehub.member.model.vo.Member;

public interface CommunityService {

	List<Community> selectList(PageInfo pageInfo, String cM_searchText);

	Community selectView(int no);

	int insert(String title, String text, int user_no);

	int getCommunityCount(String cM_searchText);

	int updateReadCount(Map<String, Object> map);

	int update(String title, String text, int no);

	int delete(int no);

	int getCommunityCount_MyPage(int user_no);

	List<Community> selectMyList(PageInfo pageInfo,Member loginMember);


}
