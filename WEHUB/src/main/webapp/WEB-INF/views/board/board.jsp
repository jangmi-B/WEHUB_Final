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
     	
		<form action="${path}/board/board" name="formBoard" style="margin-top: -90px; margin-left: -230px;">
			
			<input type="hidden" name="userId" value="${loginMember.user_id}">
			<input type="hidden" name="boardId" value = "${board.userId}">
			<input type="hidden" name="replyWriterNo" value="${loginMember.user_no}">
			<%-- <input type="hidden" name="boardNo" value = "${board.boardNo}"> --%>
			<%-- <input type="hidden" name="replyNo" value = "${board.reply.replyNo}"> --%>
			
			
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
					<div style="border:0px" id="divNo(${board.boardNo})">
						<input type="hidden" name="boardNo" value = "${board.boardNo}">
						<div id="contentForm">
	   						<div id="box">
				        		<div class="title" >
						            <span class="indi_info"><img src="${path}/images/${board.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span>
							        <span>${board.userName}</span>
							        <span class="date">[ ${ board.dept_name } ]</span>
							        <span class="date"><fmt:formatDate value="${board.boardCreateDate}" pattern="yyyy/MM/dd"/></span>
							        <%-- <c:if test="${board.boardModifyDate }">
							        	<span>[수정됨]</span>						        
							        </c:if> --%>
							        
							        <c:if test="${ !empty loginMember && (loginMember.user_id == board.userId) }">
								        <span id="update"><b><a href="${path}/board/update?boardNo=${board.boardNo}">수정</a></b></span>
								        <span id="delete"><b><a href="${path}/board/delete?boardNo=${board.boardNo}">삭제</a></b></span>
							        </c:if>
							        
								</div>
					  			
						        <div class="freecontent">${board.boardContent}</div>
					        
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
										
										location.href = "${path}/board/replyWrite?boardNo="+c_no+"&replyContent="+textArea;	
									}
								</script>

								<div id="replytotal">
									<div class="reply "id="reply">
			                           <c:forEach var="reply" items="${board.replies}">                     
			                        		 <c:if test="${reply.replyContent == null}">
					                           <div>
					                              조회된 댓글이 없습니다.
					                           </div>
			                        		 </c:if>
			                        		 <c:if test="${reply.replyContent != null}">
			                        		 	 <input type="hidden" id="replyUserId" name="replyUserId" value="${reply.replyUserId}">
				                                 <span id="indi">  <img src="${path}/images/${reply.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span>
				                                 <span id="indi">${reply.userName}</span>
				                                 <span class="date "id="indi">${reply.replyCreateDate}</span>
				                                 
				                                 <c:if test="${loginMember.user_id == reply.replyUserId}">
					                                 <span id="update"><b><a href="#opModal_${reply.replyNo}">수정</a></b></span>
												 
												 
													<div id="opModal_${reply.replyNo}" class="modal">
														<input type="hidden" id="replyNo" name="replyNo" value="${reply.replyNo}">
														<span id="indi">  <img src="${path}/images/${reply.memberImage}" width="40px" height="40px" style="border-radius: 20px;"></span>
														<span id="indi">${reply.userName}</span>
														<p></p>
														
														<textarea name="newReplyContent"id="newReplyContent" style="width:320px; height:70px; margin:20px; margin-left:23px">${reply.replyContent}</textarea>
														
														<span id="replyUpdate" style="float:right; margin-top:40px; margin-right:13px"><b><button type="submit" onclick="replyUpdate();">등록</button></b></span>
													
														<script>
															function replyUpdate() {
																location.href="${path}/board/updateReply";
															}
														</script>
													</div>
												
												<script>
											       $('a[href="#opModal_${reply.replyNo}"]').click(function(event) {
													       $(this).modal({
													       	fadeDuration: 450
												      }); 
												   });
												</script>
												
					                                 <span id="delete"><b><a href="${path}/board/deleteReply?replyNo=${reply.replyNo}">삭제</a></b></span>
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
		</form>     
		
<%@ include file="../common/footer.jsp" %>