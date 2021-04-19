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
<%-- <script src="${path}/js/jquery-ui.min.js"></script> --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

	<div id="notice_bar">
		<ul>
		    <li><span>게시판</span>
		    	<div class="line"></div>
			    <ul>
			    	<li style="color:black;">공지사항</li>
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

							<div id="replytotal">
								<div class="reply "id="reply">
		                           <c:forEach var="reply" items="${board.replies}">                     
		                        		 <c:if test="${empty reply}">
				                           <div>
				                              조회된 댓글이 없습니다.
				                           </div>
		                        		 </c:if>
		                        		 <c:if test="${reply.replyContent != null}">
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
			                             	<hr></hr>
			                       		 </c:if>
		                           </c:forEach>
					     		</div>
							</div>
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
	
	// 1. 스크롤 이벤트 발생
	$(window).scroll(function(){ // ① 스크롤 이벤트 최초 발생
		
		var currentScrollTop = $(window).scrollTop();
		
		/*  
			=================	다운 스크롤인 상태	================
		*/
		if( currentScrollTop - lastScrollTop > 0 ){
			// down-scroll : 현재 게시글 다음의 글을 불러온다.
			console.log("down-scroll");
			
			// 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
			if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){ //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면
	            
				// 3. class가 scrolling인 것의 요소 중 마지막인 요소를 선택한 다음 그것의 data-bno속성 값을 받아온다.
				//		즉, 현재 뿌려진 게시글의 마지막 bno값을 읽어오는 것이다.( 이 다음의 게시글들을 가져오기 위해 필요한 데이터이다.)
				var lastbno = $(".scrolling:last").attr("data-bno");
			
				console.log('lastbno : ' + lastbno);
			
				// 4. ajax를 이용하여 현재 뿌려진 게시글의 마지막 bno를 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다. 
				$.ajax({
					type : 'post',	// 요청 method 방식 
					url : 'infiniteScrollDown',// 요청할 서버의 url
					/* headers : { 
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					}, */
					/* dataType : 'json', */ // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
					data :{ // 서버로 보낼 데이터 명시 
						rownumdata : lastbno
					},
					success : function(data){// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
						
						var str = "";
						console.log(data);
						// 5. 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
						if(data != ""){
							
							str +=	'<c:if test="${list != null}"><c:forEach var="board" items="${list}"><div style="border:0px" name="infDiv" id="divNo(${board.boardNo})"><input type="hidden" name="boardNo" value = "${board.boardNo}"><input type="hidden" name="rownum" value = "${board.rownum}"><div id="contentForm" class="listToChange"><div id="box" class="scrolling" data-bno="${board.rownum}"><div class="title" ><span class="indi_info"><img src="${path}/upload/userProfileImg/${board.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span><span>${board.userName}</span><span class="date">[ ${ board.dept_name } ]</span><span class="date"><fmt:formatDate value="${board.boardCreateDate}" pattern="yyyy/MM/dd"/></span><c:if test="${board.boardCreateDate != board.boardModifyDate}"><span class="date">(수정됨)</span></c:if><c:if test="${ !empty loginMember && (loginMember.user_id == board.userId) }"><div style="display:inline; float:right; margin-top:25px"><span id="update"><b><a href="${path}/freeBoard/update?boardNo=${board.boardNo}" style="color:black;">수정</a></b></span><span id="delete"><b><a href="${path}/freeBoard/delete?boardNo=${board.boardNo}" style="color:red;">삭제</a></b></span></div></c:if></div><div class="freecontent" style="word-break:break-all;word-wrap:break-word; width:70%; margin-left:50px">${board.boardContent}</div><div class="contentline"><div id="cline"></div></div><div class="replyblank"><input type="hidden" id="hiddenBoardNo" name="boardNo" value="${board.boardNo}"><div id="comments">comments</div><div id="enrollbox"><textarea name="replyContent" id="newReplyContent(${board.boardNo})" cols="50" rows="4"></textarea>'
							+ '<button type="button" onclick="clickBtn(${board.boardNo})" class="addReply" id="addReplyBtnNo">등록</button></div></div><script>function clickBtn(c_no) {var no = document.getElementById' + "('divNo('+c_no+')')" + ';var boardNo = document.getElementById("hiddenBoardNo").value;var textArea = document.getElementById' + "('newReplyContent('+c_no+')')" + '.value;console.log(textArea);location.href = "${path}/freeBoard/replyWrite?boardNo="+c_no+"&replyContent="+textArea;}</script' + '><div id="replytotal"><div class="reply "id="reply"><c:forEach var="reply" items="${board.replies}"><c:if test="${empty reply}"><div>조회된 댓글이 없습니다.</div></c:if><c:if test="${reply.replyContent != null}"><input type="hidden" id="replyUserId" name="replyUserId" value="${reply.replyUserId}"><span id="indi"><img src="${path}/upload/userProfileImg/${reply.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span><span id="indi">${reply.userName}</span><span class="date "id="indi">${reply.replyCreateDate}</span>'
							+ '<c:if test="${loginMember.user_id == reply.replyUserId}"><span id="update"><b><a href="#opModal_${reply.replyNo}">수정</a></b></span><div id="opModal_${reply.replyNo}" class="modal"><input type="hidden" id="replyNo" name="replyNo" value="${reply.replyNo}"><span id="indi">  <img src="${path}/upload/userProfileImg/${reply.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span><span id="indi">${reply.userName}</span><p></p><textarea name="newReplyContent"id="newReplyContent(${reply.replyNo})" style="width:320px; height:70px; margin:20px; margin-left:23px">${reply.replyContent}</textarea><span id="replyUpdate" style="float:right; margin-top:40px; margin-right:13px"><b><button type="submit" onclick="replyUpdate(${reply.replyNo})">등록</button></b></span></div><script>$' + "('a[href=" + "#opModal_${reply.replyNo}" + "]')" + '.click(function(event) {$(this).modal({fadeDuration: 450}); });<' + '/script><span id="delete"><b><a href="${path}/freeBoard/deleteReply?replyNo=${reply.replyNo}">삭제</a></b></span></c:if><div id="replycontent" style=" margin:20px; margin-left:60px">${reply.replyContent}</div><hr></hr></c:if></c:forEach></div></div></div></div></div></c:forEach></c:if>;';
								
						 		
							$('#firstDiv').append(str);
							
							// 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.
							/* $(".listToChange").empty();// 셀렉터 태그 안의 모든 텍스트를 지운다.		 */
							
						} else{ // 9. 만약 서버로 부터 받아온 데이터가 없으면 그냥 아무것도 하지말까..
							alert("더 불러올 데이터가 없습니다.");
							
						}// else
		
					}// success
				});// ajax
				
				 // 여기서 class가 listToChange인 것중 가장 처음인 것을 찾아서 그 위치로 이동하자.
				//var position = $(".listToChange:first").offset();// 위치 값
				
				// 이동  위로 부터 position.top px 위치로 스크롤 하는 것이다. 그걸 500ms 동안 애니메이션이 이루어짐.
				/* $('html,body').stop().animate({scrollTop : position.top }, 600, easeEffect); */
	
	        }//if : 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
			
			// lastScrollTop을 현재 currentScrollTop으로 갱신해준다.
			// lastScrollTop = currentScrollTop; 
		}// 다운스크롤인 상태
		
});// scroll event

</script>	
			
<%@ include file="../common/footer.jsp" %>