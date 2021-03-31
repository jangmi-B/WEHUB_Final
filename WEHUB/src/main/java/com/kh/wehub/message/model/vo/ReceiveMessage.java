package com.kh.wehub.message.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReceiveMessage {
	
	private int reciveNo;
	
	private int senderNo;
	
	private int receiverNo;
	
	private String receiveContent;
	
	private Date receiveDate;
	
	private Date deleteDate;
	
	private String senderName;
	
	private String rank;
	
	private String status;

}
