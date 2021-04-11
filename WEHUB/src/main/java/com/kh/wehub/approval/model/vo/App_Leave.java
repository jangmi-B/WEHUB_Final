package com.kh.wehub.approval.model.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class App_Leave {
	
	private int leaveNo;
	
	private int leaveAppNo;
	
	private String leaveClassify; //휴가구분
	
	private String leaveStart;
	
	private String leaveFinish;
	
	private String leaveDetail;
	
	private String leaveStatus; //문서상태
	
	private String leavePreasent; // 결재상태
	
	private String appEmergncyCall; // 비상연락망

}
