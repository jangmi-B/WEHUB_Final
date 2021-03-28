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
                ${ fn:replace(notice.noticeContent, replaceChar, "<br/>" )}
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
        <form id="commentForm" name="commentForm" method="post">
          <div>
              <span><strong>Comments</strong></span> <span id="cCnt">(2)</span>
              <div class="comment_line"></div>
          </div>
          <div id="comment_div">
              <table>                    
                <tr>
                  <td>
                    <textarea rows="3" cols="120" name="comment" placeholder="댓글을 입력하세요"></textarea>
                  </td>
                  <td>
                    <button class="commnet_btn" type="button">등록</button>
                  </td>
                </tr>
              </table>
          </div>
          <input type="hidden" id="b_code" name="b_code" value="" />        
        </form>
      </div>
      <div class="coment_container" id="notice_conment_list">
          <table>
            <tr>
              <td rowspan="2"><i class="far fa-user-circle"></i></td>
              <td><span class="comment_name">김철수 사원</span></td>
              <td colspan="3"><span class="comment_sub">2021-03-15 15:09:44</span></td>
              <td colspan="2"> <a href="#"> 수정</a> <a href="#">삭제</a></td>
            </tr>
            <tr>
              <td colspan="4"><div class="comment_list_td"><span class="comment_details">올해도 화이팅 합시다!</span></div></td>
            </tr>
            <tr>
              <td rowspan="2"><i class="far fa-user-circle"></i></td>
              <td><span class="comment_name">김영희 대리</span></td>
              <td colspan="3"><span class="comment_sub">2021-03-01 15:09:44</span></td>
              <td colspan="2"> <a href="#"> 수정</a> <a href="#">삭제</a></td>
            </tr>
            <tr>
              <td colspan="4"><div class="comment_list_td"><span class="comment_details">화이팅 합시다!!!</span></div></td>
            </tr>
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
</script>   

<%@ include file="/WEB-INF/views/common/footer.jsp" %>