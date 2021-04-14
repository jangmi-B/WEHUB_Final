<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<form style="margin-top: -90px; margin-left: -230px;">
<!-- <div class="search">
    <table>
        <tr>
            <td>
                <i class="fa fa-search" aria-hidden="true"></i>
            </td>
            <td>
                <input type='text' class='src' placeholder='검색어를 입력하세요.'/>
            </td>
        </tr>
    </table>
</div> -->
<div id="contentForm">
    <div class="flex-grid" style="grid-row:1;">
        <div style="border-radius: 10px; height:270px;" >
        <h2 class="h2d">최근 공지사항<a href="#"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        
        <ul>
            <li><a href="#">[03/09] 개발 1팀 사무실 공사 안내</a><i class="fas fa-info" id="con1" style="color: red;"></i></li>
            <li>[03/09] 인사행정팀 전산오류 안내<i class="fas fa-info" id="con1" style="color: red;"></i></li>
            <li>[03/02] 이 달의 사원(2월) 투표 종료 안내</li>
            <li>[02/26] 구내식당 오픈 행사</li>
            <li>[02/22] 웹 애플리케이션 개발자 신입 채용 안내</li>
        </ul>
        </div>
        <div style="border-radius: 10px;">
        <h2 class="h2d">오늘 결재사항<a href="#"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        <ul>
            <li>[03/09] 지출결의서_개발2팀</li>
            <li>[03/09] 지출결의서_인사행정팀</li>
        </ul>
        </div>
        <div style="border-radius: 10px;">
        <h2 class="h2d">오늘 일정<a href="#"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        <ul>
            <li>09시 50분 팀 회의</li>
            <li>15시 20분 거래처 방문</li>
            <li>18시 00분 앙 퇴근띠</li>
            <li>20시 30분 치맥</li>
        </ul>
        </div>
    </div>
    
    <div class="flex-grid" style="height:270px;">
        <div style="border-radius: 10px;">
        <h2 class="h2d">받은 쪽지함<a href="#"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        Some Content
        </div>
        <div style="border-radius: 10px;">
        <h2 class="h2d">진행중인 프로젝트<a href="#"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        Some Content
        </div>
        <div style="border-radius: 10px; grid-row: 6 / 9;">
        <h2>Community <i class="fas fa-shopping-cart"></i></h2>
	        
        </div>
    </div>
    <div class="flex-grid" style="height:210px; ">
      <div style="border-radius: 10px;">
      <h2>임직원 소식 <i class="far fa-newspaper"></i></h2>
      	신입사원 or 생일 등등 나오는칸
      </div>
      <div style="border-radius: 10px;">
      <h2>MEMO <i class="fas fa-check"></i><br>
      	<input type="text" id="todoWrite" style="margin-top:10px; height:25px; width:55%; border:1px solid #5b18ff; border-radius:5px; margin-left:20px;">
  		<button type="button" onclick="addButton();" id="addBtn" style="height:25px; width:50px; border: 1px solid lightgrey; border-radius:5px;">add</button>
  		<button type="button" onclick="saveButton();" id="saveBtn" style="height:25px; width:50px; border: 1px solid lightgrey; border-radius:5px;">save</button>
  		<button type="button" id="removeBtn" style="height:25px; width:50px; border: 1px solid lightgrey; border-radius:5px;">Clear</button>
      </h2>
        <div id="memoDiv" style="overflow: auto;">
	        <ul id="todoList">
		        <c:forEach var="memo" items="${memoContent}">
		        	<li><c:out value="${memo}"/></li>
		        </c:forEach>
	        </ul>
        </div>
      </div>
  	</div>
</div> 
</form>

<script>
	function addButton(){
		let input = document.getElementById('todoWrite');
		let list = document.getElementById('todoList');
		let temp = document.createElement('li');
		
		temp.innerHTML = "■ " + input.value;
		list.appendChild(temp);
		
		input.value="";
		input.focus();
		
	}
	
	function saveButton(){
		var memoList = document.getElementsByClassName('memoList');
		var memoArray= new Array();
		var tempArray = new Array();
		$("#todoList li").each(function(){
		    tempArray.push($(this).attr("class","memoList"));
		});
		
		for(var i=0; i<memoList.length;i++){
			memoArray.push(memoList[i].innerText);
		}
		
		$.ajax({
			type: "post",
			url:"${path}/home/memo",
			data:{
				memoArray:memoArray
			},
			success:function(data){
			},
			error: function(e){
				console.log(e);
			}
		});  
	}
	
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
