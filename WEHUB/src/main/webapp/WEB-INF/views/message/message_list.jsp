<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div>
	<div class="index_section">
      <ul>
        <li><h1>쪽지 <i class="far fa-comment-dots"></i></h1>
          <div class="line"></div>
          <ul class="msgComponent">
            <li><button type="button" onclick="writeMsg();" class="msg_write_btn openBtn"> 쪽지쓰기 </button></li>
            <li><a href="${path}/message/list">받은쪽지함</a></li>
            <li><a href="${path}/message/sendList">보낸쪽지함</a></li>
            <li><a href="${path}/message/deletedList">휴지통</a></li>
            <li>쪽지보관함
            	<ul class="subBar">
            		<li><a href="#">- 받은쪽지 보관함</a></li>
            		<li><a href="#">- 보낸쪽지 보관함</a></li>
            	</ul>
            </li>
          </ul>
        </li>
       </ul>
      <div class="line"></div>
      </div>
      <div class="messageList">
      <h2 class="msg_title" style="margin:0; text-align:left;" >받은쪽지함</h2>
        <div class="megSearchBox" style="float:right">
          <form action="${path}/message/list" method="get">
            <select class="msgSearchList" name="msgSearchList">
              <option value="all" <c:out value="${msgSearchList == 'all'?'selected':''}"/>>전체</option>
              <option value="name" <c:out value="${msgSearchList == 'name'?'selected':''}"/>>이름</option>
              <option value="content"<c:out value="${msgSearchList == 'content'?'selected':''}"/>>내용</option>
            </select>
            <input type="search" placeholder="원하는 검색어를 입력하세요" name="msgSearchText">
            <button type="submit" class="msg_btn_search">검색</button>
          </form>
        </div>
        <div class="msgComponent">
          <button type="button" class="msg_btn" onclick="deleteSelected();">삭제</button>
          <button type="button" class="msg_btn">보관</button>
        </div>
          <table class="message_table" style="table-layout: fixed">
          <colgroup>
		  	<col style="width:5%"/>
		  	<col style="width:12%"/>
		  	<col style="width:65%"/>
		  	<col style="width:18%"/>
		  </colgroup>
            <tr>
              <th><input type="checkbox" id="checkAll" onclick="chkAll();"></th>
              <th>보낸사람</th>
              <th colspan="">내용</th>
              <th>날짜</th>
            </tr>
            <c:if test="${receiveList == null || receiveList.size() == 0 }">
            	<tr>
            		<td colspan="4">
            			받은 쪽지함이 비어있습니다.
            		</td>
            	</tr>
            </c:if>
            <c:if test="${receiveList != null}">
            	<c:forEach var="receiveList" items="${receiveList}">
            		<input type="hidden" name="receiveNo" value="<c:out value="${receiveList.receiveNo}"/>">
            		<tr id="msgListTable(${receiveList.receiveNo})">
		              <td style="width:50px"><input type="checkbox" name="chk" value="${receiveList.receiveNo}"></td>
		              <td><span class="senderName" id="s_name(${receiveList.receiveNo})"><c:out value="${receiveList.senderName}"/> <c:out value="${receiveList.rank}"/></span></td>
		              <td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">
		              	<a href="javascript:detailMsg(${receiveList.receiveNo})" id="detail(${receiveList.receiveNo})">
							<c:out value="${receiveList.receiveContent}"/>
						</a>
					  </td>
		              <td style="width:20%"><fmt:formatDate type="both" value="${receiveList.receiveDate}"/></td>
		            </tr>
		            <div class="modal_view fade modalNo${receiveList.receiveNo}">
					    <div class="bg"></div>
					    <div class="modalContainer">
					      <h2 style="margin-left: 18px;">받은쪽지</h2>
					        <div class="view_form info">
					          <input type="hidden" id="sName${receiveList.receiveNo}" value="<c:out value="${receiveList.senderName}"/>">
					          <input type="hidden" id="sRank${receiveList.receiveNo}" value="<c:out value="${receiveList.rank}"/>">
					          <input type="hidden" id="sDept${receiveList.receiveNo}" value="<c:out value="${receiveList.s_deptName}"/>">
					          <label>From : <c:out value="${receiveList.senderName}"/> <c:out value="${receiveList.rank}"/> (<c:out value="${receiveList.s_deptName}"/>)</label> <br>
					          <label>Date : </label> <fmt:formatDate type="both" value="${receiveList.receiveDate}"/>
					        </div>
					        <div class ="view_form">
					        <div class = "form-control" id="contentsDiv" rows="3" name ="messageContent"  style="overflow: scroll; margin-left:20px; margin-top:10px;">
					       		<p style="text-align:left; margin:5px;">${ fn:replace(receiveList.receiveContent, replaceChar, "<br/>" )}</p> 
					        </div>
					        </div>
					        <div class="msg_btns">
				        	 <button type="button" class ="deleteBtn(${receiveList.receiveNo})" onclick="deleteMsg(${receiveList.receiveNo});">삭제</button>
				       		 <button type="button" id ="responseBtn(${receiveList.receiveNo})" onclick="reMsg(${receiveList.receiveNo});">답장</button>
				       		 <button type="button" id ="exitBtn(${receiveList.receiveNo})">닫기</button>
					        </div>
					       
					    </div>
					  </div>
            	</c:forEach>
            </c:if>
          </table>
          <div class="message_page">
              <ul class="notice_pagination">
                <li><button type="button"  onclick="location.href='${path}/message/list?page=1'">처음페이지</button></li>
                <li><button type="button"  onclick="location.href='${path}/message/list?page=${pageInfo.prvePage}'">&lt;&lt;</button></li>
                <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
					<c:if test="${status.current == pageInfo.currentPage}">
						<li><button disabled><c:out value="${status.current}"/></button></li>
	   				</c:if>
					<c:if test="${status.current != pageInfo.currentPage}">
						<li><button onclick="location.href='${path}/message/list?page=${status.current}'"><c:out value="${status.current}"/></button></li>
	   				</c:if>
				</c:forEach>
                <li><button type="button" onclick="location.href='${path}/message/list?page=${pageInfo.nextPage}'">&gt;&gt;</button></li>
                <li><button type="button" onclick="location.href='${path}/message/list?page=${pageInfo.maxPage}'">마지막페이지</button></li>
	          </ul>
          </div>
        </div>
	</div>

  <div class="modal fade">
    <div class="bg"></div>
    <div class="modalContainer">
      <h2 style="margin-left:18px;">쪽지쓰기 </h2>
        <div class="info">
      	  <input type="hidden" id="senderNo" name="senderNo" value="<c:out value="${loginMember.user_no}"/>">
          <label>To : </label> <input type="text" id="memSearchInput" name="userName">
        </div>
        <div style="float:right; padding-right:25px; font-size:12px; margin-top:15px;">
          <span id="writeCnt">0</span>/<span id="writeMax">300</span>
        </div>
        <div class ="write_form">
          <textarea class = "form-control" rows="3" id="sendContent" name ="sendContent" style="overflow: scroll;"></textarea>
        </div>
        <div class ="write_form">
	        <button type="button" id="sendBtn" class ="sendBtn">보내기</button>
	        <button type="button" class ="closeBtn">닫기</button>
        </div>
    </div>
  </div>
 
<script>
	function chkAll() {
	    if ($("#checkAll").is(':checked')) {
	        $("input[type=checkbox]").prop("checked", true);
	    } else {
	        $("input[type=checkbox]").prop("checked", false);
	    }
	}
	
	function deleteSelected() {
		if(confirm("정말로 삭제하시겠습니까?")){
	        var cnt = $("input[name='chk']:checked").length;
	        var arr = new Array();
	        
	         $("input[name='chk']:checked").each(function() {
	            arr.push($(this).attr('value'));
	        });
	         
	        console.log(cnt);
	        console.log(arr);
	        
	        if(cnt == 0){
	            alert("선택된 글이 없습니다.");
	        }
	        
	        else{
	        	$.ajax({
	                type: "POST",
	                url: "${path}/message/deleteSelected",
	                data: {
						arr:arr,
						cnt:cnt
					},
	                success: function(data){
	                    alert("삭제 성공");
	                    
	                    for(var i = 0; i <arr.length; i++){
		                    var deleteMsg = document.getElementById('msgListTable('+ arr[i] +')');
		       				deleteMsg.remove();
	                    }
	                },
	                error: function(){alert("서버통신 오류");}
	        	});
	        }
		}
    } 
	
	function writeMsg(){
		const open = () => {
	      document.querySelector(".modal").classList.remove("fade");
	    }
	  
	    const close = () => {
	      document.getElementById("memSearchInput").value= "";
	      document.getElementById("sendContent").value= "";
	      document.querySelector(".modal").classList.add("fade");
	    }
	  
	    document.querySelector(".openBtn").addEventListener("click", open);
	    document.querySelector(".closeBtn").addEventListener("click", close);
	    
	    
	    $("#sendContent").on("keyup",function(){
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
	
	function reMsg(msgNo){
		var sName = $("#sName"+ msgNo).val();
		var sRank = $("#sRank"+ msgNo).val();
		var sDept = $("#sDept"+ msgNo).val();
		
		console.log(sName);
		console.log(sRank);
		console.log(sDept);
		
	    const close = () => {
    	  document.getElementById("memSearchInput").value= "";
	      document.getElementById("sendContent").value= "";
	      document.querySelector(".modal").classList.add("fade");
	    }
	    
		document.querySelector(".modalNo" + msgNo).classList.add("fade");
		document.querySelector(".modal").classList.remove("fade");
		
		document.getElementById("memSearchInput").value= sName + "_" + sRank + "_" + sDept;
	  
	    document.querySelector(".closeBtn").addEventListener("click", close);
	}
	

	function detailMsg(msgNo){
		/* console.log(msgNo);
		console.log(document.querySelector(".modalNo" + msgNo));
		console.log(document.getElementById('detail('+ msgNo +')')); */
		
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
	
	function deleteMsg(msgNo){
		if(confirm("쪽지를 삭제하시겠습니까?")){
			
			var xhr = new XMLHttpRequest();
	            
            xhr.onreadystatechange = function() {
           	if(xhr.readyState == 4 && xhr.status == 200){
				var deleteMsg = document.getElementById('msgListTable('+ msgNo +')');
				deleteMsg.remove();
				document.querySelector(".modalNo" + msgNo).classList.add("fade");
           	}else {
           		
           		}
            }
            
            xhr.open("GET", "${path}/message/delete?receiveNo="+ msgNo, true);
            
            xhr.send();
		}
	}
	
	$(function(){
		$("#sendBtn").on("click",function(){
			var senderNo = $("#senderNo").val();
			var userName = $("#memSearchInput").val();
			var sendContent = $("#sendContent").val();
			var writeCnt = $("#writeCnt").text();
			var writeMax = $("#writeMax").text();
			
			console.log(writeCnt);
			console.log(writeMax);
			
			if(userName == ""){
				alert("받는사람이 비어있습니다.");
				document.getElementById('memSearchInput').focus();
				
			} else if(sendContent == ""){
				alert("내용을 작성하지 않으셨습니다.");
				document.getElementById('sendContent').focus();
				
			} else if(writeCnt > writeMax){
				console.log(writeCnt);
				console.log(writeMax);
				alert(writeMax + "자를 초과입력할 수 없습니다.");
				document.getElementById('sendContent').focus();
				
			} else{
				$.ajax({
					type: "post",
					url:"${path}/message/send",
					data:{
						senderNo:senderNo,
						userName:userName,
						sendContent:sendContent
					},
					success:function(data){
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
	
	$(document).ready(() => { 
		 $("#memSearchInput").autocomplete({
			source:function(request, response){
				$.ajax({
					url : "${path}/search/json",
					type : "get",
					dataType : 'json',
					data : {
						userName:$("#memSearchInput").val()
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
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>