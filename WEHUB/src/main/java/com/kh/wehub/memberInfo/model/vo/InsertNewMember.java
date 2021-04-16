package com.kh.wehub.memberInfo.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InsertNewMember {

	private int new_no;
	
	private String new_name;
	
	private String new_rank;
	
	private String new_dept;
}