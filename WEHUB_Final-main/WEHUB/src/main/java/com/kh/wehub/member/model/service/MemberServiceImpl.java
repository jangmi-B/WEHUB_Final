package com.kh.wehub.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.wehub.member.model.dao.MemberDao;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.member.model.vo.MemberEnroll;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
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
	public int saveMember(MemberEnroll member) {
		int result = 0;

		if(member.getUser_no() != 0) {
//			result = memberDao.updateMember(member);
		} else {
			member.setUser_pwd(passwordEncoder.encode(member.getUser_pwd()));
			result = memberDao.insertMember(member);
		}
		return result;
	}

}