<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${path}/css/approvalPage.css">
<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<script src="${path}/js/jquery-3.5.1.js"></script>

<%@ include file="../approval/approvalSubMenu.jsp" %>

    <div class="index_section2">
        <form action="">
            <h2 style="margin-bottom: -75px;">결재리스트</h2>
            <table style="width:300px;margin-left:1500px; margin-bottom:30px">
              <tr>
                <td><input id="notice_search" type="search" name="notice_search" placeholder="결재리스트 검색"></td>
                <td><button type="submit">Go</button></td>
              </tr>
            </table>
            <table id="e-pay-list" style="margin-top:68px">
                <tr>
                    <th>번호</th>
                    <th>종류</th>
                    <th>기안자</th>
                    <th>부서</th>
                    <th>기안일</th>
                    <th>결재상태</th>
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
		                    <c:choose>
			                    <c:when test="${list.appKinds eq '품의서'}">
			                    	<td><a href="${path}/approval/letterOfApprovalView?appNo=${list.appNo}">${list.appKinds}</a></td>
			                    </c:when>
			                    <c:when test="${list.appKinds eq '휴가신청서'}">
			                    	<td><a href="${path}/approval/leaveApplicationView?appNo=${list.appNo}">${list.appKinds}</a></td>
			                    </c:when>
			                    <c:when test="${list.appKinds eq '지출결의서'}">
			                    	<td><a href="${path}/approval/expenseReportView?appNo=${list.appNo}">${list.appKinds}</a></td>
			                    </c:when>
		                    </c:choose>
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
    
    <div class="notice_list_page">
        <ul class="notice_pagination">
            <c:if test="${notice_search == null}">
                <li><button type="button" class="notice_page_first" onclick="location.href='${path}/approval/approvalList?page=1'">처음페이지</button></li>
                <li><button type="button" class="notice_arrow_left" onclick="location.href='${path}/approval/approvalList?page=${pageInfo.prvePage}'">&lt;&lt;</button></li>
                <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
					<c:if test="${status.current == pageInfo.currentPage}">
						<li><button disabled><c:out value="${status.current}"/></button></li>
	   				</c:if>
					<c:if test="${status.current != pageInfo.currentPage}">
						<li><button onclick="location.href='${path}/approval/approvalList?page=${status.current}'"><c:out value="${status.current}"/></button></li>
	   				</c:if>
				</c:forEach>
                <li><button type="button" class="notice_arrow_right" onclick="location.href='${path}/approval/approvalList?page=${pageInfo.nextPage}'">&gt;&gt;</button></li>
                <li><button type="button" class="notice_page_last" onclick="location.href='${path}/approval/approvalList?page=${pageInfo.maxPage}'">마지막페이지</button></li>
            </c:if>
            <c:if test="${notice_search != null}">
              	<li><button type="button" class="notice_page_first" onclick="location.href='${path}/approval/approvalList?notice_search=${notice_search}&page=1'">처음페이지</button></li>
	            <li><button type="button" class="notice_arrow_left" onclick="location.href='${path}/approval/approvalList?notice_search=${notice_search}&page=${pageInfo.prvePage}'">&lt;&lt;</button></li>
	            <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
					<c:if test="${status.current == pageInfo.currentPage}">
						<li><button disabled><c:out value="${status.current}"/></button></li>
	   				</c:if>
					<c:if test="${status.current != pageInfo.currentPage}">
						<li><button onclick="location.href='${path}/approval/approvalList?notice_search=${notice_search}&page=${status.current}'"><c:out value="${status.current}"/></button></li>
	   				</c:if>
				</c:forEach>
                <li><button type="button" class="notice_arrow_right" onclick="location.href='${path}/approval/approvalList?notice_search=${notice_search}&page=${pageInfo.nextPage}'">&gt;&gt;</button></li>
            	<li><button type="button" class="notice_page_last" onclick="location.href='${path}/approval/approvalList?notice_search=${notice_search}&page=${pageInfo.maxPage}'">마지막페이지</button></li>
        	</c:if>
    	</ul>
	</div>

<%@ include file="../common/footer.jsp" %>