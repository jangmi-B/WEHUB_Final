package com.kh.wehub.freeBoard.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

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
	
	@JsonFormat(pattern="yyyy/MM/dd")
	private Date replyCreateDate;
	
	@JsonFormat(pattern="yyyy/MM/dd")
	private Date replyModifyDate;
	
	private String memberImage;
}



