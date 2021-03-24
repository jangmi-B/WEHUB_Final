package com.kh.wehub.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberEnroll {
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
	
	private Date create_date;
	
	private Date modify_date;

	private String user_status;

	private String dept_code;

}