package com.kh.wehub.approval.model.dao;

//import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.approval.model.vo.Approval;
//import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface ApprovalDao {

	int insertApproval(Approval approval);
	
	int insertAppLeave(Approval writeAppLeave);

//	List<Member> getSearchMemberApp(String user_name); //쪽지 자동완성

	int insertReceiveRef(Approval appReceiveRef);

	int insertLOA(Approval appLoa);

}
