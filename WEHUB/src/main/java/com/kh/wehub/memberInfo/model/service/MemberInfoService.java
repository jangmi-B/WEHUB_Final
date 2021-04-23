package com.kh.wehub.memberInfo.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

public interface MemberInfoService {

	int infoCount();

	List<Member> SearchList(PageInfo info, String searchList, String searchText);

	int infoSearchCount(String searchList, String searchText);

	int insertMember(@Param("newName") String newName, @Param("newRank") String newRank,@Param("newDept") String newDept);
}
