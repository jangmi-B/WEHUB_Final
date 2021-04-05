<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

  <form action="${path}/notice/list" id="notice_bar" method="get">
	<div>
        <ul>
          <li><span>게시판</span>
            <div class="line"></div>
            <ul>
              <li><a href="${path}/notice/list">공지사항</a></li>
              <li>자유게시판</li>
            </ul>
          </li>
          <li>
            <table>
              <tr>
                <td><input id="notice_search" type="search" name="notice_search" placeholder="공지사항 검색"></td>
                <td><button type="submit">Go</button></td>
              </tr>
            </table>
        </ul>
      </div>
    </form>
  <div class="notice_detail_wrap">
    <div id="notice_detail">
      <div id="notice_detail_top">
        <table>
          <tr>
              <td colspan="4"><span class="title_detail">${ notice.noticeTitle }</span></td>
          </tr>
          <tr>
            <td>작성자 : ${ notice.noticeUserName }</td>
            <td>부서 : ${ notice.department }</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${ notice.noticeCreateDate }" /></td>
            <td>조회 : <span style="color: blue;">${ notice.noticeReadCount }</span></td>
          </tr>
          <tr>
            <td colspan="4">
              <span id="download_icon"><i class="far fa-save"></i></span> 
               첨부파일 :
               <c:if test="${ !empty notice.noticeOriginalFileName }">
				<a href="javascript:fileDownload('${notice.noticeOriginalFileName}', '${notice.noticeRenamedFileName}');">		
					<c:out value="${notice.noticeOriginalFileName}" />
				</a>
				<script>
					function fileDownload(oriname, rename) {
						const url="${path}/notice/fileDown";
						
						let oName = encodeURIComponent(oriname);
						let rName = encodeURIComponent(rename);
						
						location.assign(url + "?oriname=" + oName + "&rename=" + rName);
					}
				</script>
			</c:if>
			<c:if test="${ notice.noticeOriginalFileName }">			
				<span style="color: gray;"> - </span>
			</c:if>
            </td>
          </tr>
          <tr>
            <td class="detail_contents" colspan="4"  style='table-layout:fixed'>
              <div class="detail_contents_div">
                ${fn:replace(notice.noticeContent, replaceChar, "<br/>")}
              </div>
            </td>
          </tr>
        </table>
      </div>
      <div id="notice_detail_btn">
      <c:if test="${ !empty loginMember && (loginMember.user_id == notice.userId)}">
      
        <button type="button" onclick="updateBoard()">수정하기</button>
        <button class="d_btn" type="button"onclick="deleteBoard()">삭제하기</button>
       </c:if>
        <button class="d_btn" type="button" onclick="location.href='${path}/notice/list'">목록으로</button>
      </div>
      <div class="coment_container">
        <form id="commentForm" name="commentForm" method="get" action="${path}/notice/comments">
          <div>
              <span><strong>Comments</strong></span> <span id="cCnt">(2)</span>
              <div class="comment_line"></div>
          </div>
          <div id="comment_div">
              <table>                    
                <tr>
                  <td>
                    <textarea rows="3" cols="120" name="commentContent" placeholder="댓글을 입력하세요"></textarea>
                  </td>
                  <td>
                    <button class="commnet_btn" type="submit" onclick="location.href='${path}/notice/comments'">등록</button>
                  </td>
                </tr>
              </table>
          </div>
          <input type="hidden" id="commentNoticeNO" name=commentNoticeNO value="${notice.noticeNo}" />        
        </form>
      </div>
      <div class="coment_container" id="notice_conment_list">
          <table>
      <c:choose>
      	<c:when test="${notice.comments.size() == 0}">
      		<tr><td rowspan="2" colspan="5"></td></tr>
      		<tr><td colspan="4">댓글이 존재하지 않습니다.</td></tr>
      	</c:when>
      	<c:when test="${notice.comments.size() != 0}">
      		<c:forEach var="comments" items="${comments}">
      		<tbody id="commentsArea(${comments.commentNo})">
	            <tr>
	            						<!--  이미지파일ㄱ  -->
	              <td rowspan="2"><i class="far fa-user-circle"></i></td>
	              <td><span class="comment_name" id="c_name(${comments.commentNo})">${comments.userName}</span></td>
	              <td colspan="3"><span class="comment_sub">${comments.commentModifyDate}</span></td>
	              <td colspan="2"> 
	              <c:if test="${comments.commentWriterNo == loginMember.user_no}">
	              		<a href="javascript:updateComments(${comments.commentNo});" id="update(${comments.commentNo})"> 수정</a>
                        <button id="modifyBtn(${comments.commentNo})" type="submit" onclick="modifyComments(${comments.commentNo})" style=display:none>수정</button>
	              		<a href="javascript:deleteComments(${comments.commentNo})" id="delete(${comments.commentNo})"> 삭제</a>
	              </c:if>
	              </td>
	            </tr>
	            <tr>
	                <td colspan="4">
	                    <div class="comment_list_td" id="comment_list_div(${comments.commentNo})">
	                       <p class="comment_details" id="comment_details(${comments.commentNo})">${comments.commentContent}</p>
	                       <textarea id="comment_textarea(${comments.commentNo})" rows="3" cols="30" style=display:none>${comments.commentContent}</textarea>
	                    </div>
                 	</td>
	            </tr>
	        </tbody>
			    <div class="modal1 hidden modalNo${comments.commentNo}">
			        <div class="bg"></div>
			        <div class="modalBox">
			        	<div style="color:red; font-size:24px; padding-left: 3px; margin: 20px 0px 0px 0px;">
			        		※댓글을 삭제하시겠습니까?※ 
			        	</div>
			        	 <div style="margin: 30px 0px 0px 60px;">
			                <span style="float: left; padding-right: 40px;" >
			                    <button class="closeBtn-in" id="closeBtn-in(${comments.commentNo})" onclick="deleteBtn(${comments.commentNo})">확인</button>
			                </span>
			                <button class="closeBtn-out" id="closeBtn-out(${comments.commentNo})">취소</button>
			            </div>
			        </div>
			    </div>
            </c:forEach>
        </c:when>
      </c:choose>
          </table>
      </div>
    </div>
  </div>
  
<script>
	function updateBoard(){
			location.href = "${path}/notice/update?noticeNo=${notice.noticeNo}";
	}
		
	function deleteBoard(){		
		if(confirm("정말로 게시글을 삭제 하시겠습니까?")){
			location.replace('${path}/notice/delete?noticeNo=${notice.noticeNo}');
		}
	}
  			// 첫번째 수정버튼 클릭시
     	 function updateComments(c_no){
     		 
          
         var modifyBtn = document.getElementById('modifyBtn('+ c_no +')');
         var firstModifyBtn = document.getElementById('update('+ c_no +')');
         var commentP = document.getElementById('comment_details('+ c_no +')');
         //기존 내용 - > 수정할 내용
         var commentArea = document.getElementById('comment_textarea('+ c_no +')');
         var commentName = document.getElementById('c_name('+ c_no +')');
         
          
         firstModifyBtn.style.display = 'none';
         
         commentArea.style.display = 'block';
       	 commentArea.style.resize = 'none';
       	 
         commentArea.style.borderRadius = '8px';
         commentP.style.display = 'none';
         
         modifyBtn.style.display='inline';
         modifyBtn.style.border = 'none';
         modifyBtn.style.fontSize = '16px';
         modifyBtn.style.color = 'blue';
         modifyBtn.style.cursor = 'pointer';
         modifyBtn.style.padding = '0';
         
         
         console.log(commentArea.value);
         console.log(commentName.innerText);
            
         }
     	 
     	 // 2번째 수정버튼 클릭시
     	 function modifyComments(c_no){
     		 
             var commentArea = document.getElementById('comment_textarea('+ c_no +')');
             var commentName = document.getElementById('c_name('+ c_no +')');
             var firstModifyBtn = document.getElementById('update('+ c_no +')');
             var commentP = document.getElementById('comment_details('+ c_no +')');
             var modifyBtn = document.getElementById('modifyBtn('+ c_no +')');
             
             console.log(commentArea.value);
             console.log(commentName.innerText);
             
             firstModifyBtn.style.display = 'inline';
             commentP.style.display = 'block';
             
             commentArea.style.display = 'none';
             modifyBtn.style.display = 'none'
             
             //ajax 처립 부분
             var xhr = new XMLHttpRequest();
             
             xhr.onreadystatechange = function() {
            	if(xhr.readyState == 4 && xhr.status == 200){
            		var str = xhr.responseText;
            		
            		document.getElementById('comment_details('+ c_no +')').innerHTML = str;
            		
            	}else {
            		
            	}
             }
             
             xhr.open("POST", "${path}/notice/comments/update", true);
             
             xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded;")
             
             xhr.send("name="+commentName.innerText+"&comments="+commentArea.value+"&commentsNo="+c_no);
     	 }
     	 
     	 
     	 function deleteComments(c_no) {
     		 
     		 
     		// modal 창 띄우기

     	    const open = () => {
     	    	document.querySelector('.modalNo'+c_no).classList.remove("hidden");
     	    }

     	    const close = () => {
     	        document.querySelector('.modalNo'+c_no).classList.add("hidden");
     	    }

     	    document.getElementById('delete('+ c_no +')').addEventListener("click", open);
     	    document.getElementById('closeBtn-out('+ c_no +')').addEventListener("click", close);
     	    document.getElementById('closeBtn-in('+ c_no +')').addEventListener("click", close);
     	    document.querySelector(".bg").addEventListener("click", close);
     		
     	 }
     	 
     	 
     	 function deleteBtn(c_no) {
     	    
			 //ajax 처립 부분
            var xhr = new XMLHttpRequest();
            
            xhr.onreadystatechange = function() {
           	if(xhr.readyState == 4 && xhr.status == 200){
				var deleteArea = document.getElementById('commentsArea('+ c_no +')');
				deleteArea.remove();
           	}else {
           		
           		}
            }
            
            xhr.open("GET", "${path}/notice/comments/delete?commentsNo="+c_no, true);
            
            
            xhr.send();
     	 }
     	 
  </script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>