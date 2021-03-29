<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="index_section">
      <ul>
        <li><h1>쪽지 <i class="far fa-comment-dots"></i></h1>
          <div class="line"></div>
          <ul>
            <li><button type="button" class="msg_write_btn"> 쪽지쓰기 </button></li>
            <li>보낸쪽지함</li>
            <li>받은쪽지함</li>
            <li>휴지통</li>
            <li>쪽지보관함</li>
          </ul>
        </li>
        <div class="line"></div>
      </div>
      <div class="messageList">
        <div class="megSearchBox">
          <form action="">
            <select class="msgSearchList">
              <option value="all">전체</option>
              <option value="inbox">받은편지함</option>
              <option value="send">보낸편지함</option>
              <option value="archive">쪽지보관함</option>
            </select>
            <select class="msgSearchList">
              <option value="all">전체</option>
              <option value="name">이름</option>
              <option value="content">내용</option>
            </select>
            <input type="search" placeholder="원하는 검색어를 입력하세요">
            <button type="button" class="msg_btn_search">검색</button>
          </form>
        </div>
        <div class="msgComponent">
          <button type="button" class="msg_btn">삭제</button>
          <button type="button" class="msg_btn">보관</button>
          <button type="button" class="msg_btn">답장</button>
        </div>
          <table class="message_table">
            <tr>
              <th><input type="checkbox"></th>
              <th>보낸사람</th>
              <th>내용</th>
              <th>날짜</th>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>홍길동 대리</td>
              <td>금일 회의장소는 000회의실로 변경되었습니다. 확인하세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>홍길동 대리</td>
              <td>금일 회의장소는 000회의실로 변경되었습니다. 확인하세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>홍길동 대리</td>
              <td>금일 회의장소는 000회의실로 변경되었습니다. 확인하세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>홍길동 대리</td>
              <td>금일 회의장소는 000회의실로 변경되었습니다. 확인하세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>홍길동 대리</td>
              <td>금일 회의장소는 000회의실로 변경되었습니다. 확인하세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>홍길동 대리</td>
              <td>금일 회의장소는 000회의실로 변경되었습니다. 확인하세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김영희 팀장</td>
              <td>팀장미팅 불참하오니 착오 없으시기바랍니다.</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김둘리 사원</td>
              <td>안녕하세요 품의서 승인부탁드립니다.</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>고길동 과장</td>
              <td>4월 행사일정 공유드립니다.</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김둘리 사원</td>
              <td>개발1팀 예산 사용현황입니다. 확인해주세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김둘리 사원</td>
              <td>개발1팀 예산 사용현황입니다. 확인해주세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김둘리 사원</td>
              <td>개발1팀 1월 예산 사용현황입니다. 확인해주세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김둘리 사원</td>
              <td>개발1팀 2월 예산 사용현황입니다. 확인해주세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김둘리 사원</td>
              <td>개발1팀 3월 예산 사용현황입니다. 확인해주세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>김둘리 사원</td>
              <td>개발1팀 예산 사용현황입니다. 확인해주세요</td>
              <td>2021-03-29 10:20</td>
            </tr>
          </table>
          <div class="message_page">
            <ul class="notice_pagination modal">
                <li><button type="button" >처음페이지</button></li>
                <li><button type="button" >&lt;&lt;</button></li>
                <li><button>1</button></li>
                <li><button>2</button></li>
                <li><button>3</button></li>
                <li><button type="button">&gt;&gt;</button></li>
                <li><button type="button" >마지막페이지</button></li>
            </ul>
          </div>
        </div>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>