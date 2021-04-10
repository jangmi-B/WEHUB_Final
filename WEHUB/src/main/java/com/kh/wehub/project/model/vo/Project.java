package com.kh.wehub.project.model.vo;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Project {
	private int projectNo;
	
	private int projectMake;
	
	private String participant;
	
	private String projectTitle;
	
	private String projectContent;
	
	private Date startDate;
	
	private Date dueDate;
	
	private String status;
	
	private String userName;
	
	private int projectCount;
}
