package com.kh.wehub.approval.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.approval.model.dao.ApprovalDao;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	private ApprovalDao approvalDao;

	// Count =======================================
	
	@Override
	public int approvalCount_YET(Member loginMember) {
		
		return approvalDao.approvalCount_YET(loginMember);
	}
	
	@Override
	public int approvalCount_UNDER(Member loginMember) {
		
		return approvalDao.approvalCount_UNDER(loginMember);
	}
	
	@Override
	public int approvalCount_DONE(Member loginMember) {
		
		return approvalDao.approvalCount_DONE(loginMember);
	}

	// List =======================================
	
	@Override
	public List<Approval> getRecentList(Member loginMember) {
		
		return approvalDao.selectRecentList(loginMember);
	}
	
	@Override
	public List<Approval> getRecentList1(Member loginMember) {
		
		return approvalDao.selectRecentList1(loginMember);
	}

	@Override
	public List<Approval> getApprovalList(PageInfo pageInfo, String searchText) {
		
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return approvalDao.selectApprovalList(rowBounds,searchText);
	}

	@Override
	public int getListCount(String searchText) {
		
		return approvalDao.listCount(searchText);
	}

	@Override
	public int saveLetterOfApproval(Approval approval) {
		int result = 0;
		
		result = approvalDao.insertLetterOfApproval(approval);
		
		return result;
	}

	@Override
	public int saveLetterOfApproval2(Approval approval) {
		int result = 0;
		
		result = approvalDao.insertLetterOfApproval2(approval);
		
		return result;
	}

	@Override
	public int saveLetterOfApproval3(Approval approval) {
		int result = 0;
		
		result = approvalDao.insertLetterOfApproval3(approval);
		
		return result;
	}

	@Override
	public Approval findListByNo(int appNo) {
		
		return approvalDao.selectApprovalListDetail(appNo);
	}

	@Override
	public int rejectUpdate(Approval approval) {
		int result = 0;
		
		result = approvalDao.rejectUpdate(approval);
		
		return result;
	}

	@Override
	public int loaApproved1(int appNo) {
		int result = 0;
		
		result = approvalDao.loaApproved1(appNo);
		
		return result;
	}
	
	@Override
	public int loaApproved2(int appNo) {
		int result = 0;
		
		result = approvalDao.loaApproved2(appNo);
		
		return result;
	}

	@Override
	public int loaApproved3(int appNo) {
		int result = 0;
		
		result = approvalDao.loaApproved3(appNo);
		
		return result;
	}
}
