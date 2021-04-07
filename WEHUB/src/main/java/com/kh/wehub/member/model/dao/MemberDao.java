package com.kh.wehub.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface MemberDao {

	public Member selectMember(String userId);

	public List<Member> selectMemberAll(String userId);

	public List<Member> selectSearchedMember(@Param("searchData") String searchData, @Param("userId") String userId);

}