# WEHUB Project
2조 파이널 프로젝트 그룹웨어 사이트를 기획/제작한 웹 사이트입니다.   
백팀장 [백장미](https://github.com/jangmi-B), 김부장 [김정현](https://github.com/gogoss12), 김과장 [김예슬](https://github.com/M-Zl), 정대리 [정희재](https://github.com/doriHeejae), 공인턴 [공원상](https://github.com/wonsangkong) 총 5명이 참가하였습니다.

## 1.1.1 프로젝트 기간
* 프로젝트 기간 : 2021년 2월 27일 ~  2021년 4월 26일

![일정관리](https://user-images.githubusercontent.com/76435884/118403669-78a97880-b6aa-11eb-9d26-1ec9a5f6865f.png)

## 1.2. 프로젝트 컨셉
우리들이 업무를 공유하는 공간 'WE' + 'HUB' 


## 2.1. 기획의도
* 비용이 저렴하며 기본에 충실한 그룹웨어입니다.
* 소규모 회사도 부담없이 조직 구성원들이 의사 소통, 업무 전달, 정보 공유 및 의사 결정들의 업무 활동을 원활하게 수행하고 지원합니다.

## 2.2. 주요 기능
* 커뮤니티
* 쪽지
* 일정관리
* 전자결재
* 프로젝트
* 통합게시판
* 인명관리
* 회원가입/수정/탈퇴, 로그인, 아이디/비밀번호 찾기

## 3.1. 개발환경
* OS : Windows 10, Mac Big Sur
* FW : Spring Framework
* WAS : Apache Tomcat 9.0
* DB : Oracle Database
* Front-end : HTML5 / CSS / javascript / jQuery / AJAX / JSON
* Back-end : JDK 1.8 / JSP / JSTL
* Developer Tools : STS / Eclipes / SqlDeveloper / VS Code
* GitHub
* Sourcetree

## 3.2. 사용한 API
    - kakao 우편번호 서비스
    - Google Mail
    - CKEditor 4
    - TinyMCE
    - fullcalendar-5.6.0

## 3.3. 필요한 라이브러리
    - taglibs-standard-compat-1.2.5.jar
    - taglibs-standard-impl-1.2.5.jar
    - taglibs-standard-jstlel-1.2.5.jar
    - taglibs-standard-spec-1.2.5.jar

##  4. 화면설계 및 기능 구현

![2 로그인페이지](https://user-images.githubusercontent.com/76435884/118402402-c4592380-b6a4-11eb-8ee7-2fb15b63294c.PNG)

* 로그인 페이지

![7 id 찾기](https://user-images.githubusercontent.com/76435884/118402410-c7541400-b6a4-11eb-999d-384925f37907.PNG)

* ID 찾기 페이지
* ID 찾기는 사용자가 가입시 입력한 이름과 이메일, 개인 핸드폰 번호를 입력하여 찾을 수 있습니다.

![8 패스워드 찾기](https://user-images.githubusercontent.com/76435884/118402411-c7541400-b6a4-11eb-9b98-932a1215f705.PNG)

* PASSWORD 찾기 페이지
* PASSWORD는 사용자의 가입한 아이디, 가입시 입력한 이메일을 입력하면 입려된 이메일 주소로 새로운 비밀번호가 발급됩니다.
* 입력한 이메일과 가입한 이메일이 동일하면 새로 발급된 비밀번호로 로그인이 가능합니다. (비밀번호 변경 페이지에서 비밀번호 변경 가능)

![3 이용약관 페이지](https://user-images.githubusercontent.com/76435884/118402405-c58a5080-b6a4-11eb-85a1-cb64ebdc51dc.PNG)

* 이용약관 페이지
* 체크박스를 모두 클릭하여 동의하지 않으면 다음페이지로 이동할 수 없습니다.

![4 회원가입 페이지](https://user-images.githubusercontent.com/76435884/118402406-c622e700-b6a4-11eb-8707-d82376105854.PNG)

* 회원가입 페이지입니다.
* 관리자 계정으로 가입할 회원을 미리 사번을 입력해줘야 가입이 가능
* 프로필 이미지 업로드
* 아이디 중복체크
* 비밀번호 유효성 체크
* kakao 우편번호 서비스를 사용하여 주소입력

![5 회원 수정](https://user-images.githubusercontent.com/76435884/118402407-c622e700-b6a4-11eb-8004-04b64984fe9a.PNG)

* 회원 수정 페이지
* 업로드 프로필 이미지 미리보기
* 이메일/내선전화/휴대전화 수정

![6 비밀번호 수정](https://user-images.githubusercontent.com/76435884/118402408-c6bb7d80-b6a4-11eb-8af2-dfeecb981b1d.PNG)

* 비밀번호 변경 페이지입니다.

![6-2회원 탈퇴](https://user-images.githubusercontent.com/76435884/118402409-c6bb7d80-b6a4-11eb-840e-3161e204044e.PNG)

* 회원 탈퇴 페이지입니다.

![31-인명관리-페이지](https://user-images.githubusercontent.com/76435884/118403680-7e06c300-b6aa-11eb-81e5-9a8f3d667360.png)

* 인명관리 페이지
* 페이징 처리, 부서/이름/직급 사원 검색 구현
* 관리자 계정 : 등록할 사원의 이름/직급/부서 등록 구현

<br><br>
***
<br><br>

![2-1 메인페이지](https://user-images.githubusercontent.com/76435884/118402403-c4f1ba00-b6a4-11eb-94e2-b1ecea44e5df.PNG)

* 메인페이지

<br><br>
***
<br><br>

![9 쪽지 페이지](https://user-images.githubusercontent.com/76435884/118402413-c7ecaa80-b6a4-11eb-88c7-73fc1dfa99b1.PNG)

* 쪽지 페이지(받은쪽지함/보낸쪽지함/휴지통/받은,보낸쪽지 보관함)    


### 받은쪽지함
* 읽지 않은 쪽지가 있을 시 좌측 쪽지 icon 컬러 다르게
* 이미 읽은 쪽지도 읽지않음 상태로 업데이트 가능
* 받은 쪽지 삭제/보관 가능

### 보낸쪽지함
* 보낸 쪽지 수신확인 가능
* 보낸 쪽지 삭제 시 영구 삭제

### 쪽지쓰기
* 자동완성 기능
* 
<br><br>
***
<br><br>

![13-1 프로젝트 메인 페이지](https://user-images.githubusercontent.com/76435884/118402417-c8854100-b6a4-11eb-85b9-830588b3bd72.PNG)

###  프로젝트 페이지
* 프로젝트 마다 컬러를 다르게 구현
* 프로젝트 클릭 시 참여자를 보여주며, 쪽지함으로 바로 이동할 수 있고 일정, D-DAY확인, 프로젝트 상세 내용을 확인할 수 있습니다.
* 프로젝트 검색 기능 구현

![13-3 종료 플젝](https://user-images.githubusercontent.com/76435884/118402419-c91dd780-b6a4-11eb-8a63-2960d2945417.PNG)

* 종료된 프로젝트 : 현재까지 진행 완료된 모든 프로젝트 리스트 조회

![13-2 참여 플젝](https://user-images.githubusercontent.com/76435884/118402418-c8854100-b6a4-11eb-870d-494b7a2f839c.PNG)

* 참여중인 프로젝트 : 내가 참여한 프로젝트 리스트 조회

![13-4 즐찾 플젝](https://user-images.githubusercontent.com/76435884/118402420-c91dd780-b6a4-11eb-853a-dc1681d3bc64.PNG)
 
* 즐겨찾기 프로젝트 : 내가 즐겨찾기한 프로젝트 리스트 조회

![13 프로젝트 페이지](https://user-images.githubusercontent.com/76435884/118402415-c7ecaa80-b6a4-11eb-8528-b3b0b99d68d5.PNG)

* 프로젝트 생성 페이지 modal 구현
* 프로젝트 생성 시 참가자 자동완성 기능 구현
* 프로젝트 생성 시 Datepicker 사용하여 날짜 입력 기능 구현

<br><br>
***
<br><br>

![14 공지사항 페이지](https://user-images.githubusercontent.com/76435884/118402421-c9b66e00-b6a4-11eb-9465-0ac324b50473.PNG)

### 공지사항 페이지
* 필독 공지사항/ 일반 공지사항 등록/수정/삭제 구현
* 파일 업로드/다운로드 구현
* 댓글 등록/수정/삭제 비동기(Ajax)방식 구현

![15 자유게시판](https://user-images.githubusercontent.com/76435884/118402422-ca4f0480-b6a4-11eb-9855-8d25a90da698.PNG)

### 자유게시판 페이지
* 자유게시판 게시글 등록/수정/삭제 구현
* 댓글 등록/수정/삭제 구현 (수정/삭제 페이지 modal)
* 인피니티 스크롤 구현(자동 페이징)

![32-커뮤니티-페이지](https://user-images.githubusercontent.com/76435884/118403682-7f37f000-b6aa-11eb-9b09-411dc8fec96f.png)

### 커뮤니티 페이지
* 게시글 등록,수정,삭제/찜하기 등록,해제/판매자 쪽지보내기 기능 구현
* CKEditor API 구현 및 이미지 업로드 구현

<br><br>
***
<br><br>

![16 전자결재 리스트](https://user-images.githubusercontent.com/76435884/118402423-ca4f0480-b6a4-11eb-9176-1a98bbb5a998.PNG)

### 전자결재
* 결재대기/결재중/결재완료 리스트 조회
* 결재 수신목록/내 결재 목록/내가 작성한 결재 리스트 최신순으로 조회

![17 전자결재 양식](https://user-images.githubusercontent.com/76435884/118402424-cae79b00-b6a4-11eb-98be-2db5346bc780.png)

#### 품의서 / 지출결의서 / 휴거신청서 양식
* 품의서/지출결의서/휴가신청서 양식 제공/등록
* 모든 결재 등록 시 승인자(자동완성), 수신참조자(이름/부서/직책) 검색 기능 구현(modal)
* 품의서 등록 시 파일 업로드 구현/조회 시 파일 다운로드 구현
* 지출내역서 칸 추가/삭제 구현(최대 6행)

![18 결재승인(중간결재자)](https://user-images.githubusercontent.com/76435884/118402425-cae79b00-b6a4-11eb-9381-58f88ee22c46.PNG)

#### 결재 진행
* 최초승인자 -> 중간승인자 -> 최종승인자 순서로 결재 진행 구현(순서가 틀리면 버튼 비활성화)

![19-결재-반려-3](https://user-images.githubusercontent.com/76435884/118402427-cb803180-b6a4-11eb-97a7-4fda8e45e4ab.png)

#### 결재 반려
* 반려사유 입력창(modal) 생성 후 사유 입력 후 반려 처리 구현

<br><br>
***
<br><br>

### 스케쥴 관리

![20-개인별-스케쥴-관리](https://user-images.githubusercontent.com/76435884/118402428-cc18c800-b6a4-11eb-825c-af305122332a.png)

#### 개인 스케쥴 관리
* TinyMCE API 구현

![21 부서별 스케쥴 관리](https://user-images.githubusercontent.com/76435884/118402429-cc18c800-b6a4-11eb-92c4-b17dbb3c5b2b.PNG)

#### 부서별 스케쥴 관리
* fullcalendar API 구현
* 대한민국 공휴일 리스트 조회
* 전자결재(지출결의서-마감일/휴가신청서-휴가기간) 날짜 조회

<br><br>
***
<br><br>


## 5. DB 설계

![99-DB](https://user-images.githubusercontent.com/76435884/118402433-ccb15e80-b6a4-11eb-8284-02366a746089.png)

<br><br>
***
<br><br>

감사합니다.
