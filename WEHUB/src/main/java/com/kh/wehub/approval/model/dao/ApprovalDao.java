package com.kh.wehub.approval.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface ApprovalDao {

	int approvalCount_YET(Member loginMember);
	int approvalCount_UNDER(Member loginMember);
	int approvalCount_DONE(Member loginMember);

	List<Approval> selectRecentList(Member loginMember);
	
	List<Approval> selectApprovalList(Member loginMember);

	
}
