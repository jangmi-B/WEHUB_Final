package com.kh.wehub.approval.model.service;

import java.util.List;

import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

public interface ApprovalService {

	int approvalCount_YET(Member loginMember);
	int approvalCount_UNDER(Member loginMember);
	int approvalCount_DONE(Member loginMember);

	List<Approval> getRecentList(Member loginMember);
	
	List<Approval> getApprovalList(PageInfo pageInfo, String searchText);
	
	int getListCount(String searchText);
	
	// LetterOfApproval 등록
	int saveLetterOfApproval(Approval approval);
	int saveLetterOfApproval2(Approval approval);
	int saveLetterOfApproval3(Approval approval);
	
	Approval findListByNo(int appNo);
	
	List<Approval> getRecentList1(Member loginMember);
	
	int rejectUpdate(Approval approval);
	
	int loaApproved1(int appNo);
	
	int loaApproved2(int appNo);

	int loaApproved3(int appNo);
	

}
