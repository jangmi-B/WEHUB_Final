package com.kh.wehub.message.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SendMessage {
	
	private int sendNo;
	
	private int senderNo;
	
	private int receiverNo;
	
	private String sendContent;
	
	private Date sendDate;
	
	private Date deleteDate;
	
	private String userName;
	
	private String rank;
	
	private String deptName;

	private String status;
	
}
