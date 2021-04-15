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
   private int appNo;
   
   private Date appWriteDate;
   
   private String firstApprover;
   
   private String interimApprover;
   
   private String finalApprover;
   
   private Date appCheckSysdate; // 결재결과일시
   
   private String appReason; // 반려사유
   
   private String appOriginalFileName;
   
   private String appRenameFileName;
   
   private int appWriterNo; //member.getUser_no
   
   private String appCheckProgress; //APP_CHECK_PROGRESS IN ('결재대기', '결재중', '결재완료')
   
   private String appKinds; // 결재 종류
   
   private String appPresent;

   private int userNo;
   
   private String deptName;
   
   private String userName;
   
   private int rowNum;
   
   private String rank;
   
   
   // App_Receive_Ref

   private int receiveRefNo; // 왜????
   
   private int receiveRefAppNo; // 수신참조 테이블 approval 시퀀스
    
   private String referList; // 수신참조내역
   
   
   // App_Loa
   private int loaNo; // LOA 시퀀스
    
   private int loaAppNo; // APP 시퀀스
    
   private String loaTitle; // 제목
    
   private String loaContent; // 상세내용
    
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
   private int erNo;
   
   private int erAppNo;
   
   private Date erDeadline;
   
   private String erSlassify; // 계정과목
   
   private String erTitle;
   
   private String erDetail; // 적요
   
   private String erAmount; // 금액
   
   private String erReference; // 비고
   
   private String erStatus; // 문서상태
   
   private String erPresent; // 결재상태
   
   private String allamount; // 지출금액
   
   private String monetaryUnit; // 화폐단위
   
}