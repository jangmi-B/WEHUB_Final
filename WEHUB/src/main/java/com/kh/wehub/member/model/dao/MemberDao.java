package com.kh.wehub.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.member.model.vo.PageInfo;

@Mapper
public interface MemberDao {

	public Member selectMember(String userId);

	public Integer infoCount();

	public List<Member> MemberInfo(@Param("start") int startList,@Param("end") int endList);


}
