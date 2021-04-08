package com.kh.wehub.approval.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface ApprovalDao {

	int writeApproval(Approval approval);
	
	int writeApproval(App_Leave writeAppLeave);

	List<Member> getSearchMember(String userName);
}
