CREATE TABLE MEMBER_IMAGE_FILE (
	MEM_IMG_NO	NUMBER	NOT NULL,
	USER_NO	NUMBER	NOT NULL,
	MEM_IMG_PATH VARCHAR2(255)	NULL,
	MEM_IMG_ORG	VARCHAR2(255)	NULL,
	MEM_IMG_SAV	VARCHAR2(255)	NULL,
	MEM_IMG_DATE DATE  DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_MEM_IMG_NO;

SELECT M.USER_NO,
       M.USER_COMPANYNAME,
        M.USER_ID,
        M.USER_PWD,
        M.USER_NAME,
        M.RANK,
        M.EMAIL,
        M.COMCALL,
        M.PHONE,
        M.ADDRESS,
        M.USER_STATUS,
        M.DEPT_CODE,
        D.DEPT_NAME
    FROM MEMBER M 
    JOIN DEPARTMENT D ON(M.DEPT_CODE = D.DEPT_CODE)
    WHERE M.USER_STATUS ='Y'
    AND d.dept_name LIKE '%'||'기획'||'%'
				OR m.user_name LIKE '%'||'기획'||'%'
				OR m.rank LIKE '%'||'기획'||'%';
    







CREATE TABLE MEMBER (
	USER_NO	NUMBER	NOT NULL,
	USER_COMPANYNAME	VARCHAR2(30)	NULL,
	USER_ID	VARCHAR2(20)	NULL,
	USER_PWD	VARCHAR2(15)	NULL,
	USER_NAME	VARCHAR2(20)	NULL,
	RANK	VARCHAR2(8)	NULL,
	EMAIL	VARCHAR2(30)	NULL,
	COMCALL	NUMBER	NULL,
	PHONE	NUMBER	NULL,
	ADDRESS	VARCHAR2(40)	NULL,
	USER_STATUS	VARCHAR2(1)	DEFAULT 'Y' CHECK(USER_STATUS IN('Y','N')),
	DEPT_CODE	VARCHAR2(3)	NOT NULL
);

COMMENT ON COLUMN MEMBER.USER_NO IS '유저시퀀스';
COMMENT ON COLUMN MEMBER.USER_COMPANYNAME IS '회사명';
COMMENT ON COLUMN MEMBER.USER_ID IS '아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '이름';
COMMENT ON COLUMN MEMBER.RANK IS '직급';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.COMCALL IS '내선전화';
COMMENT ON COLUMN MEMBER.PHONE IS '휴대전화';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.USER_STATUS IS '상태';
COMMENT ON COLUMN MEMBER.DEPT_CODE IS '부서코드';

INSERT INTO MEMBER VALUES(
    SEQ_USER_NO.NEXTVAL,
    '스마트컴퍼니',
    'p12ppo',
    '1234',
    '가나다',
    '사원',
    'oo105@naver.com',
    2134883,
    01062289955,
    '경기도 광주',
    DEFAULT,
    'D2'
    );




CREATE SEQUENCE SEQ_USER_NO;

CREATE TABLE DEPARTMENT (
	DEPT_CODE	VARCHAR2(3)	NOT NULL,
	DEPT_NAME	VARCHAR2(10)	NULL
);




ALTER TABLE MEMBER_IMAGE_FILE ADD CONSTRAINT PK_MEMBER_IMAGE_FILE PRIMARY KEY (
	MEM_IMG_NO
);

ALTER TABLE MEMBER ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	USER_NO
);

ALTER TABLE DEPARTMENT ADD CONSTRAINT PK_DEPARTMENT PRIMARY KEY (
	DEPT_CODE
);





