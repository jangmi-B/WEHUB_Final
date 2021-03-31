package com.kh.wehub.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	private int replyNo;
	
	private int boardNo;
	
	private int replyWriterNo;
	
	private String replyUserId;
	
	private String userName;
	
	private String replyContent;	
	
	private String status;
	
	private Date replyCreateDate;
	
	private Date replyModifyDate;
	
	private String memberImage;
}



