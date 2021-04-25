package com.kh.wehub.member.model.service;

import java.util.List;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memberInfo.model.vo.InsertNewMember;

public interface MemberService {

	Member login(String userId, String userPwd);

	Member findMemberByUserId(String userId);

	String findID(Member member);

	//String findPWD(Member member);
	
	int saveMember(Member member);
	
	int updateUserPassword(Member member);
	
	int deleteMember(String userId);
	
	boolean validate(String userId);
	
	InsertNewMember getNewMember(String userNo); //임시회원 찾아오기

	Member checkNewMem(String userNo);
	Member findMemberByUserIdForFreeBoard(String userId);

	List<Member> selectMemberAllForApproval(String userId);

	List<Member> selectSearchedMemberForApproval(String searchData, String userId);

	List<Member> getSearchMemberForApproval(String userName);
	
	List<Member> getSearchMember(String userName); // Approval 자동완성

	Member findUserInfo(String userId); // 회원수정 사번 갖고올때

}

