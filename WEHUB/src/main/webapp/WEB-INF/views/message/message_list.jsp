<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

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
          <form action="${path}/message/list" method="get">
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
            <c:if test="${receiveList == null || receiveList.size() == 0 }">
            	<tr>
            		<td colspan="4">
            			받은 쪽지함이 비어있습니다.
            		</td>
            	</tr>
            </c:if>
            <c:if test="${receiveList != null}">
            	<c:forEach var="receiveList" items="${receiveList}">
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
					      <h2 style="margin-left: 33px;">받은쪽지</h2>
					        <div class="write_form info">
					          <label>From : </label> <c:out value="${receiveList.senderName}"/> <c:out value="${receiveList.rank}"/><br>
					          <label>Date : </label> <fmt:formatDate type="both" value="${receiveList.receiveDate}"/>
					        </div>
					        <div class ="write_form">
					          <textarea class = "form-control" rows="3" name ="messageContent"><c:out value="${receiveList.receiveContent}"/></textarea>
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
      <h2 style="margin-left: 33px;">쪽지쓰기 <i class="far fa-paper-plane"></i></h2>
      <form action="/message/write" method="get" class="view_form">
        <div class="write_form">
          <label>To : </label> <input name='title' type="text" class="toMem" name="sender">
          <input type="button" class="memSearch" value="검색">
        </div>
        <div class ="write_form">
          <textarea class = "form-control" rows="3" name ="messageContent"></textarea>
        </div>
        <button type="submit" class ="sendBtn">보내기</button>
        <button type="button" class ="saveBtn">임시저장</button>
        <button type="button" class ="closeBtn">닫기</button>
      </form>
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
	   /* document.querySelector(".bg").addEventListener("click", close);*/
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
	   
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>