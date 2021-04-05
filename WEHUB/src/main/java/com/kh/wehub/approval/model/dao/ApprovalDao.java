package com.kh.wehub.approval.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.approval.model.vo.Approval;

@Mapper
public interface ApprovalDao {

	int selectApprovalMainCount();

	List<Approval> selectApprovalMainList();

	
}
