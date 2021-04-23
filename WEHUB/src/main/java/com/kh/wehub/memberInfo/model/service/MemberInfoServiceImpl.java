package com.kh.wehub.memberInfo.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.memberInfo.model.dao.MemberInfoDao;

@Service
public class MemberInfoServiceImpl implements MemberInfoService {

	@Autowired
	private MemberInfoDao memberInfoDao;

	@Override
	public int infoCount() {
		
		return memberInfoDao.infoCount();
	}
	
	@Override
	public List<Member> SearchList(PageInfo info, String searchList, String searchText) {
		int offset = (info.getCurrentPage() - 1) * info.getListLimit();
		
		RowBounds rowBounds = new RowBounds(offset, info.getListLimit());
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("searchList", searchList);
		map.put("searchText", searchText);
		
		return memberInfoDao.SearchList(rowBounds, map);
	}

	@Override
	public int infoSearchCount(String searchList, String searchText) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("searchList", searchList);
		map.put("searchText", searchText);
		
		return memberInfoDao.SearchCount(map);
	}

	@Override
	public int insertMember(String newName, String newRank, String newDept) {

		int result = 0;
		
		result = memberInfoDao.insertMember(newName, newRank, newDept);
		
		return result;
	}


	



}
