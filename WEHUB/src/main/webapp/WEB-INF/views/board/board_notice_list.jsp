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
      <div class="notice_list_wrap">
        <div class="notice_list">
            <p>공지사항</p>
            <button id="notice_list_btn" type="button" onclick="location.href ='${path}/notice/write'">글쓰기</button>
            <table id="notice_list_table">
              <tr style="border-bottom: 1px solid gray;">
                <th>No</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일자</th>
                <th>첨부파일</th>
                <th>댓글</th>
                <th>조회</th>
              </tr>
              <c:if test="${list == null}">
				<tr>
					<td colspan="7">
						조회된 게시글이 없습니다.
					</td>
				</tr>	
			  </c:if>
			  <c:if test="${staticList != null}">
				<c:forEach var="notice" items="${staticList}">
					<tr class="staticList">
						<td><i class="fas fa-exclamation-triangle"></i></td>
						<td>
							<a href="${path}/notice/view?noticeNo=${notice.noticeNo}">
								<c:out value="${notice.noticeTitle}"/>
							</a>
						</td>
						<td>${ notice.noticeUserName }</td>
						<td><fmt:formatDate type="both" value="${notice.noticeCreateDate}"/></td>
						<td>
	            			<c:if test="${notice.noticeOriginalFileName != null}">
            					<i class="far fa-save"></i>
            				</c:if>
	            			<c:if test="${notice.noticeOriginalFileName == null}">
            					<span> - </span>
            				</c:if>
						</td>
						<td class="staticList"><c:out value="${notice.noticCommentCount}"/></td>
						<td class="staticList"><c:out value="${notice.noticeReadCount}"/></td>
					</tr>		
				  </c:forEach>
			  </c:if>
			  <c:if test="${list != null}">
				<c:forEach var="notice" items="${list}">
					<tr>
						<td><c:out value="${notice.rownum}"/></td>
						<td>
							<a href="${path}/notice/view?noticeNo=${notice.noticeNo}">
								<c:out value="${notice.noticeTitle}"/>
							</a>
						</td>
						<td>${ notice.noticeUserName }</td>
						<td><fmt:formatDate type="both" value="${notice.noticeCreateDate}"/></td>
						<td>
	            			<c:if test="${notice.noticeOriginalFileName != null}">
            					<i class="far fa-save"></i>
            				</c:if>
	            			<c:if test="${notice.noticeOriginalFileName == null}">
            					<span> - </span>
            				</c:if>
						</td>
						<td><c:out value="${notice.noticCommentCount}"/></td>
						<td><c:out value="${notice.noticeReadCount}"/></td>
					</tr>		
				  </c:forEach>
			  </c:if>
              
            </table>
            <div class="notice_list_page">
              <ul class="notice_pagination modal">
              <c:if test="${notice_search == null}">
	                <li><button type="button" class="notice_page_first" onclick="location.href='${path}/notice/list?page=1'">처음페이지</button></li>
	                <li><button type="button" class="notice_arrow_left" onclick="location.href='${path}/notice/list?page=${pageInfo.prvePage}'">&lt;&lt;</button></li>
	                <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
						<c:if test="${status.current == pageInfo.currentPage}">
							<li><button disabled><c:out value="${status.current}"/></button></li>
		   				</c:if>
						<c:if test="${status.current != pageInfo.currentPage}">
							<li><button onclick="location.href='${path}/notice/list?page=${status.current}'"><c:out value="${status.current}"/></button></li>
		   				</c:if>
					</c:forEach>
	                <li><button type="button" class="notice_arrow_right" onclick="location.href='${path}/notice/list?page=${pageInfo.nextPage}'">&gt;&gt;</button></li>
	                <li><button type="button" class="notice_page_last" onclick="location.href='${path}/notice/list?page=${pageInfo.maxPage}'">마지막페이지</button></li>
              </c:if>
              <c:if test="${notice_search != null}">
	              	<li><button type="button" class="notice_page_first" onclick="location.href='${path}/notice/list?notice_search=${notice_search}&page=1'">처음페이지</button></li>
		            <li><button type="button" class="notice_arrow_left" onclick="location.href='${path}/notice/list?notice_search=${notice_search}&page=${pageInfo.prvePage}'">&lt;&lt;</button></li>
		                <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
							<c:if test="${status.current == pageInfo.currentPage}">
							<li><button disabled><c:out value="${status.current}"/></button></li>
		   				</c:if>
						<c:if test="${status.current != pageInfo.currentPage}">
							<li><button onclick="location.href='${path}/notice/list?notice_search=${notice_search}&page=${status.current}'"><c:out value="${status.current}"/></button></li>
		   				</c:if>
					</c:forEach>
	                <li><button type="button" class="notice_arrow_right" onclick="location.href='${path}/notice/list?notice_search=${notice_search}&page=${pageInfo.nextPage}'">&gt;&gt;</button></li>
	                <li><button type="button" class="notice_page_last" onclick="location.href='${path}/notice/list?notice_search=${notice_search}&page=${pageInfo.maxPage}'">마지막페이지</button></li>
              </c:if>
	          </ul>
            </div>
        </div>
      </div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>