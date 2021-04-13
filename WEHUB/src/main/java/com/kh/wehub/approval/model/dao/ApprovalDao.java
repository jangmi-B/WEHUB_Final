package com.kh.wehub.approval.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.App_Receive_Ref;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface ApprovalDao {

	int insertApproval(Approval approval);
	
	int insertAppLeave(App_Leave writeAppLeave);

	List<Member> getSearchMember(String user_name); //쪽지 자동완성

	int insertReceiveRef(App_Receive_Ref appReceiveRef);

}
