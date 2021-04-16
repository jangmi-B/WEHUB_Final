<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <div class="index_section">
      <ul>
        <li><h1>인명관리</h1>
          <ul>
            <li onclick="location.href='${path}/memberInfo/list'">사원 조회</li>
            <c:if test="${loginMember.user_id eq 'admin'}">
            	<li onclick='insertMember()'>사원 등록</li>
            </c:if>
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
        <input type="text" class="HM_searchArea" name="searchText">
        <button type="submit" class="HM_searchBox"><i class="fas fa-search"></i></button>
        <!-- <input type="text" class="search form-control" placeholder="검색어를 입력해주세요"> -->
        
    </div>
  </div>
<div id="printArea">
  <table class="HM_TableArea checkbox_group" cellpadding="0" cellspacing="0" border="0" style="width: 80%;">
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
			            <td class="HM_tdTag HM_UserImgTd">
			            	<c:if test="${list.user_imgRename == null}">
				            	<img class="HM_userProfileBox" src="${path}/upload/userProfileImg/20210401_012704011.PNG">
			            	</c:if>
			            	<c:if test="${list.user_imgRename != null}">
				            	<img class="HM_userProfileBox" src="${path}/upload/userProfileImg/${list.user_imgRename}">
			            	</c:if>
			            </td>
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
</div>
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
  	
  	<div class="modal fade">
	    <div class="bg"></div>
	    <div class="modalNewMember" style="position: absolute; background-color: #fff; width: 400px; height: 200px; padding: 15px;">
	    	<div class="newMemberInfo" style="text-align: center;">
	    		<label style="display: block;">이름 : <input type="text" id="NewName" name="NewName" maxlength="6" style="width: 70%;margin-bottom: 20px; border-radius: 8px; border: 1px solid; font-size: 15px; text-align: center;"></label>
	    		<label style="display: block;">직급 : <input type="text" id="NewRank" name="NewRank" maxlength="10" style="width: 70%;margin-bottom: 20px; border-radius: 8px; border: 1px solid; font-size: 15px; text-align: center;"></label>
	    		<label>부서 : <input type="text" id="NewDept" name="NewDept" maxlength="10" style="width: 70%;margin-bottom: 20px; border-radius: 8px; border: 1px solid; font-size: 15px; text-align: center;"></label>
	    	</div>
	        <div class ="write_form">
		        <button type="button" onclick="sendBtn()" id="sendBtn" class ="sendBtn" style="background: none; border-radius: 13px; width: 80px; margin: 0px 30px 0px 10px; font-size: 20px;">등록</button>
		        <button type="button" class ="closeBtn" style="background: none; border-radius: 13px; width: 80px; font-size: 20px;">취소</button>
	        </div>
	    </div>
 	</div>
  
  <script>
  
  function insertMember() {
	
	      document.querySelector(".modal").classList.remove("fade");
	  
	    const close = () => {
	      document.querySelector(".modal").classList.add("fade");
	    }
		  
	    document.querySelector('.closeBtn').addEventListener("click", close);
	    document.querySelector('.sendBtn').addEventListener("click", close);
	    document.querySelector(".bg").addEventListener("click", close);
  }
  
  function sendBtn() {
	  var newName = document.getElementById('NewName').value;
	  var newRank = document.getElementById('NewRank').value;
	  var newDept = document.getElementById('NewDept').value;
	  
	  console.log(newName);
	  console.log(newRank);
	  console.log(newDept);
	  
	  
	  $.ajax({
		  	url:"${path}/insertNewMember",
		  	type:"post",
		  	data:{
		  		newName : newName,
		  		newRank : newRank,
		  		newDept : newDept,
		  	},
		  	success:function(data){
		  		swal("등록되었습니다.");
		  		
		  	},
		  	
		  	error: function(e){
				alert("실패");
				console.log(e);
			}
	  });  
  }
  
  
  
  
  </script>
  
  
 <%@ include file ="../common/footer.jsp" %>
