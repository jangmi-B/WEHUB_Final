package com.kh.wehub.member.model.service;

import java.util.List;

import com.kh.wehub.member.model.vo.Member;

public interface MemberService {

	Member login(String userId, String userPwd);

	Member findMemberByUserId(String userId);

	List<Member> selectMemberAll(String userId);

	List<Member> selectSearchedMember(String searchData, String userId);

	List<Member> getSearchMember(String userName);

}