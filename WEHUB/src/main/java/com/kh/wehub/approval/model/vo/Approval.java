package com.kh.wehub.approval.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Approval {
	
	private int userNo;

	private String deptName;
	
	private String userName;
	
	private int rowNum;
	
	private String rank;
	
	
	// approval

	private int appNo;
	
	private int appWriterNo;
	
	private Date appWriteDate;
	
	private String firstApprover;
	
	private String interimApprover;
	
	private String finalApprover;
	
	private Date appCheckSysdate;
	
	private String appCheckProgress;
	
	private String appReason;
	
	private String appOriginalFileName;
	
	private String appRenameFileName;
	
	private String appKinds;
	
	
	// letterOfApproval
	
	private String loaTitle;
	
	private String loaContent;
	
	private int loaAppNo;
	
	
	// 수신참조
	
	private int receiveRefAppNo;
	
	private String referList;
	
}
