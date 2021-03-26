
//package com.kh.wehub.member.model.service;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.kh.wehub.member.model.dao.MemberDao;
//import com.kh.wehub.member.model.vo.Member;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Service
//@Slf4j
//public class MemberServiceImpl implements MemberService {
//
//	@Autowired
//	private MemberDao memberDao;
//	
////	@Autowired
////	private BCryptPasswordEncoder passwordEncoder;
//
//	@Override
//	public Member login(String userId, String userPwd) {
//
//		Member loginMember = this.findMemberByUserId(userId);
//		log.info("아이디찍어나 보자......"+userId);
//
////		if(loginMember != null) {
////
////			return loginMember;
////		}else {
////
////			return null;
////		}
////		System.out.println("passwordEncoder  :" +passwordEncoder.encode(userPwd));
////		return loginMember != null && 
////				passwordEncoder.matches(userPwd, loginMember.getUser_pwd())? loginMember : null;
//		
//		return loginMember.getUser_pwd().equals(userPwd)?loginMember:null;
//	}
//
//
//	@Override
//	public Member findMemberByUserId(String userId) {
//
//
//		return memberDao.selectMember(userId);
//	}
//
//
//	@Override
//	public boolean validate(String userId) {
//		// TODO Auto-generated method stub
//		return false;
//	}
//
//
//	@Override
//	@Transactional
//	public int saveMember(Member member) {
//	
//		
//		int result = 0;
//
//		if(member.getUser_no() != 0) {
//			result = memberDao.updateMember(member);
//		} else {
//			
//			member.setUser_pwd((member.getUser_pwd()));  // 비번 받아와서 암호화해서 set
//			result = memberDao.insertMember(member);			
////			if(true) {
////				throw new RuntimeException();
////			}
//			
//		}
//
//		return result;
//	}
//}

package com.kh.wehub.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.stereotype.Service;

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
	public String findPWD(Member member) {
		// TODO Auto-generated method stub
		return memberDao.findPWD(member);
	}



	public int saveMember(Member member) {
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