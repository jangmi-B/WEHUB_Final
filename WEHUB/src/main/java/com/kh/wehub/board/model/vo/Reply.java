package com.kh.wehub.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	private int replyNO;
	
	private int boardNO;
	
	private String userId;
	
	private String replyContent;	
	
	private String status;
	
	private Date replyCreateDate;
	
	private Date replyModifyDate;
}



