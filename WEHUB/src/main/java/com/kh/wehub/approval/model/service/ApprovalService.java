package com.kh.wehub.approval.model.service;

import java.util.List;

import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.App_Loa;
import com.kh.wehub.approval.model.vo.App_Receive_Ref;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

public interface ApprovalService {

	int insertApproval(Approval approval);

	int insertLeave(App_Leave appLeave);

	List<Member> getSearchMember(String userName);

	int insertReceive(App_Receive_Ref appReceiveRef);

	int insertLoa(App_Loa appLoa);



}
