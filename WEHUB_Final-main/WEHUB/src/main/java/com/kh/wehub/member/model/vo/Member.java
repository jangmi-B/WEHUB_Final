package com.kh.wehub.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private int USER_NO;
	private String USER_COMPANYNAME;
	private String USER_ID;
	private String USER_PWD;
	private String USER_NAME;
	private String COMPANY_RANK;
	private String  EMAIL;
	
	private int COMCALL;
	private int  PHONE;
	private String  ADDRESS;
	private String USER_STATUS;
	private String DEPT_CODE  ;

	
	

  
}
