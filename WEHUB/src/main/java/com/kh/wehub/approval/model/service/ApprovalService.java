package com.kh.wehub.approval.model.service;

//import java.util.List;

import com.kh.wehub.approval.model.vo.Approval;
//import com.kh.wehub.member.model.vo.Member;

public interface ApprovalService {

	int insertApproval(Approval approval);

	int insertLeave(Approval appLeave);

//	List<Member> getSearchMember(String userName);

	int insertReceive(Approval appReceiveRef);

	int insertLoa(Approval appLoa);



}
