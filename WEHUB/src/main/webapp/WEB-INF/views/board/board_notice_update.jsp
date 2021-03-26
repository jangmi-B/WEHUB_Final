<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

  <form action="${path}/notice/list" id="notice_bar" method="get">
	<div>
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
                <td><input id="notice_search" type="search" name="notice_search" placeholder="공지사항 검색"></td>
                <td><button type="submit">Go</button></td>
              </tr>
            </table>
        </ul>
      </div>
    </form>
    <div class="notice_contents">
      <div id="notice_list_contents">
        <form action="${path}/notice/update" method="post" enctype="multipart/form-data">
        	<input type="hidden" name="noticeNo" value = "${notice.noticeNo}">
        	<input type="hidden" name="userId" value = "${notice.userId}">
			<input type="hidden" name="noticeOriginalFileName" value = "${notice.noticeOriginalFileName}">
			<input type="hidden" name="noticeRenamedFileName" value = "${notice.noticeRenamedFileName}">
          <table>
          	<tr>
          	<c:if test="${ notice.noticeType == 'Y' }">
              <td><input class="notice_checkbox" type="checkbox" name="noticeType" checked></td>
            </c:if>
            <c:if  test="${ notice.noticeType == 'N' }">
              <td><input class="notice_checkbox" type="checkbox" name="noticeType" unchecked></td>
            </c:if>
              <td>중요공지 <i class="fas fa-exclamation-triangle"></i></td>
            </tr>
            <tr>
              <td>제목</td>
              <td><input class="notice_input" type="text" name="noticeTitle" value="${ notice.noticeTitle }"></td>
            </tr>
            <tr>
              <td>작성자</td>
              <td><input class="notice_input" type="text" name="noticeUserName" value="${notice.noticeUserName}" readonly></td>
            </tr>
            <tr>
              <td>내용</td>
              <td><textarea name="noticeContent" cols="130" rows="30"><c:out value="${notice.noticeContent}"/></textarea></td>
            </tr>
            <tr>
              <td>첨부파일</td>
              <td>
              	<input type="file" name="reloadFile">
              </td>
            </tr>
            <tr>
			<c:if test="${ !empty notice.noticeOriginalFileName }">
			  <td>파일명</td>
              <td>
				<a href="${ path }/resources/upload/notice/${ notice.noticeRenamedFileName }" download="${ notice.noticeOriginalFileName }">
					${ notice.noticeOriginalFileName }
				</a>
              </td>
			</c:if>
            </tr>
          </table>
          <div id="notice_btn">
            <button id="n_btn" class="notice_btn" type="submit">수정하기</button>
            <button class="notice_btn" type="reset" onclick="location.href='${path}/notice/view?noticeNo=${notice.noticeNo }'">취소</button>
          </div>
        </form>
      </div>
    </div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>