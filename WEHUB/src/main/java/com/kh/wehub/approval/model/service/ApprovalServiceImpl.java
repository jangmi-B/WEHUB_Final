package com.kh.wehub.approval.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.approval.model.dao.ApprovalDao;
import com.kh.wehub.approval.model.vo.Approval;
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
	public List<Approval> getApprovalList(Member loginMember) {
		
		return approvalDao.selectApprovalList(loginMember);
	}

}
