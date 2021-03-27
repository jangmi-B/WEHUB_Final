package com.kh.wehub.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface MemberDao {

	public Member selectMember(String userId);

}