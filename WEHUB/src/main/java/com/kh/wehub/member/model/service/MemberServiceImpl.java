package com.kh.wehub.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.wehub.member.model.dao.MemberDao;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memberInfo.model.vo.InsertNewMember;

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
		System.out.println(memberDao.findID(member));
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
	
	@Override
	public InsertNewMember getNewMember(String userNo) {
		
		return memberDao.getNewMember(userNo);
	}

	@Override
	public Member checkNewMem(String userNo) {
		
		return memberDao.checkNewMem(userNo);
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

	@Override
	public List<Member> getSearchMember(String user_name) {
		
		return memberDao.getSearchMemberApp(user_name);
	}
}


