package com.kh.wehub.member.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.wehub.member.model.vo.Member;



@Mapper
public interface MemberDao {

     //String selectMember(String userId);
      Member selectMember(@Param("user_id") String user_id) ;
	

      String findID(Member member);

      String findPWD(Member member);


	int insertMember(Member member);

	public int updateMember(Member member);


}

