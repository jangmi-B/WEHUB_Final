package com.kh.wehub.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.member.model.dao.MemberDao;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.member.model.vo.PageInfo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public Member login(String userId, String userPwd) {
		
		Member loginMember = this.findMemberByUserId(userId);
		
		if(loginMember != null) {
			
			return loginMember;
		}else {
			return null;
		}
	}

	
	@Override
	public Member findMemberByUserId(String userId) {
		return memberDao.selectMember(userId);
	}

	@Override
	public int infoCountList() {
		System.out.println();
		
		System.out.println("memberDao : " + memberDao.infoCount());
		
		return memberDao.infoCount();
	}


	@Override
	public List<Member> MemberInfo(int startList, int endList) {
		
		
		return memberDao.MemberInfo(startList, endList);
	}
	



}
