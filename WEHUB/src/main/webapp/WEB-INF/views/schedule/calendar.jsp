<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<% pageContext.setAttribute("replaceChar", "\n"); %>

<%@ include file="../common/header.jsp" %>
<%-- <script src="${path}/js/ckeditor/ckeditor.js"></script> --%>
 <script src="https://cdn.tiny.cloud/1/0rzcrcjyhf3qgaqudflx8r1fv0cn5qa6aruamgptg7pp9vk5/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
  <script>
//   	  tinymce.init({
// 		  selector:'#text_',
// 		  height: 450,
// 		  forced_root_block : false,
// 	      force_br_newlines : true,
// 	      force_p_newlines : false,
// 	      remove_linebreaks : false,
// 	      statusbar: false,
// 	      content_css : 'writer'
// 	  });
tinymce.init({
	selector:'#text_',
  plugins: [
    "a11ychecker advcode casechange formatpainter",
    "linkchecker autolink lists checklist",
    "media mediaembed pageembed permanentpen",
    "powerpaste table advtable tinymcespellchecker"
  ],
  toolbar: "formatselect | fontselect | bold italic strikethrough forecolor backcolor formatpainter | alignleft aligncenter alignright alignjustify | numlist bullist outdent indent | link insertfile image | removeformat | code | addcomment | checklist | casechange",
  height: 450,
  forced_root_block : false,
  force_br_newlines : true,
  force_p_newlines : false,
  remove_linebreaks : false,
});
  </script>
	<link rel="stylesheet" href="${path}/css/Calendar.css">
    <form action="${path}/calendar/view" id="notice_bar" method="get">
	<div>
        <ul>
          <li><span>캘린더</span>
            <div class="line"></div>
            <ul>
              <li><a href="${path}/calendar/view">개인 스캐줄관리</a></li>
              <li>부서별 스캐줄관리</li>
            </ul>
          </li>
          <li>
        </ul>
      </div>
    </form>  
	
<input type="hidden" name="month" id="month" value="${today_info.search_month}"> 
<input type="hidden" name="year" id="year" value="${today_info.search_year}"> 	
<form name="calendarFrm" id="calendarFrm" action="${path}/calendar/view" method="GET">
<div class="calendar" >

	<!--날짜 네비게이션  -->
	<div class="navigation">
		<a class="before_after_year" href="${path}/calendar/view?year=${today_info.search_year-1}&month=${today_info.search_month-1}">
			&lt;&lt;
		<!-- 이전해 -->
		</a> 
		<a class="before_after_month" href="${path}/calendar/view?year=${today_info.before_year}&month=${today_info.before_month}">
			&lt;
		<!-- 이전달 -->
		</a> 
		<span class="this_month">
			&nbsp;${today_info.search_year}. 
			<c:if test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
		</span>
		<a class="before_after_month" href="${path}/calendar/view?year=${today_info.after_year}&month=${today_info.after_month}">
		<!-- 다음달 -->
			&gt;
		</a> 
		<a class="before_after_year" href="${path}/calendar/view?year=${today_info.search_year+1}&month=${today_info.search_month-1}">
			<!-- 다음해 -->
			&gt;&gt;
		</a>
	</div>
<table class="calendar_body">

<thead>
	<tr bgcolor="#CECECE">
		<td class="day sun" >
			일
		</td>
		<td class="day" >
			월
		</td>
		<td class="day" >
			화
		</td>
		<td class="day" >
			수
		</td>
		<td class="day" >
			목
		</td>
		<td class="day" >
			금
		</td>
		<td class="day sat" >
			토
		</td>
	</tr>
</thead>
<tbody id="">
	<tr>
		<c:forEach var="dateList" items="${dateList}" varStatus="date_status">
			<c:choose>
				<c:when test="${dateList.value=='today'}">
				<!-- 오늘 -->
					<td class="today" id="today${dateList.date}" onclick="today(${dateList.date})">
						<div class="date">
							${dateList.date}
						</div>
						<input type="hidden" name="cal_no" id="c_hidden${dateList.date}" value="${dateList.cal_no}" disabled>
						<input type="hidden" name="today" id="today_hidden" value="${dateList.date}" disabled>
						<div class="T_content" id="T_content${dateList.date}">
							${fn:replace(dateList.schedule_content, replaceChar, "<br/>")}
						</div>
					</td>
				</c:when>
				<c:when test="${date_status.index%7==6}">
				<!-- 토요일 -->
					<td class="sat_day" id="satDay${dateList.date}" onclick="satDay(${dateList.date})">
						<div class="sat" id="sat">
							${dateList.date}
						</div>
						<input type="hidden" name="cal_no" id="c_hidden${dateList.date}" value="${dateList.cal_no}" disabled>
						<input type="hidden" class="satDay" name="satDay" id="today_hidden1" value="${dateList.date}" disabled>
						<div class="Sat_content" id="Sat_content${dateList.date}">
							${fn:replace(dateList.schedule_content, replaceChar, "<br/>")}
						</div>
					</td>
	</tr>
				</c:when>
				<c:when test="${date_status.index%7==0}">
				<!-- 일요일 -->
	<tr>	
				<td class="sun_day" id="sunDay${dateList.date}" onclick="sunDay(${dateList.date})">
					<div class="sun">
						${dateList.date}
					</div>
					<input type="hidden" name="cal_no" value="${dateList.cal_no}" id="c_hidden${dateList.date}" disabled>
					<input type="hidden" class="sunDay" name="sunDay" id="today_hidden1" value="${dateList.date}" disabled>
					<div class="Sun_content" id="Sun_content${dateList.date}">
						${fn:replace(dateList.schedule_content, replaceChar, "<br/>")}
					</div>
				</td>
				</c:when>
				<c:otherwise>
				<!-- 나머지  -->
				<td class="normal_day" id="NDay${dateList.date}" onclick="NDay(${dateList.date})">
					<div class="date">
						${dateList.date}
					</div>
					<input type="hidden" name="cal_no" value="${dateList.cal_no}" id="c_hidden${dateList.date}" disabled>
					<input type="hidden" class="NDay" name="NDay" id="today_hidden1" value="${dateList.date}" disabled>
					<div class="N_content" id="N_content${dateList.date}">
						${fn:replace(dateList.schedule_content, replaceChar, "<br/>")}
					</div>
				</td>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</tr>
</tbody>
</table>
		<div class="modalCal Cal_hidden modalNo">
	        <div class="bg"></div>
	        <div class="Cal_modalBox">
	        	<div class="TextArea">
	        		<input type="hidden" id="modal_hidden">
					<textarea class="text_" id="text_" rows="1" cols="1"></textarea>
	        	</div>
	        	 <div class="BtnArea" style="margin: 40px 0px 0px 280px;">
	                <span style="float: left; padding-right: 50px;" >
	                    <button class="closeBtn-in" id="closeBtn-in" onclick="updateBtn()">확인</button>
	                </span>
	                <button class="closeBtn-out" id="closeBtn-out">취소</button>
	            </div>
	        </div>
	    </div>
</div>
</form>

<script>


	 	 const open = () => {
		 	document.querySelector('.modalNo').classList.remove("Cal_hidden");
		 }
		
		 const close = () => {
		     document.querySelector('.modalNo').classList.add("Cal_hidden");
		 }
		 
		 document.getElementById('closeBtn-out').addEventListener("click", close);
		 document.getElementById('closeBtn-in').addEventListener("click",close);
		 document.querySelector(".bg").addEventListener("click", close);
		 
		//오늘 날짜
		 function today(No) {
		
		 var modal_hidden = document.getElementById('modal_hidden');
		 modal_hidden.value = No;
		 
		 tinymce.get("text_").setContent(document.getElementById('T_content'+No).innerHTML);
		 
		 document.getElementById('today'+No).addEventListener("dblclick", open);
		 
// 		 var content = document.getElementsByClassName('Sat_content');
// 			for(var i = 0; i < content.length; i++){
// 				 var splitText = content[i].innerHTML.trim().split("</p>");
// 				for(var j = 0; j < splitText.length; j ++){
// 					if(splitText[j].length >= 120){
// 						var rplContent = splitText[j].substr(120, splitText[j].length);
// 						content[i].innerHTML = splitText[j].substr(0, 120) + rplContent.replace(rplContent, "....");
// 					}
// 				}
// 			}
		}
		 
		//토요일
		 function satDay(No) {
		
		 var modal_hidden = document.getElementById('modal_hidden');
		 modal_hidden.value = No;
		 
		 tinymce.get("text_").setContent(document.getElementById('Sat_content'+No).innerHTML);
		 
		 document.getElementById('satDay'+No).addEventListener("dblclick", open);
		}
		
		//일요일
		 function sunDay(No) {
		
		 var modal_hidden = document.getElementById('modal_hidden');
		 modal_hidden.value = No;
		 
		 tinymce.get("text_").setContent(document.getElementById('Sun_content'+No).innerHTML);
		 
		 document.getElementById('sunDay'+No).addEventListener("dblclick", open);
		}
		
		// 평일
		 function NDay(No) {
		
		 var modal_hidden = document.getElementById('modal_hidden');
		 modal_hidden.value = No;
		 
		 tinymce.get("text_").setContent(document.getElementById('N_content'+No).innerHTML);
		 
		 document.getElementById('NDay'+No).addEventListener("dblclick", open);
		}

	function updateBtn(){
		
// 		var text = CKEDITOR.instances.text_.getData();
		var text = tinymce.get("text_").getContent(); 
		var modal_hidden = document.getElementById('modal_hidden');
		var calNo = document.getElementById('c_hidden'+modal_hidden.value);
		var month = document.getElementById('month').value;
		var year = document.getElementById('year').value;
		
		console.log(modal_hidden.value);
		console.log(text); // 잘나옴
		console.log(calNo.value)
		console.log(month);
		console.log(year);
		
		//ajax 처립 부분
        var xhr = new XMLHttpRequest();
        
        xhr.onreadystatechange = function() {
       	if(xhr.readyState == 4 && xhr.status == 200){
       		var str = xhr.responseText;
       	}else {
       		
       	}
        }
        
        xhr.open("POST", "${path}/calendar/update", true);
        
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded;")
        
        xhr.send("text="+text+"&dayNo="+modal_hidden.value+"&calNo="+calNo.value+"&month="+month+"&year="+year);
	}
	
	
</script>

