package com.kh.wehub.approval.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.approval.model.dao.ApprovalDao;
import com.kh.wehub.approval.model.vo.Approval;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	private ApprovalDao approvalDao;

	@Override
	public int getApprovalMainCount() {
		
		return approvalDao.selectApprovalMainCount();
	}

	@Override
	public List<Approval> getApprovalMainList() {
		
		return approvalDao.selectApprovalMainList();
	}

}
