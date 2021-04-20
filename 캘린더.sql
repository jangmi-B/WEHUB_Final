	    select LEAVE_START,LEAVE_FINISH ,LEAVE_CLASSIFY, M.USER_NAME,M.USER_NO,M.DEPT_CODE           
        FROM MEMBER M
        JOIN APPROVAL A ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN APP_LEAVE AP ON (A.APP_SEQ = AP.LEAVE_APP_SEQ)
     --   JOIN MEMBER M ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN DEPARTMENT D ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = '회계팀' and a.app_present='A'; 
        
        select TO_CHAR(LEAVE_START,'YYYY-MM-DD')LEAVE_START,TO_CHAR(LEAVE_FINISH,'YYYY-MM-DD')LEAVE_FINISH,LEAVE_CLASSIFY, m.user_name,m.user_no,m.dept_code
        from member m 
        join approval a on a.app_writer_no= m.user_no
        join app_leave ap on a.APP_SEQ= ap.leave_app_seq
        join member m on a.app_writer_no=m.user_no
        JOIN department d ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = #{dept_code} 
        
        	    select LEAVE_START,LEAVE_FINISH ,LEAVE_CLASSIFY, M.USER_NAME,M.USER_NO,M.DEPT_CODE           
        FROM MEMBER M
        JOIN APPROVAL A ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN APP_LEAVE AP ON (A.APP_SEQ = AP.LEAVE_APP_SEQ)
        JOIN MEMBER M ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN DEPARTMENT D ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = '회계팀' ; 
        select * from approval;
     select LEAVE_START,LEAVE_FINISH ,LEAVE_CLASSIFY, M.USER_NAME,M.USER_NO,M.DEPT_CODE           
        FROM MEMBER M
        JOIN APPROVAL A ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN APP_LEAVE AP ON (A.APP_SEQ = AP.LEAVE_APP_SEQ)
        JOIN MEMBER M ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN DEPARTMENT D ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = '회계팀' and a.app_present='A'; 
        
        join approval a on a.app_writer_no= m.user_no
        join app_leave ap on a.APP_SEQ= ap.leave_app_seq
        join member m on a.app_writer_no=m.user_no
        JOIN department d ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = '회계팀'; 
        
   select * from   APPROVAL;   
    select * from   APP_RECEIVE_REF;
        INSERT INTO APPROVAL
VALUES(
    SEQ_APP_SEQ.NEXTVAL,
    SYSDATE,
    '김둘리',
    '박또치',
    '홍길동',
    NULL,
    NULL,
    NULL,
    NULL,
    226,
    DEFAULT,
    '지출결의서',
   'A'
);
INSERT INTO APP_RECEIVE_REF
VALUES(
    SEQ_RECEIVE_REF_SEQ.NEXTVAL,
    24,
    null
);
select * from app_leave;
INSERT INTO APP_LEAVE
VALUES(
 SEQ_LEAVE_SEQ.NEXTVAL,
 24,
 '병가',
 '21/04/08',
 '21/04/08',
 '건강검진하러 갑니다.',
 DEFAULT,
 DEFAULT,
 '010-1234-5678'
);



INSERT INTO APP_RECEIVE_REF
VALUES(
    SEQ_RECEIVE_REF_SEQ.NEXTVAL,
    41,
    null
);
select * from  APP_ER;
INSERT INTO APP_ER
VALUES(
 SEQ_LEAVE_SEQ.NEXTVAL,
 41,
 '2021/04/14',
 '계정과목이뭐야',
 '제목',
 '적요',
 '금액은 varchar',
'비고',
   'Y',--'문서상태',
    'A'  , --'결재상태',
'지출금액',
 '$'
);

	 
-----
-- 지출결의서
-------
        
        
    CREATE TABLE APP_ER (
    ER_SEQ NUMBER PRIMARY KEY,
    ER_APP_SEQ NUMBER NOT NULL,
    ER_DEADLINE DATE NULL,
    ER_CLASSIFY VARCHAR2(30) NULL,
    ER_TITLE VARCHAR2(100) NULL,
    ER_DETAIL VARCHAR2(1000) NULL,
    ER_AMOUNT VARCHAR2(1000) NULL,
    ER_REFERENCE VARCHAR2(1000) DEFAULT ' ',
    ER_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(ER_STATUS IN('Y', 'N')),
    ER_PRESENT VARCHAR2(3) DEFAULT 'A' CHECK(ER_PRESENT IN ('A', 'B', 'C')),
    CONSTRAINT FK_ER_APP_SEQ FOREIGN KEY(ER_APP_SEQ) REFERENCES APPROVAL(APP_SEQ) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_ER_SEQ;

COMMENT ON COLUMN APP_ER.ER_SEQ IS '지출결의서고유번호';
COMMENT ON COLUMN APP_ER.ER_APP_SEQ IS '전자결재시퀀스';
COMMENT ON COLUMN APP_ER.ER_DEADLINE IS '지급요청일자';
COMMENT ON COLUMN APP_ER.ER_CLASSIFY IS '계정과목';
COMMENT ON COLUMN APP_ER.ER_TITLE IS '제목';
COMMENT ON COLUMN APP_ER.ER_DETAIL IS '적요';
COMMENT ON COLUMN APP_ER.ER_AMOUNT IS '금액';
COMMENT ON COLUMN APP_ER.ER_REFERENCE IS '비고';
COMMENT ON COLUMN APP_ER.ER_STATUS IS '문서상태';
COMMENT ON COLUMN APP_ER.ER_PRESENT IS '결재상태';
ALTER TABLE APP_ER ADD ER_ALLAMOUNT VARCHAR2(100);
COMMENT ON COLUMN app_er.ER_ALLAMOUNT IS '지출금액';
alter table app_er add ER_MONETARYUNIT VARCHAR2(100);
COMMENT ON COLUMN app_er.ER_MONETARYUNIT IS '화폐단위';
        
        
   select ER_DEADLINE,ER_TITLE, M.USER_NAME,M.USER_NO,M.DEPT_CODE           
        FROM MEMBER M
        JOIN APPROVAL A ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN APP_ER ER ON (A.APP_SEQ = ER.ER_APP_SEQ)
       -- JOIN MEMBER M ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN DEPARTMENT D ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = '회계팀' and ER.ER_PRESENT='A'; 
    
    -- mapper 별칭 추가된거 
        select TO_CHAR(ER_DEADLINE,'YYYY-MM-DD')ER_DEADLINE,ER_TITLE, M.USER_NAME,M.USER_NO,M.DEPT_CODE           
        FROM MEMBER M
        JOIN APPROVAL A ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN APP_ER ER ON (A.APP_SEQ = ER.ER_APP_SEQ)
        JOIN MEMBER M ON (A.APP_WRITER_NO = M.USER_NO)
        JOIN DEPARTMENT D ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = '회계팀' and ER.ER_PRESENT='A'; 
              
        
   select * from app_er;     
        

   
        commit;
 
        
        
  ----------------------------------------------------------------------------------------------------------------------------      
        
       select TO_CHAR(LEAVE_START ,'YYYY-MM-DD HH24:MI:SS'),TO_CHAR(LEAVE_FINISH ,'YYYY-MM-DD HH24:MI:SS')
  from app_leave;
