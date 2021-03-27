<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<script src="${path}/js/jquery-3.5.1.js"></script>
<%@ include file="../common/header.jsp" %>
	<section>
		<div id="notice_bar">
			<ul>
			    <li><span>게시판</span>
					<div class="line"></div>
					<ul>
						<li>공지사항</li>
						<li><a href="${path}/board/board">자유게시판</a></li>
						<li id="subword"><a href="${path}/board/boardWrite">&nbsp;&nbsp;+ 글쓰기</a></li> 
					</ul>
			    </li>
			    <li>
					<table>
						<tr>
							<td style="border:0px white;"><input id="notice_search" type="search" placeholder="공지사항 검색"></li></td>
							<td style="border:0px white;"><button type="button">Go</button></td>
						</tr>
					</table>
				</li>
			</ul>
		</div>
     
		<form action='${path}/board/update' method="POST" style="margin-top: -90px; margin-left: -230px;">
		
			<input type="hidden" name="userId" value="${loginMember.user_id}">
			<input type="hidden" name="boardNo" value = "${board.boardNo}">
			<input type="hidden" name="boardId" value = "${board.userId}">
			
			<div id="contentForm">	
		    	<div class="info_box">
		        	<div id="box">
		        		<div class="title">
		        			<span class="indi_info"><img src="${path}/images/${loginMember.member_image}" width="40px" height="40px" style="border-radius: 20px; margin-top: 40px; margin-left: 15px"></span>
		      				<span>${ loginMember.user_name }</span>
		      				<span class="date">${ loginMember.dept_name }</span>      
		        		</div>
		        		
		        		<div class="freewrite">
		          			<p><span id="counter">0</span>/<span id="maxLength">1000</span></p>
		            		<textarea name="boardContent" id="textcount"cols ="50" rows ="20" placeholder="내용을 입력해주세요~" style ="resize: none" border: "1px gray">${board.boardContent}</textarea>
		            
		            		<br>
		            		
		            		<script>
						        $(function () {
						            $("#textcount").on("keyup",function(){
						                var inputLength = $(this).val().length;
						
						                console.log(inputLength);
						
						                $("#counter").text(inputLength);
						
						                var remain = $("#maxLength").text()-inputLength ; 
						            
						                if(remain<0){
						                    $("#counter").css("color","red");
						                }
						                else{
						                   $("#counter").css("color","black");
						                }
						            }); 
						        });
							</script>
							
							<input type="hidden" name="boardContent" value="${board.boardContent}">

		          			<span id="buttonkey">
					            <input  class="sumbitbutton" type="submit" value="전송"> &nbsp;
					            <input  class="sumbitbutton" type="reset" value="다시입력">
		         			</span>
		        		</div>
	    			</div>
				</div> 
			</div>
		</form>
		
<%@ include file="../common/footer.jsp" %>