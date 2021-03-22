package com.kh.wehub.memberInfo.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

public interface MemberInfoService {

	int infoCount();

	List<Member> SearchList(PageInfo info, String searchList, String searchText);



}
