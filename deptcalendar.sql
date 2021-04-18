select * from deptcalendar;

--alter table '테이블명' add '컬럼명' '타입' '옵션';

alter table deptcalendar add startday date;
alter table deptcalendar modify D_CAL_DAY varchar2(20);

alter table deptcalendar add userNo number;
alter table deptcalendar rename  column userNo to USER_NO ;

select * from deptcalendar;

alter table deptcalendar drop column user_no;
update deptcalendar set
startday = '21/03/31',
endday= '21/04/1',
user_no=2 where d_cal_no=46;
SELECT * FROM MEMBER;
	SELECT M.DEPT_CODE, D.DEPT_NAME, D.D_CAL_NO, D.D_CAL_CONTENT, D.D_CAL_DATE,
			  D.D_CAL_YEAR, D.D_CAL_MONTH, D.D_CAL_DAY,D.STARTDAY,D.ENDDAY
		FROM DEPTCALENDAR D
        JOIN MEMBER M ON(M.DEPT_CODE = D.DEPT_NAME)
        WHERE M.DEPT_CODE = '회계팀';
        
        		SELECT M.DEPT_CODE, D.DEPT_NAME, D.D_CAL_NO, D.D_CAL_CONTENT, D.D_CAL_DATE,
			  D.D_CAL_YEAR, D.D_CAL_MONTH, D.D_CAL_DAY,D.STARTDAY,D.ENDDAY
		FROM DEPTCALENDAR D
	 	JOIN MEMBER M ON(M.DEPT_CODE = D.DEPT_NAME)
		WHERE M.DEPT_CODE = '인사팀';
        
        select * from deptcalendar;
   insert into deptcalendar
   values (4,'2021','3','28','억지로 넣는 회계팀','21/04/09','회계팀','21/03/04','21/3/19',226);     