<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<style>
	.testMethod {padding: 50px 0 0 120px;}
	</style>
	
	<div class="testMethod">
		<h1>비밀번호 변경</h1>
		
		
		<script>
			function
		</script>

		<%-- <h1>회원 주소 배열 테스트</h1>
		
		<c:set var="adress">
			${ loginMember.address }
		</c:set>
		
		<ul>
		<c:forTokens var="d" items="${ adress }" delims=",">
			<li>${ d }</li>
		</c:forTokens>
		</ul>
		
		<c:set var="adressTest" value="${ loginMember.address }"></c:set>
		<c:set var="Test" value="${fn:split(adressTest,',')}"/>
		<c:forEach var="i" begin="0" end="0">
 		${Test[i]}
		</c:forEach>
		<br>
		<c:forEach var="i" begin="1" end="1">
 		${Test[i]}
		</c:forEach>
		<br>
		<c:forEach var="i" begin="2" end="2">
 		${Test[i]}
		</c:forEach>
		<br>
		<c:forEach var="i" begin="3" end="3">
 		${Test[i]}
		</c:forEach>

		<table>
			<tr>
              <td><label for="modify_address">주소</label></td>
              <td><input class="modify_input" name="address" id="kakao_postcode" type="text" value="${Test[0]}" readonly="readonly"></td>
              <td><button class="btn" id="modify_btn_addr" type="button" onclick="sample6_execDaumPostcode();">주소찾기</button></td>
            </tr>
            <tr>
              <td></td>
              <td><input class="modify_input" name="address" id="kakao_address" type="text" value="" readonly="readonly"></td>
              <td></td>
            </tr>
            <tr>
              <td></td>
              <td><input class="modify_input" name="address" id="kakao_detailAddress" type="text" value=""></td>
              <td></td>
            </tr>
            <tr>
              <td></td>
              <td><input class="modify_input" name="address" id="kakao_extraAddress" type="text" value="참고항목" readonly="readonly"></td>
              <td></td>
            </tr>
            <tr>
              <td><label for="modify_address">주소</label></td>
              <td><input class="modify_input" name="address" id="kakao_postcode" type="text" value="${ loginMember.address }" readonly="readonly"></td>
            </tr>
		</table> --%>
	
		
	
	</div>
	<%-- ${ loginMember.address } --%>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>