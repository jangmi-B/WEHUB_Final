package com.kh.wehub.community.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Community {

	private int cm_no;
	
	private int user_no;
	
	private String cm_title;
	
	private String cm_content;
	
	private int cm_readCount;
	
	private Date cm_date;
	
	private Date cm_modify_date;
	
	private String cm_status;
}
