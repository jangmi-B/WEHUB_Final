package com.kh.wehub.member.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface MemberDao {

	//public Member selectMember(String userId);
	Member selectMember(@Param("id") String id) ;
	public int updateMember(Member member);

	public int insertMember(Member member); 
}