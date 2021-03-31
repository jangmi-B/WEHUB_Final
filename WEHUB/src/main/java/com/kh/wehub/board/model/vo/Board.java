package com.kh.wehub.board.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int boardNo;
	
	private String userId;
	
	private int boardWriterNo;
	
	private String userName;

	private String boardContent;

	private String status;

	private List<Reply> replies; 
	
	private Date boardCreateDate;
	
	private Date boardModifyDate;
	
	private String memberImage;
	
	private String dept_name;
}
