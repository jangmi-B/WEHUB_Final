<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<script src="${path}/js/jquery-3.5.1.js"></script>

<%@ include file="../approval/approvalSubMenu.jsp" %>

    <div class="index_section2">
        <form action="">
            <h2>결재현황</h2>
            <div id="e-pay-status">
                <span>
                    <p></p><a href="${path}/approval/approvalList?notice_search=결재대기" style="color:rgb(59, 211, 39);">결재대기</a>
                    <div>${countYet}건</div>
                </span>
                <span>
                    <p></p><a href="${path}/approval/approvalList?notice_search=결재중" style="color:rgb(59, 211, 39);">결재중</a>
                    <div>${countUnder}건</div>
                </span>
                <span>
                    <p></p><a href="${path}/approval/approvalList?notice_search=결재완료" style="color:rgb(59, 211, 39);">결재완료</a>
                    <div>${countDone}건</div>
                </span>
            </div>
        </form>

        <form action="">
            <h4 style="float:right; margin-right:114px; margin-top:50px; color:gray;"><a href="${path}/approval/approvalList">+ 결재목록 전체보기</a></h4>
            <h2 style="margin-bottom: 0; margin-top:30px">나의 결재목록</h2>
            <table id="e-pay-list" style="margin-bottom:130px">
                
                <tr>
                    <th>번호</th>
                    <th>종류</th>
                    <th>기안자</th>
                    <th>부서</th>
                    <th>기안일</th>
                    <th>상태</th>
                </tr>
                
                <c:if test="${empty mainList}">
                	</table>
                		<h3 style="top:50%; text-align:center; margin-left:300px; margin-top:150px">
                			조회된 결재목록이 없습니다.
                		</h3>
                </c:if>
                
                <c:if test="${mainList != null}">
	                <c:forEach var="list" items="${mainList}">
		                <tr>
		                    <td>${list.rowNum}</td>
		                    <td><a href="#">${list.appKinds}</a></td>
		                    <td>${list.userName}</td>
		                    <td>${list.deptName}</td>
		                    <td><fmt:formatDate value="${list.appWriteDate}" pattern="yyyy/MM/dd"/></td>
		                    <td>${list.appCheckProgress}</td>
		                </tr>
	                </c:forEach>
                </c:if>
        	</table>        
        </form>
    </div>

<%@ include file="../common/footer.jsp" %>