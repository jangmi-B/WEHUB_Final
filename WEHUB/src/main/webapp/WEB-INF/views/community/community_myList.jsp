<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>
<script type="text/javascript" src="${path}/ckeditor/ckeditor.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	
	    <div class="CM-index_section">
	        <h1>커뮤니티</h1>
	        <div class="line"></div>
	        <button id="CM_write_Btn">게시글 작성</button>
	        <li class="CM-form">보관함
	            <div>
	                <ul>
	                    <li><a href="${path}/community/myList">-내가 작성한 목록</a></li>
	                    <li><a href="${path}/community/favList">-즐겨찾기</a></li>
	                </ul>
	            </div>
	        </li>
	    </div>
		<form id="listform" method="get" action="${path}/community/list">
	    <div id="searchArea" style="margin: 40px 0px 0px 65%;">
	    </div>
			<table id="CM-table" style=" margin: 30px 0px 30px 470px; border-radius: 10px;	border:1px solid darkblue; line-height : 4;">
				<thead style="text-align: center;">
					<tr style="height:50px; background: lavender;">
						<td style="width:120px;">번호</td>
						<td style="width:600px;">제목</td>
						<td style="width:120px;">조회수</td>
						<td style="width:120px;">날짜</td>
					</tr>
				</thead>
				<tbody id="CM_Content" style="text-align: center;">
					<c:choose>
			    		<c:when test=" ${ list == null || list.size() == 0 }">
			    			<tr><td colspan="4" align="center"> 존재하지 않습니다.</td></tr>
			    		</c:when>
			    		<c:when test="${ list != null}">
		   					<c:forEach var="list" items="${list}">
							        <tr id='tag_TR${list.cm_no}' style='cursor:pointer;' class='tag_TR' onclick="view(${list.cm_no})">
							            <td id='listNo'>${list.rownum}</td>
							            <td>${list.cm_title}</td>
							            <td>${list.cm_readCount}</td>
							            <td><fmt:formatDate type="date" value="${list.cm_date}"/></td>
							        </tr>
					        </c:forEach>
			        	</c:when>
			        </c:choose>
				</tbody>
			</table>
		</form>
		<div id="CM_Content1" style="text-align: center;">
			<button style=" font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/myList?page=1'">처음페이지</button>
			<button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/myList?page=${pageInfo.getPrvePage()}'">&lt;&lt;</button>
			<c:forEach var="page" begin="${pageInfo.getStartPage()}" end="${pageInfo.getEndPage()}">
		    	<c:choose>
		    		<c:when test="${page} == ${pageInfo.getCurrentPage()}">
		    			<button style="font-size: 18px; border:none; background:none; cursor:pointer;" disabled="disabled">${page}</button>
		    		</c:when>
		    		<c:otherwise>
					    <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/myList?page=${page}'">${page}</button>
		    		</c:otherwise>
		    	</c:choose>
		    </c:forEach>
			<button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/myList?page=${pageInfo.getNextPage()}'">&gt;&gt;</button>
			<button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/myList?page=${pageInfo.getMaxPage()}'">마지막페이지</button>
		</div>
	<script>
	$(document).ready(function () {
        $('.CM-form').on('click', function() {
            $('.CM-form > div').slideToggle();
        });
    });
	
	
	$(document).ready(function() {
		$('#CM_write_Btn').one('click', function() {
			$.ajax({
				type:"GET",
				url:"writeView",
				
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
						$("<span style='display: block; float: left;'></span>").text("작성자 : " + data.user_name).appendTo(divFirst);
						$("<span style='display: block; text-align: end; border-bottom:1px solid'></span>").text("ID : " + data.user_id).appendTo(divFirst);
						$("<label style='display: block; border-bottom: 1px solid; height: 40px;'>제목 : <input id='cm_title' type='text' style='width: 90%;height:100%;border: none; font-size: 23px;'></label>").appendTo(divFirst);
						$("<textarea class='writeArea' id='writeArea'></textarea>").appendTo(divFirst);
						CKEDITOR.replace("writeArea",{
							filebrowserUploadUrl:'${path}/community/upload'
						});
						$("<button id='cancelBtn' style='background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>취소</button>").insertAfter(form);
						$("<button id='insertBtn' style='margin: 0px 100px 0px 45%;background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>등록</button>").insertAfter(form);
								
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
	 									location.href="${path}/community/myList"
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
		});
	});
	
	function view(no){
		
		$.ajax({
			type:"GET",
			url:"view",
			data:{
				no:no,
			},
				
			success:function(data) {
				console.log(data)
				console.log(data.view);
				
				$('#listform').remove();
				$('#CM_Content1').remove();
				$('#searchArea').remove();
				
				var form = $("<form id='viewForm'></form>").insertAfter('.CM-index_section');
				var divFirst = $("<div style='height: 600px; margin: 100px 400px 80px 500px; font-size: 23px; border: 1px solid; border-radius: 10px;'></div>").appendTo(form);
				
					$("<span style='display: block; float: left; padding: 0px 0px 0px 10px; font-weight: 900;'></span>").text("작성자 : " + data.view.user_name).appendTo(divFirst);
					$("<span style='display: block; text-align: end; border-bottom:1px solid black;'></span>").text("ID : " + data.view.user_id).appendTo(divFirst);
					$("<label style='display: block; border-bottom: 1px solid;height: 40px; padding-top: 6px; text-align: center; font-weight: 600;'>"+data.view.cm_title+"</label>").appendTo(divFirst);
					$("<div class='viewArea' id='viewArea' style='padding: 10px; overflow: scroll; height: 500px;'>"+data.view.cm_content+"</div>").appendTo(divFirst);
					
					if(data.loginMember.user_no == data.view.user_no){
						$("<button id='deleteList' style='width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >삭제</button>").insertAfter(form);
						$("<button id='returnList' style='width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >목록으로</button>").insertAfter(form);
						$("<button id='updateList' style='margin: 0px 0px 0px 40%; width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >수정</button>").insertAfter(form);
					}else {
						$("<button id='returnList' style='margin: 0px 0px 0px 48%; width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >목록으로</button>").insertAfter(form);
					}
					
					
				$('#returnList').on('click', function() {
					location.href="${path}/community/myList"
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
	
function updateBtn(no) {
		
		$.ajax({
			type:"GET",
			url:"updateView",
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
				location.href="${path}/community/myList"
			},
			error: function(error){
				console.log("오류오류");
			}
		});
	}
	
	</script>



<%@ include file ="../common/footer.jsp" %>