package com.kh.wehub.community.model.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Community {

	private int rownum;
	
	private int cm_no;
	
	private int user_no;
	
	private String user_name;
	
	private String user_id;
	
	private String cm_title;
	
	private String cm_content;
	
	private int cm_readCount;
	
//	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date cm_date;
	
//	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date cm_modify_date;
	
	private String cm_Mark;
	
	private String cm_status;
	
}
