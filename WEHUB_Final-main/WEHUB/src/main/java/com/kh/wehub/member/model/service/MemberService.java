package com.kh.wehub.member.model.service;

import com.kh.wehub.member.model.vo.Member;

public interface MemberService {
	Member login(String userId, String userPwd);

	Member findMemberByUserId(String userId);

	int saveMember(Member member);

}
