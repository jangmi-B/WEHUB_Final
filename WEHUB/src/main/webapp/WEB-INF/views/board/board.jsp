<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="../common/header.jsp" %>
	<section>
		<div id="notice_bar">
			<ul>
			    <li><span>게시판</span>
			    	<div class="line"></div>
				    <ul>
				    	<li>공지사항</li>
				        <li>자유게시판</li>
				        <%-- <c:if test="${loginMember != null}"> --%>
				        	<li id="subword"><a href="${path}/board/boardWrite?boardWriterNo=${loginMember.user_no}">&nbsp;&nbsp;+ 글쓰기</a></li> 
				        <%-- </c:if> --%>
				    </ul>
			    </li>
				<li>
					<table>
						<tr>
					        <td style="border:0px white;"><input id="notice_search" type="search" placeholder="공지사항 검색"></td>
					    	<td style="border:0px white;"><button type="button">Go</button></td>
					    </tr>
					</table>
				</li>
			</ul>
		</div>
     	
		<form action="${path}/board/board" style="margin-top: -90px; margin-left: -230px;">
			
			<input type="hidden" name="userId" value="${loginMember.user_id}">
			<input type="hidden" name="userId" value="${loginMember.user_no}">
			<input type="hidden" name="boardId" value = "${board.userId}">
			
			<div class="search">
		    	<table>
		        	<tr>
		            	<td style="border:0px white;">
		                	<i class="fa fa-search" aria-hidden="true"></i>
		            	</td>
		            	<td style="border:0px white;">
		                	<input type='text' class='src' size="200"placeholder='검색어를 입력하세요.'/>
		                </td>
		            </tr>
				</table>
			</div>
			
    		<c:if test="${list == null}">
    			<div id="contentForm">
   					<div id="box">
						<div>
							조회된 게시글이 없습니다.
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${list != null}">
				<c:forEach var="board" items="${list}">
					<div id="contentForm">
   						<div id="box">
			        		<div class="title" >
					            <span class="indi_info"><img src="${path}/images/${board.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span>
						        <span>${board.userName}</span>
						        <span class="date"><fmt:formatDate value="${board.boardModifyDate}" pattern="yyyy/MM/dd"/></span>
						        
						        <c:if test="${ !empty loginMember && (loginMember.user_id == board.userId) }">
							        <span id="update"><b><a href="${path}/board/update?boardNo=${board.boardNo}">수정</a></b></span>
							        <span id="delete"><b><a>삭제</a></b></span>
						        </c:if>
						        
							</div>
				  
					        <div class="freecontent" >${board.boardContent}</div>
				        
							<div class="contentline">
							  <div id="cline"></div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
			
					<!-- <div class="replyblank">
						<div id="comments">comments</div>
						<div id="enrollbox">
						    <textarea  cols="50" rows="4"></textarea>
							<button type="button">등록</button>
						</div>
					</div>
					<div id="replytotal">
						<div class="reply "id="reply">
				            <span id="indi">  <img src="../자유게시판/businessman.png" width="30px" height="30px"></span>
				            <span id="indi">hj</span>
				            <span class="date "id="indi"> 2021/03/08</span>
				            <span id="delete"><b><u>삭제</u></b></span>
				            <div id="replycontent"> 좋은 글이네요</div>
		      			</div>
				      	<div class="reply "id="reply">
					        <span id="indi">  <img src="../자유게시판/businessman.png" width="30px" height="30px"></span>
					        <span id="indi">hj</span>
					        <span class="date "id="indi"> 2021/03/08</span>
					        <span id="delete"><b><u>삭제</u></b></span>
					        <div id="replycontent"> 좋은 글이네요</div>
				  		</div>
						<div class="reply "id="reply">
							<span id="indi">  <img src="../자유게시판/businessman.png" width="30px" height="30px"></span>
							<span id="indi">hj</span>
							<span class="date "id="indi"> 2021/03/08</span>
							<span id="delete"><b><u>삭제</u></b></span>
							<div id="replycontent"> 좋은 글이네요</div>	
						</div>
					</div> --> 
				</div>
	    	</div> 
		</form>     
		
<%@ include file="../common/footer.jsp" %>