package com.kh.wehub.approval.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Approval {
   
   private int appNo;
   
   private Date appWriteDate;
   
   private String firstApprover;
   
   private String interimApprover;
   
   private String finalApprover;
   
   private Date appCheckSysdate; // 결재결과일시
   
   private String appReason; // 반려사유
   
   private String appOriginalFileName;
   
   private String appRenameFileName;
   
   private int AppWriterNo; //member.getUser_no
   
   private String appCheckProgress; //APP_CHECK_PROGRESS IN ('결재대기', '결재중', '결재완료')
   
   private String approvalKinds; // 결재 종류
   
}
