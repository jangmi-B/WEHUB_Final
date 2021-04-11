package com.kh.wehub.approval.model.service;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.wehub.approval.model.dao.ApprovalDao;
import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.Approval;
import com.kh.wehub.member.model.vo.Member;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	private ApprovalDao approvalDao;

	@Override
	@Transactional
	public int insertApproval(Approval approval) {
		
		return approvalDao.insertApproval(approval);
	}

	@Override
	public int insertLeave(App_Leave appLeave) {
		
		return approvalDao.insertAppLeave(appLeave);
	}

	@Override
	public List<Member> getSearchMember(String user_name) {
		
		return approvalDao.getSearchMember(user_name);
	}



}
