package com.kh.wehub.approval.model.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.wehub.approval.model.dao.ApprovalDao;
import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

@Service
public class ApprovalServiceImpl implements ApprovalService {

	@Override
	@Transactional
	public int insertApproval(Approval approval) {
		
//		return ApprovalDao.writeApproval(approval);
		return 0;
	}



}
