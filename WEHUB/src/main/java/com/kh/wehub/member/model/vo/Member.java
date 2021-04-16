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

	private String comcall;

	private String phone;

	private String address;

	private String user_status;

	private String dept_code;
	
	private String dept_name;
	
	private String user_imgOriname;
	
	private String user_imgRename;
	
	private String userNewPwd; // 비빌번호 변경
	
	

  
}
