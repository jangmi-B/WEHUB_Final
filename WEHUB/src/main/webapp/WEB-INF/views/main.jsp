<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script type="text/javascript" src="${path}/ckeditor/ckeditor.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<form id="mainForm" style="margin-top: -90px; margin-left: -230px;">
<div id="contentForm">
    <div class="flex-grid" style="grid-row:1;">
        <div style="border-radius: 10px; height:270px; overflow: hidden;" >
        <h2 class="h2d">최근 공지사항<a href="#"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        <ul>
        <c:choose>
        	<c:when test="${NoticeList.size() == 0}">
		        <li>
		        	게시글이 존재하지 않습니다.
		        </li>
	        </c:when>
	        <c:otherwise>
		        <li>
		        	<c:forEach var="NoticeList" items="${NoticeList}" end="5" varStatus="i">
		        		<c:if test="${NoticeList.getNoticeType() eq 'Y'}">
		        			<a href="javaScript:mainNotice(${NoticeList.getNoticeNo()})"><p>[<fmt:formatDate value="${NoticeList.getNoticeCreateDate()}"  pattern="MM/dd"/>] ${NoticeList.getNoticeTitle()} <i class="fas fa-info" id="con1" style="color: red;"></i></p></a>
		        		</c:if>
		        		<c:if test="${NoticeList.getNoticeType() eq 'N'}">
		        			<a href="javaScript:mainNotice(${NoticeList.getNoticeNo()})"><p>[<fmt:formatDate value="${NoticeList.getNoticeCreateDate()}"  pattern="MM/dd"/>] ${NoticeList.getNoticeTitle()}</p></a>
		        		</c:if>
		        	</c:forEach>
		        </li>
	        </c:otherwise>
	    </c:choose>
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
	    <h2 class="h2d">오늘 일정<a href="${path}/calendar/view"><i class="fas fa-plus" id="con1" style="color: lightgray;"></i></a></h2>
	        <ul>
	        <c:choose>
	        	<c:when test="${todaySchedule.size() == 0}">
			        <li>
			        	일정을 등록해주세요
			        </li>
		        </c:when>
		        <c:otherwise>
			        <li>
			        	${todaySchedule.get(0).getSchedule_content()}
			        </li>
		        </c:otherwise>
		    </c:choose>
	        </ul>
        </div>
    </div>
    
    <div class="flex-grid" style="height:270px;">
        <div style="border-radius: 10px;">
        	<h2 class="h2d">받은 쪽지함<a href="#"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        	Some Content
        </div>
        <div style="border-radius: 10px;">
        	<h2 class="h2d">진행중인 프로젝트<a href="${path}/project/participant"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
        Some Content
        </div>
        <div style="border-radius: 10px; grid-row: 6 / 9; overflow: hidden;">
        	<h2 class="h2d">Community <i class="fas fa-shopping-cart"></i><a href="${path}/community/list"><i class="fas fa-plus con1" style="color: lightgray;"></i></a></h2>
           	<ul>
			<c:choose>
	        	<c:when test="${communityList.size() == 0}">
			        <li>
			        	게시글이 존재하지 않습니다.
			        </li>
		        </c:when>
		        <c:otherwise>
			        <li>
			        	<c:forEach var="communityList" items="${communityList}" end="5" varStatus="i">
			        	<a href="javaScript:mainCommunity(${communityList.getCm_no()})"><p>${i.count}. ${communityList.getCm_title()}</p></a>
			        	</c:forEach>
			        </li>
		        </c:otherwise>
		    </c:choose>	           		
           	</ul>
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
      let temp = document.createElement('span');
      let br = document.createElement('br');
      
      temp.innerHTML = input.value+br.innerHTML;
      list.appendChild(temp);
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
            console.log(data)
         },
         error: function(e){
            console.log(e);
         }
      });  
   }
   
   
   function mainCommunity(no){
	   console.log("헬로");
	   console.log(no);
			
			$.ajax({
				type:"GET",
				url:"${path}/community/view",
				data:{
					no:no,
				},
					
				success:function(data) {
					console.log(data)
					console.log(data.view);
					
					$('#mainForm').remove();
					
					$("<div class='CM-index_section'></div>").insertAfter('.common_section');
					$("<h1>커뮤니티</h1>").appendTo('.CM-index_section');
					$("<div class='line'></div>").appendTo('.CM-index_section');
					$("<button id='CM_write_Btn'>게시글 작성</button>").appendTo('.CM-index_section');
					var li = $("<li class='CM-form'>보관함</li>").appendTo('.CM-index_section');
					var div = $("<div></div>").appendTo(li);
					var ul = $("<ul></ul>").appendTo(div);
					var li2 = $("<li><a href='${path}/community/myList'>-내가 작성한 목록</a></li>").appendTo(ul);
					$("<li><a href='${path}/community/favList'>-즐겨찾기</a></li>").appendTo(ul);
					
					$(document).ready(function () {
					       $('.CM-form').on('click', function() {
					           $('.CM-form > div').slideToggle();
					       });
					   });
					
					$(document).ready(function() {
						$('#CM_write_Btn').one('click', function() {
							javaScript:write_Btn();
						});
					});
					
					var form = $("<form id='viewForm'></form>").insertAfter('.CM-index_section');
					var cm_mark = $("<a><i id='cm_mark' style='margin: 80px 0px 0px 510px; color: gold; font-size: 40px;' class='fas fa-star'></i><--찜하기click!</a>").appendTo(form);
					var cm_msg = $("<a><i id='cm_msg' style='margin-left: 40px; font-size: 37px; color: cornflowerblue; cursor:pointer;' class='far fa-envelope home_contents'></i><--Msg!</a>").appendTo(form);
					var divFirst = $("<div style='height: 600px; margin: 0px 400px 80px 500px; font-size: 23px; border: 1px solid; border-radius: 10px;'></div>").appendTo(form);
					
						$("<span style='display: block; float: left; padding: 0px 0px 0px 10px; font-weight: 900;'></span>").text("작성자 : " + data.view.user_name).appendTo(divFirst);
						$("<span style='display: block; text-align: end; border-bottom:1px solid black;'></span>").text("ID : " + data.view.user_id).appendTo(divFirst);
						$("<label style='display: block; border-bottom: 1px solid; height: 50px; text-align:center; padding-top: 6px; text-align: center; font-weight: 600;'>"+data.view.cm_title+"</label>").appendTo(divFirst);
						$("<div class='viewArea' id='viewArea' style='padding: 10px; overflow: scroll; height: 500px;'>"+data.view.cm_content+"</div>").appendTo(divFirst);
						
						if(data.loginMember.user_no == data.view.user_no){
							$("<button id='deleteList' style='width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >삭제</button>").insertAfter(form);
							$("<button id='returnList' style='width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >목록으로</button>").insertAfter(form);
							$("<button id='updateList' style='margin: 0px 0px 0px 40%; width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >수정</button>").insertAfter(form);
						}else {
							$("<button id='returnList' style='margin: 0px 0px 0px 48%; width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >목록으로</button>").insertAfter(form);
						}
						
					$('#cm_mark').on('click', function() {
						if(data.loginMember.user_no == data.view.user_no){
							swal({
								title:"본인입니다!",
								icon: "warning",
								button : true,
								dangerMode: true,
							});
						}else {
						if(data.view.cm_Mark == "Y"){
							javaScript:cm_deleteMark(no, data.loginMember.user_no);
							data.view.cm_Mark = "N";
							swal("즐겨찾기 해제되었습니다.");
						}else {
							javaScript:cm_bookMark(no, data.loginMember.user_no);
							data.view.cm_Mark = "Y";
							swal("즐겨찾기 추가되었습니다.")
							.then((value) => {
								swal({
								  title: "쪽지를 보내시겠습니까?",
								  icon: "info",
								  buttons: {
									  cancle : {
										  text : '취소',
										  value : false,
										  className : 'SwalCancelBtn'
									  },
									  confirm : {
										  text : '보내기',
										  value : true,
										  className : 'SwalGoMsgBtn'
									  }
								  }
								});
								
								$('.SwalGoMsgBtn').on('click', function() {
									javaScript:GoMsg(no, data.view.user_id, data.view.user_no);
								})
							});
						}
					  }
					});
					
					$('#cm_msg').on('click', function() {
						if(data.loginMember.user_no == data.view.user_no){
							swal({
								title:"본인입니다!",
								icon: "warning",
								button : true,
								dangerMode: true,
							});
						}else {
							javaScript:GoMsg(no, data.view.user_id, data.view.user_no);
						}
					});
					
					$('#returnList').on('click', function() {
						location.href="${path}/community/list"
					});
					
					$('#updateList').on('click', function() {
						swal({
							  title: "수정 하시겠습니까?",
							  icon: "warning",
							  buttons: {
								  cancle : {
									  text : '취소',
									  value : false,
									  className : 'SwalCancelBtn'
								  },
								  confirm : {
									  text : '수정',
									  value : true,
									  className : 'SwalUpdateBtn'
								  }
							  }
							})
						$(document).ready(function () {
							$('.SwalUpdateBtn').on('click',function() {
								javaScript:updateBtn(no);
							});
						});
					});
					
					$('#deleteList').on('click', function() {
						swal({
							  title: "삭제 하시겠습니까?",
							  icon: "warning",
							  buttons: {
								  cancle : {
									  text : '취소',
									  value : false,
									  className : 'SwalCancelBtn'
								  },
								  confirm : {
									  text : '삭제',
									  value : true,
									  className : 'SwalDeleteBtn'
								  }
							  },
							  dangerMode: true,
							})
							
						$(document).ready(function () {
							$('.SwalDeleteBtn').on('click',function() {
								javaScript:deleteBtn(no);
							});
						});
					});
				},
				error: function(error){
					console.log("오류오류");
				}
			});
   }
   
		function write_Btn(){
			$.ajax({
				type:"GET",
				url:"${path}/community/writeView",
				
				success:function(data) {
					console.log(data)
					
					$('#listform').remove();
					$('#CM_Content1').remove();
					$('#viewForm').remove();
					$('#returnList').remove();
					$('#searchArea').remove();
					$('#updateList').remove();
					$('#deleteList').remove();
					
					var form = $("<form id='writeForm' action='/community/writeView' method='get' enctype='multipart/form-data'></form>").insertAfter('.CM-index_section');
						var divFirst = $("<div style='height: 600px; margin: 100px 400px 80px 500px; font-size: 23px; border: 1px solid; border-radius: 10px;'></div>").appendTo(form);
						$("<span style='display: block; float: left; padding: 0px 0px 0px 10px; font-weight: 900;'></span>").text("작성자 : " + data.user_name).appendTo(divFirst);
						$("<span style='display: block; text-align: end; border-bottom:1px solid black;'></span>").text("ID : " + data.user_id).appendTo(divFirst);
						$("<label style='display: block; border-bottom: 1px solid;height: 40px;'>제목 : <input id='cm_title' type='text' style='width: 90%;height:100%;border: none; font-size: 23px;'></label>").appendTo(divFirst);
						$("<textarea class='writeArea' id='writeArea'></textarea>").appendTo(divFirst);
						CKEDITOR.replace("writeArea",{
							filebrowserUploadUrl:'${path}/community/upload'
						});
						$("<button id='cancelBtn' style='background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>취소</button>").insertAfter(form);
						$("<button id='insertBtn' style='margin: 0px 100px 0px 45%;background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>등록</button>").insertAfter(form);
						
						$('#cancelBtn').on('click', function() {
							location.href='${path}/community/list'
						});
						
						
						$('#insertBtn').on('click', function() {
							var title = $('#cm_title').val();
							var text = CKEDITOR.instances.writeArea.getData();
							
							if(title == "" || text == ""){
								swal({
									  title: "내용을 확인해주세요!",
									  icon: "warning",
									  button: "확인",
									  dangerMode: true,
									});
							}else {
								$.ajax({
									type:"POST",
									url:"write",
									data:{
										title : title,
										text : text,
									},
										
									success:function(data) {
	 									location.href="${path}/community/list"
									},
									error: function(error){
										console.log("오류오류");
									}
								});
							}
						});
					},
				error: function(error){
					console.log("오류오류");
				}
			});
		}   
		function updateBtn(no) {
			
			$.ajax({
				type:"GET",
				url:"writeView",
				data:{
					no:no,
				},
				
				success:function(data) {
					console.log(data.member);
					console.log(data.view);
					
					$('#listform').remove();
					$('#CM_Content1').remove();
					$('#viewForm').remove();
					$('#returnList').remove();
					$('#searchArea').remove();
					$('#updateList').remove();
					$('#deleteList').remove();
					
					var form = $("<form id='writeForm' action='/community/writeView' method='get' enctype='multipart/form-data'></form>").insertAfter('.CM-index_section');
						var divFirst = $("<div style='height: 600px; margin: 100px 400px 80px 500px; font-size: 23px; border: 1px solid; border-radius: 10px;'></div>").appendTo(form);
						$("<span style='display: block; float: left;'></span>").text("작성자 : " + data.member.user_name).appendTo(divFirst);
						$("<span style='display: block; text-align: end;'></span>").text("ID : " + data.member.user_id).appendTo(divFirst);
						$("<label style='display: block; border: 1px solid; border-radius: 10px;height: 50px;'>제목 : <input id='cm_title' type='text' value='"+data.view.cm_title+"' style='width: 90%;height:100%;border: none; font-size: 23px;'></label>").appendTo(divFirst);
						$("<textarea class='writeArea' id='writeArea'></textarea>").appendTo(divFirst);
							CKEDITOR.replace("writeArea",{
								filebrowserUploadUrl:'${path}/community/upload'
							});
							CKEDITOR.instances.writeArea.setData(data.view.cm_content);
						$("<button id='cancelBtn' style='background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>취소</button>").insertAfter(form);
						$("<button id='insertBtn' style='margin: 0px 100px 0px 45%;background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>등록</button>").insertAfter(form);
						
						$('#cancelBtn').on('click',function() {
							location.href="${path}/community/list"
						});
						
						$('#insertBtn').on('click', function() {
							var title = $('#cm_title').val();
							var text = CKEDITOR.instances.writeArea.getData();
							
							if(title == "" || text == ""){
								swal({
									  title: "내용을 확인해주세요!",
									  icon: "warning",
									  button: "확인",
									  dangerMode: true,
									});
							}else {
								$.ajax({
									type:"POST",
									url:"update",
									data:{
										title : title,
										text : text,
										no: no,
									},
									success:function(data) {
										location.href="${path}/community/list"
									},
									error: function(error){
										console.log("오류오류");
									}
								});
							}
						});
					},
				error: function(error){
					console.log("오류오류");
				}
			});
		}
	
	function deleteBtn(no) {
		$.ajax({
			type:"POST",
			url:"delete",
			data:{
				no: no,
			},
			success:function(data) {
				location.href="${path}/community/list"
			},
			error: function(error){
				console.log("오류오류");
			}
		});
	}
	
	function GoMsg(no,userId,userNo){
     	document.querySelector(".modal").classList.remove("fade");
     	document.getElementById("memSearchInput").value= userId;
     	document.getElementById("msgTo").value= userNo;
	  
	    const close = () => {
	      document.getElementById("memSearchInput").value= "";
	      document.getElementById("msgContent").value= "";
	      document.querySelector(".modal").classList.add("fade");
	    }
	    
//	    document.querySelector(".SwalDeleteBtn").addEventListener("click", open);	  
	    document.querySelector(".closeBtn").addEventListener("click", close);
	    
	    
	    $("#msgContent").on("keyup",function(){
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
	
	$(function(){
		$("#sendBtn").on("click",function(){
			let msgFrom = $("#msgFrom").val();
			let msgTo = $("#msgTo").val();
			let userName = $("#memSearchInput").val();
			let msgContent = $("#msgContent").val();
			let writeCnt = parseInt($("#writeCnt").text());
			let writeMax = parseInt($("#writeMax").text());
			
			if(userName == ""){
				Swal.fire({
					  icon: 'error',
					  text: '받는사람을 작성하지 않으셨습니다!',
					  didClose: () => {
						  $('#memSearchInput').focus();
					  }
					})
			} else if(msgContent == ""){
				Swal.fire({
					  icon: 'error',
					  text: '내용을 작성하지 않으셨습니다.!',
					  didClose: () => {
						  $('#msgContent').focus();
					  }
					})
			} else if(writeCnt > 300){
				Swal.fire({
					  icon: 'error',
					  text: writeMax + "자를 초과입력할 수 없습니다.!",
					  didClose: () => {
						  $('#msgContent').focus();
					  }
					})
			} else{
				$.ajax({
					type: "post",
					url:"${path}/community/Msgsend",
					data:{
						msgFrom:msgFrom,
						msgTo:msgTo,
						msgContent:msgContent
					},
					success:function(data){
						Swal.fire({
	                         icon: 'success',
	                         text: '쪽지를 성공적으로 전송하였습니다.'
	                     });
						
						document.getElementById("memSearchInput").value= "";
					    document.getElementById("msgContent").value= "";
						document.querySelector(".modal").classList.add("fade");
					},
					error: function(e){
						alert("실패");
						console.log(e);
					}
				});
			}
		});
	});
	
	function cm_bookMark(no, userNo){
		$.ajax({
			type:"post",
			url:"${path}/community/bookmark",
			data:{
				no:no,
				userNo:userNo,
			},
			success:function(){
				console.log("왔니?");
			},
			error: function(e){
				console.log("실패");
				console.log(e);
			}
		});
	}
	
	function cm_deleteMark(no, userNo){
		$.ajax({
			type:"post",
			url:"${path}/community/deleteMark",
			data:{
				no:no,
				userNo:userNo,
			},
			success:function(){
				
			},
			error: function(e){
				console.log("실패");
				console.log(e);
			}
		});
	}
   
	
	function mainNotice(no){
		location.href="${path}/notice/view?noticeNo="+no
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>