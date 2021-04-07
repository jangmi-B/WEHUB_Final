package com.kh.wehub.approval.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.approval.model.vo.App_Leave;
import com.kh.wehub.approval.model.vo.Approval;

@Mapper
public interface ApprovalDao {

	int writeApproval(Approval approval);
	
	int writeApproval(App_Leave writeAppLeave);
}
