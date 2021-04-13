package com.kh.wehub.approval.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class App_Loa {
	
	 private int loaNo; // LOA 시퀀스
	 
	 private int loaAppNo; // APP 시퀀스
	 
	 private String loaTltle; // 제목
	 
	 private String loaDetale; // 상세내용
	 
	 private String loaStatus;
	 
	 private String loaPresent; // 결재현황
}
