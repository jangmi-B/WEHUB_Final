package com.kh.wehub.member.model.service;

import java.util.List;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.member.model.vo.PageInfo;

public interface MemberService {

	Member login(String userId, String userPwd);

	Member findMemberByUserId(String userId);

	List<Member> MemberInfo(int startList, int endList);

	int infoCountList();

	


}
