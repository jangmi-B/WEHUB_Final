package com.kh.wehub.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.member.model.vo.MemberEnroll;


@Mapper
public interface MemberDao {

	public Member selectMember(String userId);

	public String findID(Member member);

	public String findPWD(Member member);


	int insertMember(Member member);

	public int updateMember(Member member);


}

