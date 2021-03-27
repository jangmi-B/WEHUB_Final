package com.kh.wehub.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private int user_no;
	
	private String user_companyname;
	
	private String user_id;
	
	private String user_pwd;
	
	private String user_name;
	
	private String rank;
	
	private String email;
	
	private int comcall;
	
	private int phone;
	
	private String address;
	
	private String user_status;
	
	private String member_image;
	
	private String dept_code;
	
	// 부서 이름 가져오기 위해서
	private String dept_name;
	
	
}