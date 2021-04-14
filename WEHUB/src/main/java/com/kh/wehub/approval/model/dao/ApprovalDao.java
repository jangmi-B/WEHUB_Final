package com.kh.wehub.approval.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

@Mapper
public interface ApprovalDao {

	int approvalCount_YET(Member loginMember);
	int approvalCount_UNDER(Member loginMember);
	int approvalCount_DONE(Member loginMember);

	List<Approval> selectRecentList(Member loginMember);	
	List<Approval> selectRecentList1(Member loginMember);

	List<Approval> selectApprovalList(RowBounds rowBounds, String searchText);
	
	int listCount(String searchText);

	int insertLetterOfApproval(Approval approval);
	int insertLetterOfApproval2(Approval approval);
	int insertLetterOfApproval3(Approval approval);

	Approval selectApprovalListDetail(int appNo);

	int rejectUpdate(Approval approval);

	int loaApproved1(int appNo);
	int loaApproved2(int appNo);
	int loaApproved3(int appNo);
	
	// 휴가신청서 등록
	int insertApproval(Approval approval);
	int insertAppLeave(Approval approval);
	int insertReceiveRef(Approval approval);
	
}
