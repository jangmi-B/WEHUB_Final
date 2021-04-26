<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${path}/css/board_style.css">
<link rel="stylesheet" href="${path}/css/board_homeContent.css">
<link rel="stylesheet" href="${path}/css/board_notice.css">
<link rel="stylesheet" href="${path}/css/board_community.css">

<script src="${path}/js/jquery-3.5.1.js"></script>
<script src="${path}/js/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

	<div id="notice_bar">
		<ul>
		    <li><span>게시판</span>
		    	<div class="line"></div>
			    <ul>
			    	<li><a href="${path}/notice/list" style="color:black;">공지사항</a></li>
			        <li><a href="${path}/freeBoard/board" style="color:black;">자유게시판</a></li>
			        <li id="subword"><a style="color:black;" href="${path}/freeBoard/boardWrite?boardWriterNo=${loginMember.user_no}">&nbsp;&nbsp;+ 글쓰기</a></li> 
			    </ul>
		    </li>
		</ul>
	</div>
    	
	<form action="${path}/freeBoard/board" name="formBoard" style="margin-top: -90px; margin-left: -230px; margin-bottom:200px">
		
		<input type="hidden" name="userId" value="${loginMember.user_id}">
		<input type="hidden" name="boardId" value = "${board.userId}">
		<input type="hidden" name="replyWriterNo" value="${loginMember.user_no}">
		
		<div class="search">
	    	<table>
	        	<tr>
	            	<td style="border:0px white;">
	                	<i class="fa fa-search" aria-hidden="true"></i>
	            	</td>
	            	<td style="border:0px white;">
	                	<input type='text' name="keyword" id="keyword" value="${keyword}" class='src' size="200"placeholder='검색어를 입력하세요.'/>
	                </td>
                	<td style="border:0px white;"><button type="button" onclick="search();">검색</button></td>
                	
	            </tr>
			</table>
              	<script>
				function search() {
					var keywordValue = document.getElementById('keyword').value;
					
					console.log(keywordValue);
					
					location.href="${path}/freeBoard/board?keyword="+keywordValue;
				}
			</script>
		</div>
	</form>	
	
<div style="margin-top: -90px; margin-left: -260px;" id="firstDiv">
   		<c:if test="${empty list}">
   			<div id="contentForm">
  					<div id="box">
					<div style="text-align: center; margin-top:75px">
						조회된 게시글이 없습니다.
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${list != null}">
			<c:forEach var="board" items="${list}">
				<div style="border:0px" name="infDiv" id="divNo(${board.boardNo})">
					<input type="hidden" name="boardNo" value = "${board.boardNo}">
					<input type="hidden" name="rownum" value = "${board.rownum}">
					<div id="contentForm" class="listToChange">
   						<div id="box" class="scrolling" data-bno="${board.rownum}">
			        		<div class="title" >
					            <span class="indi_info"><img src="${path}/upload/userProfileImg/${board.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span>
						        <span>${board.userName}</span>
						        <span class="date">[ ${ board.dept_name } ]</span>
						        <span class="date"><fmt:formatDate value="${board.boardCreateDate}" pattern="yyyy/MM/dd"/></span>
							    <c:if test="${board.boardCreateDate != board.boardModifyDate}">
							        <span class="date">(수정됨)</span>
							    </c:if>   
						        
						        <c:if test="${ !empty loginMember && (loginMember.user_id == board.userId) }">
							    <div style="display:inline; float:right; margin-top:25px">    
							        <span id="update"><b><a href="${path}/freeBoard/update?boardNo=${board.boardNo}" style="color:black;">수정</a></b></span>
							        <span id="delete"><b><a href="${path}/freeBoard/delete?boardNo=${board.boardNo}" style="color:red;">삭제</a></b></span>
							    </div>    
						        </c:if>
							</div>
				  			
					        <div class="freecontent" style="word-break:break-all;word-wrap:break-word; width:70%; margin-left:50px">${board.boardContent}</div>
				        
							<div class="contentline">
							  <div id="cline"></div>
							</div>
								<div class="replyblank">
									<input type="hidden" id="hiddenBoardNo" name="boardNo" value="${board.boardNo}">
									<div id="comments">comments</div>
									<div id="enrollbox">
								    	<textarea name="replyContent" id="newReplyContent(${board.boardNo})" cols="50" rows="4"></textarea>
										<button type="button" onclick="clickBtn(${board.boardNo})" class="addReply" id="addReplyBtnNo">등록</button>
									</div>
								</div>
								
								<script>
									function clickBtn(c_no) {
										var no = document.getElementById('divNo('+c_no+')');
										var boardNo = document.getElementById("hiddenBoardNo").value;
										var textArea = document.getElementById('newReplyContent('+c_no+')').value;
										
										console.log(textArea);
										
										location.href = "${path}/freeBoard/replyWrite?boardNo="+c_no+"&replyContent="+textArea;	
									}
								</script>

		                    <c:forEach var="reply" items="${board.replies}">                     
		                        <c:if test="${empty reply}">
									<div id="replytotal"><div class="reply "id="reply">
		                            <div>
		                               조회된 댓글이 없습니다.
		                            </div></div></div>
                        		</c:if>
		                        		 <c:if test="${reply.replyContent != null}">
		                        		 <div id="replytotal"><div class="reply "id="reply">
		                        		 	 <input type="hidden" id="replyUserId" name="replyUserId" value="${reply.replyUserId}">
			                                 <span id="indi">  <img src="${path}/upload/userProfileImg/${reply.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span>
			                                 <span id="indi">${reply.userName}</span>
			                                 <span class="date "id="indi">${reply.replyCreateDate}</span>
			                                 
			                                 <c:if test="${loginMember.user_id == reply.replyUserId}">
				                       		 	<span id="update"><b><a href="#opModal_${reply.replyNo}">수정</a></b></span>
											 
												<div id="opModal_${reply.replyNo}" class="modal">
				                                 	<input type="hidden" id="replyNo" name="replyNo" value="${reply.replyNo}">
													<span id="indi">  <img src="${path}/upload/userProfileImg/${reply.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span>
													<span id="indi">${reply.userName}</span>
													<p></p>
													<textarea name="newReplyContent"id="newReplyContent(${reply.replyNo})" style="width:320px; height:70px; margin:20px; margin-left:23px">${reply.replyContent}</textarea>
													<span id="replyUpdate" style="float:right; margin-top:40px; margin-right:13px"><b><button type="submit" onclick="replyUpdate(${reply.replyNo})">등록</button></b></span>
												</div>
												
												<script>
												    $('a[href="#opModal_${reply.replyNo}"]').click(function(event) {
														$(this).modal({
															fadeDuration: 450
													    }); 
													});
												</script>
												
				                                 <span id="delete"><b><a href="${path}/freeBoard/deleteReply?replyNo=${reply.replyNo}">삭제</a></b></span>
			                       		 	</c:if>
			                                
			                                <div id="replycontent" style=" margin:20px; margin-left:60px">${reply.replyContent}</div>                               
			                             	
			                             	</div></div>
			                       		 </c:if>
		                           </c:forEach>
					     		
						</div>
					</div>	
				</div>
			</c:forEach>
		</c:if>
		
	</div>		
	
	<script>
		function replyUpdate(rno) {
			var textAreaValue = document.getElementById('newReplyContent('+rno+')').value;
			
			console.log(textAreaValue);
			console.log(rno);
			location.href="${path}/freeBoard/updateReply?replyNo="+rno+"&newReplyContent=" + textAreaValue;
		}			
	</script>
	
<script>
	var lastScrollTop = 0;
	var easeEffect = 'easeInQuint';
	
	$(window).scroll(function(){
		var currentScrollTop = $(window).scrollTop();
		
		if( currentScrollTop - lastScrollTop > 0 ){
			console.log("down-scroll");
			
			if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){
				var lastbno = $(".scrolling:last").attr("data-bno");
			
				console.log('lastbno : ' + lastbno);
			
				$.ajax({
					type : 'post',
					url : 'infiniteScrollDown',
					data :{ 
						rownumdata : lastbno
					},
					success : function(data){
						
						console.log(data.length);
						
						var str = "";
						
						if(data != "") {
							$.each(data, function(i){
								var loginMemberId = '${loginMember.user_id}';

								if (loginMemberId == data[i].userId) {
									str = '<div style="border:0px" class="forInf" name="infDiv" id="divNo(' + data[i].boardNo + ')"><input type="hidden" name="boardNo" value = "' + data[i].boardNo + '"><input type="hidden" name="rownum" value = "' + data[i].rownum + '"><div id="contentForm" class="listToChange"><div id="box" class="scrolling" data-bno="' + data[i].rownum + '"><div class="title" ><span class="indi_info"><img src="${path}/upload/userProfileImg/' + data[i].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span><span>' + data[i].userName + '</span><span class="date">[ ' + data[i].dept_name + ' ]</span><span class="date">' + data[i].boardCreateDate + '</span><c:if test="' + data[i].boardCreateDate + ' != ' + data[i].boardModifyDate + '"><span class="date">(수정됨)</span></c:if><div style="display:inline; float:right; margin-top:25px"><span id="update"><b><a href="${path}/freeBoard/update?boardNo=' + data[i].boardNo + '" style="color:black;">수정</a></b></span><span id="delete"><b><a href="${path}/freeBoard/delete?boardNo=' + data[i].boardNo + '" style="color:red;">삭제</a></b></span></div></div><div class="freecontent" style="word-break:break-all;word-wrap:break-word; width:70%; margin-left:50px">' + data[i].boardContent + '</div><div class="contentline"><div id="cline"></div></div><div class="replyblank"><input type="hidden" id="hiddenBoardNo" name="boardNo" value="' + data[i].boardNo + '"><div id="comments">comments</div><div id="enrollbox"><textarea name="replyContent" id="newReplyContent(' + data[i].boardNo + ')" cols="50" rows="4"></textarea>'
									+  '<button type="button" onclick="clickBtn(' + data[i].boardNo + ')" class="addReply" id="addReplyBtnNo">등록</button></div></div><script>function clickBtn(c_no) {var no = document.getElementById(' + "'divNo('+c_no+')')" + ';var boardNo = document.getElementById("hiddenBoardNo").value;var textArea = document.getElementById' + "('newReplyContent('+c_no+')').value;console.log(textArea);location.href" + '= "${path}/freeBoard/replyWrite?boardNo' + '="+c_no+"&replyContent="+textArea;}<' + '/script>';	
								} else {
									str = '<div style="border:0px" class="forInf" name="infDiv" id="divNo(' + data[i].boardNo + ')"><input type="hidden" name="boardNo" value = "' + data[i].boardNo + '"><input type="hidden" name="rownum" value = "' + data[i].rownum + '"><div id="contentForm" class="listToChange"><div id="box" class="scrolling" data-bno="' + data[i].rownum + '"><div class="title" ><span class="indi_info"><img src="${path}/upload/userProfileImg/' + data[i].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span><span>' + data[i].userName + '</span><span class="date">[ ' + data[i].dept_name + ' ]</span><span class="date">' + data[i].boardCreateDate + '</span><c:if test="' + data[i].boardCreateDate + ' != ' + data[i].boardModifyDate + '"><span class="date">(수정됨)</span></c:if></div><div class="freecontent" style="word-break:break-all;word-wrap:break-word; width:70%; margin-left:50px">' + data[i].boardContent + '</div><div class="contentline"><div id="cline"></div></div><div class="replyblank"><input type="hidden" id="hiddenBoardNo" name="boardNo" value="' + data[i].boardNo + '"><div id="comments">comments</div><div id="enrollbox"><textarea name="replyContent" id="newReplyContent(' + data[i].boardNo + ')" cols="50" rows="4"></textarea>'
									+  '<button type="button" onclick="clickBtn(' + data[i].boardNo + ')" class="addReply" id="addReplyBtnNo">등록</button></div></div><script>function clickBtn(c_no) {var no = document.getElementById(' + "'divNo('+c_no+')')" + ';var boardNo = document.getElementById("hiddenBoardNo").value;var textArea = document.getElementById' + "('newReplyContent('+c_no+')').value;console.log(textArea);location.href" + '= "${path}/freeBoard/replyWrite?boardNo' + '="+c_no+"&replyContent="+textArea;}<' + '/script>';	
								}
								
								$.each(data[i].replies, function(r){
									
									if(data[i].replies[r].replyContent != "") {
										if (loginMemberId == data[i].replies[r].replyUserId) {
											str += 
				                                 '<div id="replytotal"><div class="reply "id="reply">'
				                                    + '<input type="hidden" id="replyUserId" name="replyUserId" value="' + data[i].replies[r].replyUserId + '">'
				                                    
				                                       + '<span id="indi">  <img src="${path}/upload/userProfileImg/' + data[i].replies[r].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span>'
				                                       + '<span id="indi">' + data[i].replies[r].userName + '</span>'
				                                       + '<span class="date "id="indi">' + data[i].replies[r].replyCreateDate + '</span>'
				                                   	   + '<span id="update"><b><a href="#opModal_' + data[i].replies[r].replyNo + '">수정</a></b></span>'
					                                   + '<span id="delete"><b><a href="${path}/freeBoard/deleteReply?replyNo=' + data[i].replies[r].replyNo + '">삭제</a></b></span>'
				                                      + '<div id="replycontent" style=" margin:20px; margin-left:60px">' + data[i].replies[r].replyContent + '</div>'                              
				                              
				                                      + '</div></div>'
		
				                                 + '<div class="modal" id="' + 'opModal_' + data[i].replies[r].replyNo + '">'
				                                    + '<input type="hidden" id="replyNo" name="replyNo" value="' + data[i].replies[r].replyNo + '">'
				                                    + '<span id="indi">  <img src="${path}/upload/userProfileImg/' + data[i].replies[r].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span>'
				                                    + '<span id="indi">' + data[i].replies[r].userName + '</span>'
				                                    
				                                    + '<p></p>'
				                                    + '<textarea name="newReplyContent"id="newReplyContent(' + data[i].replies[r].replyNo + ')" style="width:320px; height:70px; margin:20px; margin-left:23px">' + data[i].replies[r].replyContent + '</textarea>'
				                                    + '<span id="replyUpdate" style="float:right; margin-top:40px; margin-right:13px"><b><button type="submit" onclick="replyUpdate(' + data[i].replies[r].replyNo + ')">등록</button></b></span>'
				                                 + '</div>'
				      
				                                 + '<script>'
				                                 +    "$('a[href" + '="#opModal_' + data[i].replies[r].replyNo + '"]' + "').click(function(event) {"
				                                 +    '$(this).modal({'
				                                 +       'fadeDuration: 450'
				                                 +     '});'
				                                 + '});'
				                                 + '<' + '/script>';
		                                } else {
		                                	str += 
				                                 '<div id="replytotal"><div class="reply "id="reply">'
				                                    + '<input type="hidden" id="replyUserId" name="replyUserId" value="' + data[i].replies[r].replyUserId + '">'
				                                    
				                                       + '<span id="indi">  <img src="${path}/upload/userProfileImg/' + data[i].replies[r].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span>'
				                                       + '<span id="indi">' + data[i].replies[r].userName + '</span>'
				                                       + '<span class="date "id="indi">' + data[i].replies[r].replyCreateDate + '</span>'
				                                   	   + '<div id="replycontent" style=" margin:20px; margin-left:60px">' + data[i].replies[r].replyContent + '</div>'                              
				                              
				                                      + '</div></div>'
		
				                                 + '<div class="modal" id="' + 'opModal_' + data[i].replies[r].replyNo + '">'
				                                    + '<input type="hidden" id="replyNo" name="replyNo" value="' + data[i].replies[r].replyNo + '">'
				                                    + '<span id="indi">  <img src="${path}/upload/userProfileImg/' + data[i].replies[r].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span>'
				                                    + '<span id="indi">' + data[i].replies[r].userName + '</span>'
				                                    
				                                    + '<p></p>'
				                                    + '<textarea name="newReplyContent"id="newReplyContent(' + data[i].replies[r].replyNo + ')" style="width:320px; height:70px; margin:20px; margin-left:23px">' + data[i].replies[r].replyContent + '</textarea>'
				                                    + '<span id="replyUpdate" style="float:right; margin-top:40px; margin-right:13px"><b><button type="submit" onclick="replyUpdate(' + data[i].replies[r].replyNo + ')">등록</button></b></span>'
				                                 + '</div>'
				      
				                                 + '<script>'
				                                 +    "$('a[href" + '="#opModal_' + data[i].replies[r].replyNo + '"]' + "').click(function(event) {"
				                                 +    '$(this).modal({'
				                                 +       'fadeDuration: 450'
				                                 +     '});'
				                                 + '});'
				                                 + '<' + '/script>';
		                                }
									}	
								});
								
								$('#firstDiv').append(str);
								
							});
							
						} else {
							alert("더 불러올 데이터가 없습니다.");
						}
					}
				});
	        }
		}
	});
</script>	
			
<%@ include file="../common/footer.jsp" %>