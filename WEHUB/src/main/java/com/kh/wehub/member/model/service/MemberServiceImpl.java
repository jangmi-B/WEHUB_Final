package com.kh.wehub.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.member.model.dao.MemberDao;
import com.kh.wehub.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public Member login(String userId, String userPwd) {
		
		Member loginMember = this.findMemberByUserIdForFreeBoard(userId);
		
		if(loginMember != null) {
			
			return loginMember;
		}else {
			return null;
		}
	}

	@Override
	public Member findMemberByUserIdForFreeBoard(String userId) {
		return memberDao.selectMemberForFreeBoard(userId);
	}


	@Override
	public List<Member> selectMemberAllForApproval(String userId) {
		
		return memberDao.selectMemberAllForApproval(userId);
	}


	@Override
	public List<Member> selectSearchedMemberForApproval(String searchData, String userId) {
		
		return memberDao.selectSearchedMemberForApproval(searchData, userId);
	}
	
	@Override
	public List<Member> getSearchMemberForApproval(String user_name) {
		
		return memberDao.getSearchMemberForApproval(user_name);
	}

}