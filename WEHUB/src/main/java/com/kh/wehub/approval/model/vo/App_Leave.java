package com.kh.wehub.approval.model.vo;

import java.util.Date;

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
	
	private Date laeveStart;
	
	private Date laeveFinish;
	
	private String laeveDetale; //문서상태
	
	private String laevePreasent; // 결재상태

}
