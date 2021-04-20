package com.kh.wehub.schedule.model.vo;

import java.sql.Date;
//import java.util.Date;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeptData {

	/*
	 * @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd") private Date
	 * d_schedule_date ;
	 * 
	 * @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd") private Date
	 * startday;
	 * 
	 * @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd") private Date
	 * endday;
	 */
	//@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd hh:mm:ss")
	private String leave_start;
	//@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd hh:mm:ss")
	private String leave_finish;
	
	private String leave_classify;
	private String er_deadline;
	private String er_title;

	private int user_no;
	private int app_writer_no;
	private int APP_SEQ;
	private int leave_app_seq;
	private String user_name;
	private String dept_name;
	private String dept_code;

	
}
