package com.kh.wehub.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.wehub.member.model.dao.MemberDao;
import com.kh.wehub.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public Member login(String userId, String userPwd) {
		
		Member loginMember = this.findMemberByUserId(userId);

		System.out.println("Impl에서 loginmember : "+loginMember);
		System.out.println("passwordEncoder  :" +passwordEncoder.encode(userPwd));
		
		System.out.println(loginMember != null && 
				passwordEncoder.matches(userPwd, loginMember.getUser_pwd())? loginMember : null);
		
		return loginMember != null && 
				passwordEncoder.matches(userPwd, loginMember.getUser_pwd())? loginMember : null;

	}
	
	@Override
	public Member findMemberByUserId(String userId) {
		
		return memberDao.selectMember(userId);
	}

	@Override
	public String findID(Member member) {
		// TODO Auto-generated method stub
		return memberDao.findID(member);
	}

	@Override
	@Transactional
	public int saveMember(Member member) {
		int result = 0;
		
		System.out.println();

		if(member.getUser_no() != 0) {
			result = memberDao.updateMember(member);
		} else {
			member.setUser_pwd(passwordEncoder.encode(member.getUser_pwd()));
			result = memberDao.insertMember(member);
		}
		return result;
	}
	
	@Override
	@Transactional
	public int deleteMember(String userId) {
		
		return memberDao.deleteMember(userId);
	}

	// 아이디 중복체크
	@Override
	public boolean validate(String userId) {
		Member member = this.findMemberByUserId(userId);
		
		return member != null;
	}
	
	@Override
	@Transactional
	public int updateUserPassword(Member member) {
		int result = 0;

		System.out.println("member.getUser_pwd() : " + member.getUser_pwd());
		member.setUser_pwd(passwordEncoder.encode(member.getUser_pwd()));
		System.out.println("Impl에서 member.getPass : " + member.getUser_pwd());
		
		result = memberDao.updateMemberPass(member);
		
		return result;
	}
	
}

	
