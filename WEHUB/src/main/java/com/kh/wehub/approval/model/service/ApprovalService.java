package com.kh.wehub.approval.model.service;

import java.util.List;

import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

public interface ApprovalService {

	int approvalCount_YET(Member loginMember);
	int approvalCount_UNDER(Member loginMember);
	int approvalCount_DONE(Member loginMember);

	List<Approval> getRecentList(Member loginMember);
	
	List<Approval> getApprovalList(Member loginMember);
	
	
	

}
