<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>
<script src="${path}/js/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="${path}/css/board_style.css">
<link rel="stylesheet" href="${path}/css/board_homeContent.css">
<link rel="stylesheet" href="${path}/css/board_notice.css">
<link rel="stylesheet" href="${path}/css/board_community.css">
	<section>
		<div id="notice_bar">
			<ul>
			    <li><span>게시판</span>
					<div class="line"></div>
					<ul>
						<li style="color:black;">공지사항</li>
				        <li><a href="${path}/freeBoard/board" style="color:black;">자유게시판</a></li>
				        <li id="subword"><a style="color:black;" href="${path}/freeBoard/boardWrite">&nbsp;&nbsp;+ 글쓰기</a></li> 
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
     
		<form action='${path}/freeBoard/boardWrite' method="post" style="margin-top: -90px; margin-left: -230px;">
		
			<input type="hidden" name="userId" value="${loginMember.user_id}">
		
			<div id="contentForm">	
		    	<div class="info_box">
		        	<div id="box">
		        		<div class="title">
		        			<span class="indi_info"><img src="${path}/upload/userProfileImg/${loginMember.user_imgRename}" width="40px" height="40px" style="border-radius: 20px; margin-top: 40px; margin-left: 15px"></span>
		      				<span>${ loginMember.user_name }</span>
		      				<span class="date">${ loginMember.dept_name }</span>      
		      				<span class="date">${ serverTime }</span>
		        		</div>
		        		
		        		<div class="freewrite" style="margin:30px">
		          			<p><span id="counter">0</span>/<span id="maxLength">1000</span></p>
		            		<textarea name="boardContent" id="textcount"cols ="50" rows ="20" placeholder="내용을 입력해주세요~" style ="resize: none ;" border ="1px gray"></textarea>
		            
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
							
							<%-- <input type="hidden" name="boardContent" value="${board.boardContent}"> --%>
							
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