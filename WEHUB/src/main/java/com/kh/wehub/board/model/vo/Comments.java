package com.kh.wehub.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comments {

	private int commentNo;
	
	private int commentNoticeNO;
	
	private int commentWriterNo;
	
	private String userName;
	
	private String commentContent;	
	
	private Date commentCreateDate;
	
	private Date commentModifyDate;
	
	private String status;

}
