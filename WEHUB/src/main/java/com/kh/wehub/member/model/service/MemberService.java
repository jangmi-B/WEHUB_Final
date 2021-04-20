package com.kh.wehub.member.model.service;

import com.kh.wehub.member.model.vo.Member;
<<<<<<< HEAD
import com.kh.wehub.memberInfo.model.vo.InsertNewMember;
=======
>>>>>>> deptCalendar

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

}

