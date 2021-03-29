package com.kh.wehub.board.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {

	private int rownum;
	
	private int noticeNo;
	
	private int noticeWriterNo;
	
	private String noticeUserName;
	
	private String department;
	
	private String userId;
	
	private String noticeTitle;
	
	private String noticeContent;
	
	private String noticeOriginalFileName;
	
	private String noticeRenamedFileName;
	
	private int noticeReadCount;
	
	private int noticCommentCount;
	
	private String status;
	
	private String noticeType;
	
	private List<Comments> comments;
	
	private Date noticeCreateDate;
	
	private Date noticeModifyDate;
}
