<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>
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
        <h2 class="h2d">최근 공지사항<a href="#"><i class="fas fa-plus con1" style="color: #5b18ff;"></i></a></h2>
        
        <ul>
            <li><a href="#">[03/09] 개발 1팀 사무실 공사 안내</a><i class="fas fa-info" id="con1" style="color: red;"></i></li>
            <li>[03/09] 인사행정팀 전산오류 안내<i class="fas fa-info" id="con1" style="color: red;"></i></li>
            <li>[03/02] 이 달의 사원(2월) 투표 종료 안내</li>
            <li>[02/26] 구내식당 오픈 행사</li>
            <li>[02/22] 웹 애플리케이션 개발자 신입 채용 안내</li>
        </ul>
        </div>
        <div style="border-radius: 10px;">
        <h2 class="h2d">오늘 결재사항<a href="#"><i class="fas fa-plus con1" style="color: #5b18ff;"></i></a></h2>
        <ul>
            <li>[03/09] 지출결의서_개발2팀</li>
            <li>[03/09] 지출결의서_인사행정팀</li>
        </ul>
        </div>
        <div style="border-radius: 10px;">
        <h2 class="h2d">오늘 일정<a href="#"><i class="fas fa-plus con1" style="color: #5b18ff;"></i></a></h2>
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
        <h2 class="h2d">받은 쪽지함<a href="${path}/message/list"><i class="fas fa-plus con1" style="color: #5b18ff;"></i></a></h2>
        <table id="homeMessage" style="width:460px; max-height:180px; table-layout: fixed">
        	<colgroup>
			  	<col style="width:17%;"/>
			  	<col style="width:80%;"/>
		  	</colgroup>
	        <c:forEach var="receiveList" items="${receiveList}">
	        	<tr>
		        	<td style="padding:7px 0;" class="<c:out value="${receiveList.readStatus}"/>"><span class="senderName" id="s_name(${receiveList.msgNo})"><c:out value="${receiveList.userName}"/> <c:out value="${receiveList.rank}"/></span></td>
		        	<td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;" class="<c:out value="${receiveList.readStatus}"/>">
			            <a href="javascript:detailMsg(${receiveList.msgNo})" id="detail(${receiveList.msgNo})" class="<c:out value="${receiveList.readStatus}"/>">
							<c:out value="${receiveList.msgContent}"/>
						</a>
					</td>
				</tr>
				<div class="modal_view fade modalNo${receiveList.msgNo}">
					    <div class="bg"></div>
					    <div class="modalContainer">
					      <h2 style="margin-left: 18px; font-size:27px; border:none; margin-top:12px;">받은쪽지</h2>
					        <div class="view_form info" style="margin-left:20px; text-align:left;">
					          <input type="hidden" id="msgNo${receiveList.msgNo}" value="<c:out value="${receiveList.msgNo}"/>">
					          <input type="hidden" id="sName${receiveList.msgNo}" value="<c:out value="${receiveList.userName}"/>">
					          <input type="hidden" id="sRank${receiveList.msgNo}" value="<c:out value="${receiveList.rank}"/>">
					          <input type="hidden" id="sDept${receiveList.msgNo}" value="<c:out value="${receiveList.deptName}"/>">
					          <input type="hidden" id="readCheck${receiveList.msgNo}" value="<c:out value="${receiveList.readStatus}"/>">
					          
					          <label>From : <c:out value="${receiveList.userName}"/> <c:out value="${receiveList.rank}"/> (<c:out value="${receiveList.deptName}"/>)</label> <br>
					          <label>Date : </label> <fmt:formatDate type="both" value="${receiveList.createDate}"/>
					        </div>
					        <div class ="view_form">
					        <div class = "form-control" id="contentsDiv" rows="3" name ="messageContent"  style="overflow: scroll; margin-left:20px; margin-top:10px;">
					       		<p style="text-align:left; margin:5px;">${ fn:replace(receiveList.msgContent, replaceChar, "<br/>" )}</p> 
					        </div>
					        </div>
					        <div class="msg_btns">
				       		 <button type="button" id ="exitBtn(${receiveList.msgNo})">닫기</button>
					        </div>
					       
					    </div>
					  </div>
	        </c:forEach>
        </table>
        </div>
        <div style="border-radius: 10px;">
        <h2 class="h2d">진행중인 프로젝트<a href="${path}/project/list"><i class="fas fa-plus con1" style="color: #5b18ff;"></i></a></h2>
        <c:forEach var="projectList" items="${projectList}" varStatus="status">
	        <p style="margin:11px;">
	        	${status.count}. 
	        	<fmt:formatDate var="sDate" value="${projectList.startDate}" pattern="yyyy-MM-dd"/>
          		<fmt:parseDate var="strDate" value="${sDate}" pattern="yyyy-MM-dd"/>
          		<fmt:parseNumber value="${strDate.time / (1000*60*60*24)}" integerOnly="true" var="SDate"></fmt:parseNumber>
          		<fmt:formatDate var="dDate" value="${projectList.dueDate}" pattern="yyyy-MM-dd"/>
          		<fmt:parseDate var="endDate" value="${dDate}" pattern="yyyy-MM-dd"/>
          		<fmt:parseNumber value="${endDate.time / (1000*60*60*24)}" integerOnly="true" var="EDate"></fmt:parseNumber>
       			<span style="color:red;">[D - ${EDate - SDate}] </span>
	        	<a href="javascript:projectView(${projectList.projectNo})" id="detail(${projectList.projectNo})"><c:out value="${projectList.projectTitle}"/></a>
	        </p>
	        <div class="modal_project fade proNo${projectList.projectNo}">
		    <div class="bg"></div>
		    <div class="proContainer" style="border-radius:35px">
		        <div class="view_form info">
		          <input type="hidden" id="pojectNo${projectList.projectNo}" value="<c:out value="${projectList.projectNo}"/>">
		          <input type="hidden" id="sName${projectList.projectNo}" value="<c:out value="${projectList.userName}"/>">
		          <div class="titleDiv pj${ status.count }" style="border-top-left-radius: 20px; border-top-right-radius: 20px;">
		          		<p id="proTitle"><i class="far fa-newspaper"></i> <c:out value="${projectList.projectTitle}"/></p>
		          </div>
		          <div class="project_info" style="margin:20px; text-align:left;">
		          		<label><span style="font-size:20px; font-weight:600;">참여자 :  </span><c:out value="${projectList.userName}"/>님 포함 총 <c:out value="${projectList.projectCount}"/>명</label>
							<a href="${path}/message/list" title="쪽지함으로 이동" style="font-size:20px;"> <i class="far fa-comments"></i></a> <br>
							<div style="border:2px solid lightgrey; padding:10px; margin: 10px 0px;border-radius:15px; min-height:50px; overflow: auto;">
								<c:out value="${projectList.participant}"/>
							</div>        			
		          		<label>
		          		<fmt:formatDate var="sDate" value="${projectList.startDate}" pattern="yyyy-MM-dd"/>
		          		<fmt:parseDate var="strDate" value="${sDate}" pattern="yyyy-MM-dd"/>
		          		<fmt:parseNumber value="${strDate.time / (1000*60*60*24)}" integerOnly="true" var="SDate"></fmt:parseNumber>
		          		<fmt:formatDate var="dDate" value="${projectList.dueDate}" pattern="yyyy-MM-dd"/>
		          		<fmt:parseDate var="endDate" value="${dDate}" pattern="yyyy-MM-dd"/>
		          		<fmt:parseNumber value="${endDate.time / (1000*60*60*24)}" integerOnly="true" var="EDate"></fmt:parseNumber>
		          			<span style="font-size:20px; font-weight:600;"> 프로젝트 일정 : </span> ${sDate} ~ ${dDate}
		          			<span style="color:red;">( D - ${EDate - SDate} )</span>
		          		</label> 
		          </div>
		        </div>
		        <div class ="view_form">
			        <div class = "form-control" id="contentsDiv" rows="3" name ="messageContent"  style="overflow: auto; margin-left:20px; margin-top:10px;">
			       		<p style="text-align:left; margin:5px;">${ fn:replace(projectList.projectContent, replaceChar, "<br/>" )}</p> 
			        </div>
		        </div>
		        <div class="project_btns">
	       		 <button type="button" id="exitBtn(${projectList.projectNo})">닫기</button>
		        </div>
		    </div>
		  </div>	
        </c:forEach>
        </div>
        <div style="border-radius: 10px; grid-row: 6 / 9;">
        <h2>Community <i class="fas fa-shopping-cart"></i></h2>
	        
        </div>
    </div>
    <div class="flex-grid" style="height:230px; ">
      <div style="border-radius: 10px;">
      <h2>임직원 소식 <i class="far fa-newspaper"></i></h2>
      	신입사원 or 생일 등등 나오는칸
      </div>
      <div style="border-radius: 10px;">
      <h2>MEMO <i class="fas fa-check"></i><br>
      	<input type="text" id="todoWrite" style="margin-top:10px; height:25px; width:55%; border:2px solid #5b18ff; border-radius:5px; margin-left:20px;">
  		<button type="button" onclick="addButton();" id="addBtn" style="height:25px; width:50px; border: 1px solid lightgrey; border-radius:5px;">add</button>
  		<button type="button" onclick="saveButton();" id="saveBtn" style="height:25px; width:50px; border: 1px solid lightgrey; border-radius:5px;">save</button>
  		<button type="button" onclick="clearButton();" id="removeBtn" style="height:25px; width:50px; border: 1px solid lightgrey; border-radius:5px;">Clear</button>
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
	
	function clearButton(){
		Swal.fire({
			  text: '메모를 지우시겠습니까?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: 'lightgrey',
			  confirmButtonText: 'YES!'
			}).then((result) => {
			  if (result.isConfirmed) {
					$.ajax({
						type: "post",
						url:"${path}/home/memo/clear",
						success:function(data){
							$("#todoList").empty();
						},
						error: function(e){
							console.log(e);
						}
					}); 
				}
			})
	}
	
	function detailMsg(msgNo){
		var msgNo = msgNo;
		var readCheck = $("#readCheck"+ msgNo).val();
		
		console.log(readCheck);
		console.log(msgNo);
		
		if(readCheck == 'N'){
			$.ajax({
				type: "get",
				url:"${path}/message/readCheck",
				data:{
					msgNo:msgNo
				},
				success:function(data){
					document.querySelector(".modalNo" + msgNo).classList.remove("fade");
				},
				error: function(e){
					alert("실패");
					console.log(e);
				}
			});
		}
		
		const open = () => {
	      document.querySelector(".modalNo" + msgNo).classList.remove("fade");
	    }
	  
	    const close = () => {
	      document.querySelector(".modalNo" + msgNo).classList.add("fade");
	    }
		  
	    document.getElementById('detail('+ msgNo +')').addEventListener("click", open);
	    document.getElementById('exitBtn('+ msgNo +')').addEventListener("click", close);
	    document.querySelector(".bg").addEventListener("click", close);
	}
	
	function projectView(projectNo){
		var projectNo = projectNo;
		
		const open = () => {
	      document.querySelector(".proNo" + projectNo).classList.remove("fade");
	    }
	  
	    const close = () => {
	      document.querySelector(".proNo" + projectNo).classList.add("fade");
	    }
		  
	    document.getElementById('detail('+ projectNo +')').addEventListener("click", open);
	    document.getElementById('exitBtn('+ projectNo +')').addEventListener("click", close);
	    document.querySelector(".bg").addEventListener("click", close);
	}
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
