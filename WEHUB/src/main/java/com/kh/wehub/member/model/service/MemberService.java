package com.kh.wehub.member.model.service;

import java.util.List;

import com.kh.wehub.member.model.vo.Member;

public interface MemberService {
	
	Member login(String userId, String userPwd);

	Member findMemberByUserIdForFreeBoard(String userId);

	List<Member> selectMemberAllForApproval(String userId);

	List<Member> selectSearchedMemberForApproval(String searchData, String userId);

	List<Member> getSearchMemberForApproval(String userName);

}