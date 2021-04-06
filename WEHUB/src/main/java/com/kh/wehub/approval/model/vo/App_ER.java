package com.kh.wehub.approval.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class App_ER {
	
	private int reNo;
	
	private int reAppNo;
	
	private Date reDeadline;
	
	private String reSlassify;
	
	private String trTitle;
	
	private String reDetail;
	
	private String reAmount;
	
	private String reReference;
	
	private String reStatus;
	
	private String rePresent;
	
}
