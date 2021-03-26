<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

  <div id="notice_bar">
    <ul>
      <li><span>게시판</span>
        <div class="line"></div>
        <ul>
          <li>공지사항</li>
          <li>자유게시판</li>
        </ul>
      </li>
      <li>
        <table>
          <tr>
            <td><input id="notice_search" type="search" placeholder="공지사항 검색"></li></td>
            <td><button type="button">Go</button></td>
          </tr>
        </table>
    </ul>
  </div>
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
                ${ fn:replace(notice.noticeContent, replaceChar, "<br/>" )}
              </div>
            </td>
          </tr>
        </table>
      </div>
      <div id="notice_detail_btn">
        <button type="button">수정하기</button>
        <button id="d_btn" type="button" onclick="location.href='${path}/notice/list'">목록으로</button>
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
	            <tr>
	            						<!--  이미지파일ㄱ  -->
	              <td rowspan="2"><i class="far fa-user-circle"></i></td>
	              <td><span class="comment_name">${comments.userName}</span></td>
	              <td colspan="3"><span class="comment_sub">${comments.commentCreateDate}</span></td>
	              <c:if test="">
	              <td colspan="2"> 
	              		<a href="javascript:updateComments()"> 수정</a>
	              		<a href="#"> 삭제</a>
	              </td>
	              </c:if>
	            </tr>
	            <tr>
	              <td colspan="4">
	              	<div class="comment_list_td" id="comment_list_div">
	              		<span class="comment_details">${comments.commentContent}</span>
	              	</div>
	              </td>
	            </tr>
            </c:forEach>
        </c:when>
      </c:choose>
          </table>
      </div>
    </div>
  </div>
  
  <script>
  
  	function updateComments(){
  		var html = "";
  		
  		
  		
  	}
  
  
  
  
  
  
  
  
  
  
  </script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>