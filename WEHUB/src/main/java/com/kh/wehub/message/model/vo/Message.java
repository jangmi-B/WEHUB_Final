package com.kh.wehub.message.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message {
	
	private int msgNo;
	
	private int msgTo;
	
	private int msgFrom;
	
	private String msgContent;
	
	private Date createDate;
	
	private Date deleteDate;
	
	private Date readDate;
	
	private String readStatus;
	
	private String status;
	
	private String sendStatus;
	
	private String userName;
	
	private String rank;
	
	private String deptName;
	
}
