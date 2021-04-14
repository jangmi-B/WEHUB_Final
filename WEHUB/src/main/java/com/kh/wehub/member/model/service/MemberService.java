//package com.kh.wehub.member.model.service;
//
//import com.kh.wehub.member.model.vo.Member;
//
//public interface MemberService {
//
//	Member login(String userId, String userPwd);
//
//	boolean validate(String userId);
//
//	Member findMemberByUserId(String userId);
//
//	int saveMember(Member member);
//
//}

package com.kh.wehub.member.model.service;

import java.util.List;

import com.kh.wehub.member.model.vo.Member;

public interface MemberService {

	Member login(String userId, String userPwd);

	Member findMemberByUserId(String userId);

	String findID(Member member);

	//String findPWD(Member member);
	
	int saveMember(Member member);
	
	int updateUserPassword(Member member);
	
	int deleteMember(String userId);
	
	boolean validate(String userId);
	
	Member findMemberByUserIdForFreeBoard(String userId);

	List<Member> selectMemberAllForApproval(String userId);

	List<Member> selectSearchedMemberForApproval(String searchData, String userId);

	List<Member> getSearchMemberForApproval(String userName);
	
	List<Member> getSearchMember(String userName); // Approval 자동완성

}

