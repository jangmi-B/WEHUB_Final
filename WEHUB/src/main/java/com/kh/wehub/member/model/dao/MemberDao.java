package com.kh.wehub.member.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface MemberDao {

	public abstract Member selectMemberForFreeBoard(String userId);

	public List<Member> selectMemberAllForApproval(String userId);

	public List<Member> selectSearchedMemberForApproval(@Param("searchData") String searchData, @Param("userId") String userId);

	public List<Member> getSearchMemberForApproval(String user_name);

}