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
          <ul>
            <li><button type="button" onclick="writeMsg();" class="msg_write_btn openBtn"> 쪽지쓰기 </button></li>
            <li><a href="${path}/message/list">받은쪽지함</a></li>
            <li>보낸쪽지함</li>
            <li>휴지통</li>
            <li>쪽지보관함</li>
            <li>임시보관함</li>
          </ul>
        </li>
       </ul>
      <div class="line"></div>
      </div>
      <div class="messageList">
      <h2 class="msg_title" style="margin:0; text-align:left;" >받은쪽지함</h2>
        <div class="megSearchBox" style="float:right">
          <form action="${path}/message/sendlist" method="get">
            <!-- <select class="msgSearchList" name="msgSearchBox">
              <option value="all">전체</option>
              <option value="inbox">받은편지함</option>
              <option value="send">보낸편지함</option>
              <option value="archive">쪽지보관함</option>
            </select> -->
            <select class="msgSearchList" name="msgSearchList">
              <option value="all" <c:out value="${map.msgSearchList == 'all'?'selected':''}"/>>전체</option>
              <option value="name" <c:out value="${map.msgSearchList == 'name'?'selected':''}"/>>이름</option>
              <option value="content"<c:out value="${map.msgSearchList == 'content'?'selected':''}"/>>내용</option>
            </select>
            <input type="search" placeholder="원하는 검색어를 입력하세요" name="msgsSearchText">
            <button type="submit" class="msg_btn_search">검색</button>
          </form>
        </div>
        <div class="msgComponent">
          <button type="button" class="msg_btn">삭제</button>
          <button type="button" class="msg_btn">보관</button>
          <button type="button" class="msg_btn">답장</button>
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
            <c:if test="${sendList == null || sendList.size() == 0 }">
            	<tr>
            		<td colspan="4">
            			받은 쪽지함이 비어있습니다.
            		</td>
            	</tr>
            </c:if>
            <c:if test="${sendList != null}">
            	<c:forEach var="receiveList" items="${sendList}">
            		<input type="hidden" name="receiveNo" value="<c:out value="${receiveList.receiveNo}"/>">
            		<tr id="msgListTable(${receiveList.receiveNo})">
		              <td style="width:50px"><input type="checkbox" name="chk"></td>
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
					      <h2 style="margin-left: 18px;">보낸쪽지</h2>
					        <div class="view_form info">
					          <label>From : </label> <c:out value="${receiveList.senderName}"/> <c:out value="${receiveList.rank}"/> (<c:out value="${receiveList.s_deptName}"/>)<br>
					          <label>Date : </label> <fmt:formatDate type="both" value="${receiveList.receiveDate}"/>
					        </div>
					        <div class ="view_form">
					        <div class = "form-control" id="contentsDiv" rows="3" name ="messageContent">
					       		<p style="text-align:left; margin:5px;">${ fn:replace(receiveList.receiveContent, replaceChar, "<br/>" )}</p> 
					        </div>
					        </div>
					        <div class="msg_btns">
				        	 <button type="button" class ="delegeBtn(${receiveList.receiveNo})" onclick="deleteMsg(${receiveList.receiveNo});">삭제</button>
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
          <span class="info">30</span>/1000
        </div>
        <div class ="write_form">
          <textarea class = "form-control" rows="3" id="sendContent" name ="sendContent"></textarea>
        </div>
        <div class ="write_form">
	        <button type="button" id="sendBtn" class ="sendBtn">보내기</button>
	        <button type="button" class ="saveBtn">임시저장</button>
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
	
	function writeMsg(){
		const open = () => {
	      document.querySelector(".modal").classList.remove("fade");
	    }
	  
	    const close = () => {
	      document.querySelector(".modal").classList.add("fade");
	    }
	  
	    document.querySelector(".openBtn").addEventListener("click", open);
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
			
			console.log(senderNo);
			console.log(userName);
			console.log(sendContent);
			
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
            focus : function(event, ui) {    //포커스 가면
                return false;//한글 에러 잡기용도로 사용됨
            },
            minLength: 1,// 최소 글자수
            autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
            delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
		 });
	 });
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>