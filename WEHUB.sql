--CREATE USER WEHUB IDENTIFIED BY WEHUB;
--GRANT RESOURCE, CONNECT TO WEHUB;

--MEMBER 테이블
CREATE TABLE MEMBER (
    USER_NO NUMBER PRIMARY KEY,
    USER_COMPANYNAME VARCHAR2(30) NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(100) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,  
    COMPANY_RANK VARCHAR2(9) NULL,
    EMAIL VARCHAR2(30) NULL,
    COMCALL VARCHAR2(20) NULL,
    PHONE VARCHAR2(20) NULL,
    ADDRESS VARCHAR2(80) NULL,
    USER_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(USER_STATUS IN('Y', 'N')),
    DEPT_CODE VARCHAR2(10) NULL
);
-- USER_COMPANYNUMBER VARCHAR2(20) NOT NULL,
--DROP TABLE MEMBER;
--DROP SEQUENCE SEQ_USER_NO;

--ALTER TABLE MEMBER MODIFY USER_COMPANYNAME VARCHAR2(40);

COMMENT ON COLUMN MEMBER.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.USER_COMPANYNAME IS '회사명';
COMMENT ON COLUMN MEMBER.USER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.COMPANY_RANK IS '직급';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.COMCALL IS '내선번호';
COMMENT ON COLUMN MEMBER.PHONE IS '휴대번호';
COMMENT ON COLUMN MEMBER.ADDRESS IS '거주지';
COMMENT ON COLUMN MEMBER.USER_STATUS IS '회원상태값(Y/N)';
COMMENT ON COLUMN MEMBER.DEPT_CODE IS '부서코드';

CREATE SEQUENCE SEQ_USER_NO;

INSERT INTO MEMBER VALUES(
    SEQ_USER_NO.NEXTVAL,'WEHUB','admin','1234','관리자','부장','admin@wehub.com','0211112222','01011112222','서울시 강남구 역삼동',DEFAULT,NULL
);

-- 멤버 추가
-- INSERT INTO MEMBER VALUES(SEQ_USER_NO.NEXTVAL,#{},#{},#{},#{},#{},#{},#{},#{},#{},'Y',NULL)
-- INSERT INTO MEMBER VALUES(SEQ_USER_NO.NEXTVAL,#{},#{},#{},#{},#{},#{},#{},#{},#{},SYSDATE,SYSDATE,'Y',NULL)

COMMIT;

-- DEPARTMENT 테이블
CREATE TABLE DEPARTMENT (
    DEPT_CODE VARCHAR2(10) NULL,
    DEPT_NAME VARCHAR2(20) NULL
);

COMMENT ON COLUMN DEPARTMENT.DEPT_CODE IS '부서코드';
COMMENT ON COLUMN DEPARTMENT.DEPT_NAME IS '부서명';
--DROP TABLE DEPARTMENT;

COMMIT;
    
    
-- 프로필 이미지 테이블
CREATE TABLE MEMBER_IMAGE_FILE (
    MEM_IMG_NO NUMBER PRIMARY KEY,
    USER_NO VARCHAR2(30) NOT NULL,
    MEM_IMG_PATH VARCHAR2(20) NULL,
    MEM_IMG_ORG VARCHAR2(100) NULL,
    MEM_IMG_SAV VARCHAR2(20) NULL,  
    MEM_IMG_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN MEMBER_IMAGE_FILE.MEM_IMG_NO IS '파일번호시퀀스';
COMMENT ON COLUMN MEMBER_IMAGE_FILE.USER_NO IS '사번';
COMMENT ON COLUMN MEMBER_IMAGE_FILE.MEM_IMG_PATH IS '저장경로';
COMMENT ON COLUMN MEMBER_IMAGE_FILE.MEM_IMG_ORG IS '원본파일이름';
COMMENT ON COLUMN MEMBER_IMAGE_FILE.MEM_IMG_SAV IS '저장파일이름';
COMMENT ON COLUMN MEMBER_IMAGE_FILE.MEM_IMG_DATE IS '등록일';

CREATE SEQUENCE SEQ_MEM_IMG_NO;

--UPDATE MEMBER SET USER_PWD=${} WHERE USER_ID=${};

ALTER TABLE MEMBER ADD USER_IMG_ORIFILENAME VARCHAR2(100) NULL; 
ALTER TABLE MEMBER ADD USER_IMG_REFILENAME VARCHAR2(100) NULL;

COMMENT ON COLUMN MEMBER.USER_IMG_ORIFILENAME IS '프로필이미지원본파일명';
COMMENT ON COLUMN MEMBER.USER_IMG_REFILENAME IS '프로필이미지수정파일명';

INSERT INTO MEMBER VALUES(
    SEQ_USER_NO.NEXTVAL,'WEHUB','testImg','1234','테스트','부장','1234@wehub.com','0211112222','01011112222','서울시 강남구 역삼동',DEFAULT,'개발팀',NULL,NULL
);

commit;

    
    
    
    