<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/css/member_modify.css">

	<div class="member__modify">
      <div id="member__modify__form">
        <form>
          <span id="modify_name">회원정보수정</span>
          <table>
            <tr>
              <td><label for="modify_id">아이디</label></td>
              <td><input id="modify_id" type="text" name="userId" value="user1" readonly></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_password">비밀번호</label></td>
              <td><input class="modify_input" id="modify_password" type="password" name="userPwd" value="1111"></td>
              <td><button class="btn" id="modify_btn_pw" type="button" id="pw_modify">비밀번호변경</button></td>
            </tr>
            <tr>
              <td><label for="modify_company">회사명</label></td>
              <td><input id="modify_company" name="userCompany" type="text" value="KH" readonly></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_userNo">사번</label></td>
              <td><input id="modify_userNo" name="userNo" type="text" value="A12345" readonly></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_userName">사원명</label></td>
              <td><input id="modify_userName" name="userName" type="text" value="홍길동" readonly></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_Grade">직급</label></td>
              <td><input id="modify_Grade" name="userGrade" type="text" value="사원" readonly></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_email">이메일</label></td>
              <td><input class="modify_input" name="userEmail" id="modify_email" type="email" value="abc@abc.com"></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_phone">내선전화</label></td>
              <td><input class="modify_input" name="userPhone" id="modify_phone" type="tel" value="02-000-0000"></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_cellPhone">휴대전화</label></td>
              <td><input class="modify_input" name="userCell" id="modify_cellPhone" type="tel" value="010-1234-1234"></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_address">주소</label></td>
              <td><input class="modify_input" name="userAddress" id="modify_address" type="text" value="15034"></td>
              <td><button class="btn" id="modify_btn_addr" type="button">주소찾기</button></td>
            </tr>
            <tr>
              <td></td>
              <td><input class="modify_input" name="userAddress2" id="modify_address" type="text" value="서울시 강남구 테헤란로14길 6"></td>
              <td></td>
            </tr>
            <tr>
              <td></td>
              <td><input class="modify_input" name="userAddress2" id="modify_address" type="text" value="남도빙딜 205호"></td>
              <td></td>
            </tr>
          </table>
          <div id="modify_button">
            <button class="btn" id="modify_btn" type="submit">회원정보수정</button>
            <button class="btn" id="modify_btn_b" type="button">회원탈퇴</button>
        </div> 
        </form>
      </div>  
    </div>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>