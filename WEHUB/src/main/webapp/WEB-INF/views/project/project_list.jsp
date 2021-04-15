<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="index_section">
      <ul>
        <li><h1>Project <i class="fas fa-project-diagram"></i></h1>
          <span style="font-size:13px;">(프로젝트 진행상황 공유) </span>
          <div class="line"></div>
          <ul>
            <li><button type="button" class="make_project_btn" onclick="makeProject();"> Make Project </button></li>
            <li><a href="${path}/project/list">전체프로젝트</a></li>
            <li><a href="${path}/project/participant">참여중인 프로젝트</a></li>
            <li><a href="${path}/project/favorite">즐겨찾기</a></li>
          </ul>
        </li>
        <div class="line"></div>
    </div>

    <div class="projectWrap">
      <div class="project_search">
      <form action="${path}/project/list" method="get">
        <input id="pInput" type="search" placeholder="Search Project" name="searchText">
        <button id="pBtn" type="submit">Go</button>
      </form>
      </div>
      <div class="projectBox">
      <c:if test="${projectList != null}">
      	<c:forEach var="projectList" items="${projectList}" varStatus="status">
	        <div class="pojectdiv" id="projectDivNo${projectList.projectNo}">
      		<input type="hidden" name="projectNo" value="<c:out value="${projectList.projectNo}"/>">
      		<input type="hidden" id="favStatus" name="projectStatus" value="<c:out value="${projectList.status}"/>">
	          <div class="projextdivIn pj${ status.count }">
	            <a href="javascript:projectView(${projectList.projectNo})" id="detail(${projectList.projectNo})"><c:out value="${projectList.projectTitle}"/></a>
	          </div>
	          <div class="projectdivInfo pj${ status.count }">
	            <span style=""><c:out value="${projectList.userName}"/>님 외 총 <c:out value="${projectList.projectCount}"/>명</span>
	            <a href="javascript:clickFav(${projectList.projectNo})" id="favBtn" class="fav${projectList.bookmark}" style="font-size:30px;"><i class="fas fa-star"></i></a>
	          </div>
	        </div>
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
	        	 <button style="width:100px; background:" type="button" id="deleteBtn(${projectList.projectNo})" class="pj${ status.count }" onclick="closeProject(${projectList.projectNo});">프로젝트종료</button>
	       		 <button type="button" id="exitBtn(${projectList.projectNo})">닫기</button>
		        </div>
		    </div>
		  </div>
      	</c:forEach>
      </c:if>
     	 <div class="project_page">
              <ul class="notice_pagination">
                <li><button type="button"  onclick="location.href='${path}/project/list?page=1'">처음페이지</button></li>
                <li><button type="button"  onclick="location.href='${path}/project/list?page=${pageInfo.prvePage}'">&lt;&lt;</button></li>
                <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
					<c:if test="${status.current == pageInfo.currentPage}">
						<li><button disabled><c:out value="${status.current}"/></button></li>
	   				</c:if>
					<c:if test="${status.current != pageInfo.currentPage}">
						<li><button onclick="location.href='${path}/project/list?page=${status.current}'"><c:out value="${status.current}"/></button></li>
	   				</c:if>
				</c:forEach>
                <li><button type="button" onclick="location.href='${path}/project/list?page=${pageInfo.nextPage}'">&gt;&gt;</button></li>
                <li><button type="button" onclick="location.href='${path}/project/list?page=${pageInfo.maxPage}'">마지막페이지</button></li>
	          </ul>
          </div>
     </div>
   </div>
   
   
<div class="modal_pro fade">
    <div class="bg"></div>
    <div class="projectContainer" style="border:1px solid grey; border-radius:20px">
      <h2 style="margin-left:18px;">프로젝트 생성 </h2>
        <div class="projectInfo" style="margin-left:20px;">
      	  <input type="hidden" id="projectWriter" name="projectMake" value="<c:out value="${loginMember.user_no}"/>">
          <label><span style="font-size:17px; font-weight:400;">프로젝트명</span> : <input type="text" id="projectTitle" style="width:400px; border:none;" name="projectTitle"></label><br>
          <label>참가자 : </label> <input type="text" id="memSearch" name="userName">
          <button style="width:50px; height:30px; background:navy; " type="button" id="partBtn" onclick="addParticipant();">추가</button>
          <div id="participantDiv" name="participant" style="border:2px solid lightgrey; overflow: auto; border-radius:5px; font-size: 15px;margin-bottom: 10px;height: 50px; width:96%;" ></div>
          <label>프로젝트 진행기간 : 
          <input type="text" id="startDate" name="startDate" style="width:270px; height:35px; margin:0px 5px; border:2px solid lightgrey; border-radius:5px;"> ~ 
          <input type="text" id="dueDate" name="dueDate" style="width:270px; height:35px; margin:0px 5px; border:2px solid lightgrey; border-radius:5px;"></label>
        </div>
        <div style="float:right; padding-right:25px; font-size:12px; margin-top:15px;">
          (<span id="writeCnt">0</span>/<span id="writeMax">900</span>)
        </div>
        <div class ="write_form">
          <textarea class = "form-control" rows="3" id="projectContent" name ="projectContent" style="overflow: auto; font-size:15px;"></textarea>
        </div>
        <div class ="write_form">
	        <button type="button" id="makeBtn" class ="makeBtn">프로젝트생성</button>
	        <button type="button" class ="closeBtn">닫기</button>
        </div>
    </div>
  </div>   

<script>
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
	
	function clickFav(proNum){
		var className = $('#favBtn').attr('class');
		console.log(classId);
		$.ajax({
			type: "post",
			url:"${path}/project/makeFav",
			data:{
				proNum:proNum
			},
			success:function(data){
				if(className == 'favY'){
					$('#favBtn').attr('class','favN');
					$('#favBtn').css('color', 'white');
				}else {
					$('#favBtn').attr('class','favY');
					$('#favBtn').css('color', 'yellow');
				}
			},
			error: function(e){
				alert("즐겨찾기 실패");
				console.log(e);
			}
		});
	}
	
	
	function makeProject(){
		const open = () => {
	      document.querySelector(".modal_pro").classList.remove("fade");
	    }
	  
	    const close = () => {
	      document.getElementById("memSearch").value= "";
	      document.getElementById("projectContent").value= "";
	      document.querySelector(".modal_pro").classList.add("fade");
	    }
	  
	    document.querySelector(".make_project_btn").addEventListener("click", open);
	    document.querySelector(".closeBtn").addEventListener("click", close);
	    
	    $("#projectContent").on("keyup",function(){
	        let inputLength = $(this).val().length;
	
	        $("#writeCnt").text(inputLength);
	
	        let remain = $("#writeMax").text() - inputLength;
	
	        if(remain < 0){
	          $("#writeCnt").css("color","red");
	        } else {
	          $("#writeCnt").css("color","black");
	        }
	      });
	}
	
	function closeProject(proNo){
		console.log(proNo);
		Swal.fire({
			  title: '프로젝트를 정말 종료하시겠습니까?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '네 종료하겠습니다!'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						type: "post",
						url:"${path}/project/close",
						data:{
							proNo:proNo
						},
						success:function(data){
							console.log(data)
							
							var closeProject = document.getElementById('projectDivNo'+ proNo);
							closeProject.remove();
							document.querySelector(".proNo" + proNo).classList.add("fade");
						},
						error: function(e){
							Swal.fire({
								  icon: 'error',
								  text: '프로젝트 종료 실패! 관리자에게 문의하세요'
								})
							console.log(e);
						}
					});  
				  
			    Swal.fire({
			    	icon: 'success',
					text: '프로젝트가 성공적으로 종료되었습니다 :)'
			    })
			  }
			})
	}
	
	$(function(){
		$("#makeBtn").on("click",function(){
			let projectWriter = $("#projectWriter").val();
			let participant = $("#participantDiv").text();
			let projectContent = $("#projectContent").val();
			let projectTitle = $("#projectTitle").val();
			let startDate = $("#startDate").val();
			let dueDate = $("#dueDate").val();
			let writeCnt = parseInt($("#writeCnt").text());
			let writeMax = parseInt($("#writeMax").text());
			let msgContent = projectTitle + " 프로젝트에 참여되었습니다. :)" + "\n\n" + "▶ 프로젝트 내용  " + "\n" + projectContent;
			
			if(projectTitle == ""){
				Swal.fire({
					  icon: 'error',
					  text: '프로젝트명을 작성하지 않으셨습니다.!',
					  didClose: () => {
						  $('#projectTitle').focus();
					  }
					})
			} else if(startDate == ""){
				Swal.fire({
					  icon: 'error',
					  text: '프로젝트 시작기간을 작성하지 않으셨습니다.!',
					  didClose: () => {
						  $('#startDate').focus();
					  }
					})
			} else if(dueDate == ""){
				Swal.fire({
					  icon: 'error',
					  text: '프로젝트 마감기간을 작성하지 않으셨습니다.!',
					  didClose: () => {
						  $('#dueDate').focus();
					  }
					})
			} else if(projectContent == ""){
				Swal.fire({
					  icon: 'error',
					  text: '내용을 작성하지 않으셨습니다.!',
					  didClose: () => {
						  $('#projectContent').focus();
					  }
					})
			} else if(writeCnt > 900){
				console.log(writeCnt);
				console.log(writeMax);
				
				Swal.fire({
					  icon: 'error',
					  text: writeMax + "자를 초과입력할 수 없습니다.!",
					  didClose: () => {
						  $('#projectContent').focus();
					  }
					})
			} else{
				$.ajax({
					type: "post",
					url:"${path}/project/make",
					data:{
						projectMake:projectWriter,
						participant:participant,
						projectContent:projectContent,
						projectTitle:projectTitle,
						startDate:startDate,
						dueDate:dueDate,
						writeCnt:writeCnt,
						writeMax:writeMax
					},
					success:function(data){
						$.ajax({
							type: "post",
							url:"${path}/project/message",
							data:{
								msgFrom:projectWriter,
								userName:participant,
								msgContent:msgContent
							},
							success:function(data){
								console.log(data)
							},
							error: function(e){
								alert("프로젝트 쪽지보내기 실패");
								console.log(e);
							}
						});
						
						Swal.fire({
	                        icon: 'success',
	                        text: '프로젝트가 성공적으로 등록되었습니다.'
	                    });
						
						document.getElementById("projectTitle").value= "";
						document.getElementById("participantDiv").innerText = "";
						document.getElementById("startDate").value= "";
						document.getElementById("dueDate").value= "";
					    document.getElementById("projectContent").value= "";
					    
						document.querySelector(".modal_pro").classList.add("fade");
					},
					error: function(e){
						alert("실패");
						console.log(e);
					}
				});
			}
		});
	});
	
	$(document).ready(() => { 
		 $("#memSearch").autocomplete({
			source:function(request, response){
				$.ajax({
					url : "${path}/search/projectMem",
					type : "get",
					dataType : 'json',
					data : {
						userName:$("#memSearch").val()
					},
					success : function(data){
						var result = data;
						response(result);
					},
					error : function(e){
						alert("ajax에러발생..!")
					}
				});
			},
	       focus : function(event, ui) {    
	           return false;
	       },
	       minLength: 1,// 최소 글자수
	       autoFocus: true, 
	       delay: 300,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
		 });
	});
	
	function addParticipant(){
		let addPerson = $("#memSearch").val();
		let totalPerson = $("#participantDiv").text();
		let arr =  totalPerson.split("/ ");
		
		console.log(addPerson);
		console.log(totalPerson);
		console.log(arr);
		
		if(arr.includes(addPerson)){
			Swal.fire({
				  icon: 'error',
				  text: '참가자가 이미 존재합니다.',
				  didClose: () => {
					  document.getElementById("memSearch").value= "";
					  $('#memSearch').focus();
				  }
			})
		} else{
			$("#participantDiv").append(addPerson + "/ ");
			
			document.getElementById("memSearch").value= "";
			$('#memSearch').focus();
		}
	}
	
	$(document).ready(function () {
	    $.datepicker.setDefaults($.datepicker.regional['ko']); 
	    $( "#startDate" ).datepicker({
	         changeMonth: true, 
	         changeYear: true,
	         nextText: '다음 달',
	         prevText: '이전 달', 
	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         dateFormat: "yy-mm-dd",
	         maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
	         onClose: function( selectedDate ) {    
	              //시작일(startDate) datepicker가 닫힐때
	              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
	             $("#dueDate").datepicker( "option", "minDate", selectedDate );
	         }    
	
	    });
	    $( "#dueDate" ).datepicker({
	         changeMonth: true, 
	         changeYear: true,
	         nextText: '다음 달',
	         prevText: '이전 달', 
	         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
	         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
	         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         dateFormat: "yy-mm-dd",
	         onClose: function( selectedDate ) {    
	             // 종료일(endDate) datepicker가 닫힐때
	             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
	             $("#startDate").datepicker('setDate', 'today');
	         }    
	
	    });    
	});

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>