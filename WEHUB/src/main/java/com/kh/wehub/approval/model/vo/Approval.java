package com.kh.wehub.approval.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Approval {
   
   // Approval
   private int userNo;
   
   private String deptName;
   
   private String userName;
   
   private int rowNum;
   
   private String rank;
   
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
   
   
   // App_Receive_Ref
   private int receiveRefNo;
    
   private int refAppNo;
    
   private int receiveCc;
   
   
   // App_Loa
   private int loaNo; // LOA 시퀀스
    
   private int loaAppNo; // APP 시퀀스
    
   private String loaTltle; // 제목
    
   private String loaDetale; // 상세내용
    
   private String loaStatus;
    
   private String loaPresent; // 결재현황
   
   
   // App_Leave
   private int leaveNo;
   
   private int leaveAppNo;
   
   private String leaveClassify; // 휴가구분
   
   private Date leaveStart;
   
   private Date leaveFinish;
   
   private String leaveDetail;
   
   private String leaveStatus; //문서상태
   
   private String leavePreasent; // 결재상태
   
   private String appEmergncyCall; // 비상연락망
   
   // App_ER
   private int reNo;
   
   private int reAppNo;
   
   private Date reDeadline;
   
   private String reSlassify; // 계정과목
   
   private String trTitle;
   
   private String reDetail; // 적요
   
   private String reAmount; // 금액
   
   private String reReference; // 비고
   
   private String reStatus; // 문서상태
   
   private String rePresent; // 결재상태
   
}