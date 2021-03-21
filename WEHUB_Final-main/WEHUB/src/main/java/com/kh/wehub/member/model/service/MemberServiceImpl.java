package com.kh.wehub.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.wehub.member.model.dao.MemberDao;
import com.kh.wehub.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public Member login(String userId, String userPwd) {

		Member loginMember = this.findMemberByUserId(userId);
		log.info("아이디찍어나 보자......"+userId);

//		if(loginMember != null) {
//
//			return loginMember;
//		}else {
//
//			return null;
//		}
		System.out.println("passwordEncoder  :" +passwordEncoder.encode(userPwd));
		return loginMember != null && 
				passwordEncoder.matches(userPwd, loginMember.getUser_pwd())? loginMember : null;
	}


	@Override
	public Member findMemberByUserId(String userId) {


		return memberDao.selectMember(userId);
	}


	@Override
	public boolean validate(String userId) {
		// TODO Auto-generated method stub
		return false;
	}
}