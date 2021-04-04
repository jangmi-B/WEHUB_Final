<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

    <div class="index_section">
      <ul>
        <li>인명관리
          <ul>
            <li>사원 조회</li>
            <!-- <li>example</li> -->
          </ul>
        </li>
        
        <div class="line"></div>
        <li>업체
          <ul>
            <li>연락처 조회</li>
            <!-- <li>example</li> -->
          </ul>
        </li>
      </ul>
    </div>

<form class="HM_Area" action="${path}/memberInfo/list" method="get">

  <div>
    <!-- SearchBar -->
    <div class="HM_Department_Sel">
        <select name="searchList">
            <option value="all"<c:out value="${map.searchList == 'all'?'selected':''}"/> >전체</option>
            <option value="dept_name"<c:out value="${map.searchList == 'dept_name'?'selected':''}"/>>부서</option>
            <option value="user_name"<c:out value="${map.searchList == 'user_name'?'selected':''}"/>>이름</option>
            <option value="rank"<c:out value="${map.searchList == 'rank'?'selected':''}"/>>직급</option>
        </select>&nbsp;
        <input type="text" class="HM_searchArea" name="searchText" placeholder="검색">
        <button type="submit" class="HM_searchBox"><i class="fas fa-search"></i></button>
        <!-- <input type="text" class="search form-control" placeholder="검색어를 입력해주세요"> -->
        
    </div>
  </div>

  <table class="HM_TableArea checkbox_group" cellpadding="0" cellspacing="0" border="0">
    <thead class="HMtbody">
        <tr class="header_th">
            <th class="HM_trTag HM_NameTr" colspan="2">이름</th>
            <th class="HM_trTag HM_RankTr" width="125px">직급</th>
            <th class="HM_trTag HM_DepartmentTr">부서</th>
            <th class="HM_trTag HM_PhoneTr">휴대폰</th>
            <th class="HM_trTag HM_EmailTr">이메일</th>
            <th class="HM_trTag HM_TelephoneTr">내선전화</th>
        </tr>
        <div class="HM_thUnderLine">
            <label id="HM_underArea"></label>
        </div>
    </thead>
    <tbody>
    	<c:choose>
    		<c:when test=" ${ SearchList == null || SearchList.size() == 0 }">
    			<tr><td colspan="8" align="center"> 존재하지 않습니다.</td></tr>
    		</c:when>
    		<c:when test="${ SearchList != null}">
   				<c:forEach var="list" items="${SearchList}">
			        <tr>
			            <td class="HM_tdTag HM_UserImgTd"><img class="HM_userProfileBox" src="${path}/image/프로필이미지.png"></td>
			            <td class="HM_tdTag HM_NameTd">${list.user_name}</td>
			            <td class="HM_tdTag HM_RankTd">${list.rank}</td>
			            <td class="HM_tdTag HM_DepartmentTd">${list.dept_name}</td>
			            <td class="HM_tdTag HM_PhoneTd">${list.phone}</td>
			            <td class="HM_tdTag HM_EmailTd">${list.email}</td>
			            <td class="HM_tdTag HM_TelephoneTd">${list.comcall}</td>
			        </tr>
		        </c:forEach>
        	</c:when>
        </c:choose>
    </tbody>
  </table>
</form>

  <!-- 하단 페이징 -->
  <div class="HM_paging">
    <button class="HM_pagingBtn HMltlt" onclick="location.href='${path}/memberInfo/list?page=1&searchText=${map.searchText}&searchList=${map.searchList}'">처음페이지</button>&nbsp;&nbsp;
    
    <button class="HM_pagingBtn" id="HM_pagingBtnId" onclick="location.href='${path}/memberInfo/list?page=${info.getPrvePage()}&searchText=${map.searchText}&searchList=${map.searchList}'">&lt;&lt;</button>&nbsp;&nbsp;
    <c:forEach var="page" begin="${info.getStartPage()}" end="${info.getEndPage()}">
    	<c:choose>
    		<c:when test="${page} == ${info.getCurrentPage()}">
    			<button disabled="disabled" class="HM_pagingBtn" id="HM_pagingBtnId">${page}</button>
    		</c:when>
    		<c:otherwise>
			    <button class="HM_pagingBtn" id="HM_pagingBtnId" onclick="location.href='${path}/memberInfo/list?page=${page}&searchText=${map.searchText}&searchList=${map.searchList}'">${page}</button>&nbsp;&nbsp;
    		</c:otherwise>
    	</c:choose>
    </c:forEach>
    <button class="HM_pagingBtn" id="HM_pagingBtnId" onclick="location.href='${path}/memberInfo/list?page=${info.getNextPage()}&searchText=${map.searchText}&searchList=${map.searchList}'">&gt;&gt;</button>&nbsp;&nbsp;
    <button class="HM_pagingBtn" id="HM_pagingBtnId" onclick="location.href='${path}/memberInfo/list?page=${info.getMaxPage()}&searchText=${map.searchText}&searchList=${map.searchList}'">마지막페이지</button>
  </div>
  
 <%@ include file ="../common/footer.jsp" %>