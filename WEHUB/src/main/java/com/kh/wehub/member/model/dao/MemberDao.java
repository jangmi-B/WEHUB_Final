package com.kh.wehub.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface MemberDao {


	//String selectMember(String userId);
	Member selectMember(@Param("user_id") String user_id) ;
	
	Member selectMemberPwd(@Param("user_pwd") String user_pwd) ;// 현재 비밀번호 체크
	
	String findID(Member member);

	String findPWD(Member member);

	int insertMember(Member member);

	int updateMember(Member member);
	
	int updateMemberPass(Member member);

	int deleteMember(@Param("user_id")String userId);

	int GetKey(String user_id, String user_key); // 유저 인증키 생성 메서드

	int searchPassword(@Param("user_id")String user_id, @Param("email")String email,@Param("key") String key);// 회원 임시 비밀번호 변경 메서드

	List<Member> getSearchMemberApp(String user_name);
}

