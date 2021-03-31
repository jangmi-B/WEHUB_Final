<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="../common/header.jsp" %>
	<link rel="stylesheet" href="${path}/css/Calendar.css">
    <form action="${path}/notice/list" id="notice_bar" method="get">
	<div>
        <ul>
          <li><span>캘린더</span>
            <div class="line"></div>
            <ul>
              <li>개인 스캐줄관리</li>
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
					<td class="today" id="today(${dateList.date})" onclick="today(${dateList.date})">
						<div class="date">
							${dateList.date}
						<input type="hidden" name="cal_no" id="c_hidden(${dateList.date})" value="${dateList.cal_no}">
						</div>
						<textarea class="T_content" id="T_content(${dateList.date})" rows="5" cols="10" readonly>${dateList.schedule_content}</textarea>
					</td>
				</c:when>
				<c:when test="${date_status.index%7==6}">
				<!-- 토요일 -->
					<td class="sat_day" id="satDay(${dateList.date})" onclick="satDay(${dateList.date})">
						<div class="sat">
							${dateList.date}
						</div>
						<input type="hidden" name="cal_no" id="c_hidden(${dateList.date})" value="${dateList.cal_no}">
						<textarea class="Sat_content" id="Sat_content(${dateList.date})" rows="5" cols="10" readonly>${dateList.schedule_content}</textarea>
					</td>
				</c:when>
				<c:when test="${date_status.index%7==0}">
				<!-- 일요일 -->
	</tr>
	<tr>	
				<td class="sun_day" id="sunDay(${dateList.date})" onclick="sunDay(${dateList.date})">
					<div class="sun">
						${dateList.date}
					</div>
					<input type="hidden" name="cal_no" value="${dateList.cal_no}" id="c_hidden(${dateList.date})">
					<textarea class="Sun_content" id="Sun_content(${dateList.date})" rows="5" cols="10" readonly>${dateList.schedule_content}</textarea>
				</td>
				</c:when>
				<c:otherwise>
				<!-- 나머지  -->
				<td class="normal_day" id="NDay(${dateList.date})" onclick="NDay(${dateList.date})">
					<div class="date">
						${dateList.date}
					</div>
					<input type="hidden" name="cal_no" value="${dateList.cal_no}" id="c_hidden(${dateList.date})">
					<textarea class="N_content" id="N_content(${dateList.date})" rows="5" cols="10" readonly>${dateList.schedule_content}</textarea>
				</td>
				</c:otherwise>
			</c:choose>
			<div class="modalCal Cal_hidden modalNo${dateList.date}">
			        <div class="bg"></div>
			        <div class="Cal_modalBox">
			        	<div>
			        		<textarea id="text(${dateList.date})" rows="13" cols="55" style="resize:none; margin: 50px 0px 0px 16px; font-size: 25px"></textarea>
			        	</div>
			        	 <div style="margin: 40px 0px 0px 280px;">
			                <span style="float: left; padding-right: 50px;" >
			                    <button class="closeBtn-in" id="closeBtn-in(${dateList.date})" onclick="updateBtn(${dateList.date})">확인</button>
			                </span>
			                <button class="closeBtn-out" id="closeBtn-out(${dateList.date})">취소</button>
			            </div>
			        </div>
			    </div>
		</c:forEach>
	</tr>
</tbody>

</table>
</div>
</form>
<script>
	function today(t_No){
		
		var today = document.getElementById('today('+t_No+')');
		var t_content = document.getElementById('T_content('+t_No+')');
		var text = document.getElementById('text('+t_No+')');
 		// modal 창 띄우기

 	    const open = () => {
 	    	document.querySelector('.modalNo'+t_No).classList.remove("Cal_hidden");
 	    }

 	    const close = () => {
 	        document.querySelector('.modalNo'+t_No).classList.add("Cal_hidden");
 	    }

 	   	t_content.addEventListener("dblclick", open);
 	   	t_content.addEventListener("dblclick", function(e) {
			text.innerHTML = t_content.value;
 	   	});
 	    document.getElementById('closeBtn-out('+ t_No +')').addEventListener("click", close);
 	    document.getElementById('closeBtn-in('+ t_No +')').addEventListener("click",close);
 	    document.querySelector(".bg").addEventListener("click", close);
		 		
	}
	
	function satDay(t_No){
		
		var satDay = document.getElementById('satDay('+t_No+')');
		var sat_content = document.getElementById('Sat_content('+t_No+')');
		var text = document.getElementById('text('+t_No+')');
		// modal 창 띄우기

 	    const open = () => {
 	    	document.querySelector('.modalNo'+t_No).classList.remove("Cal_hidden");
 	    }

 	    const close = () => {
 	        document.querySelector('.modalNo'+t_No).classList.add("Cal_hidden");
 	    }

 	    sat_content.addEventListener("dblclick", open);
 	    sat_content.addEventListener("dblclick", function(e) {
			text.innerHTML = sat_content.value;
	   	});
 	    
 	    
 	    document.getElementById('closeBtn-out('+ t_No +')').addEventListener("click", close);
 	    document.getElementById('closeBtn-in('+ t_No +')').addEventListener("click", close);
 	    document.querySelector(".bg").addEventListener("click", close);
	};
	
	
	function sunDay(t_No){
		
		var sunDay = document.getElementById('sunDay('+t_No+')');
		var Sun_content = document.getElementById('Sun_content('+t_No+')');
		var text = document.getElementById('text('+t_No+')');
		// modal 창 띄우기

 	    const open = () => {
 	    	document.querySelector('.modalNo'+t_No).classList.remove("Cal_hidden");
 	    }

 	    const close = () => {
 	        document.querySelector('.modalNo'+t_No).classList.add("Cal_hidden");
 	    }

 	    Sun_content.addEventListener("dblclick", open);
 	    Sun_content.addEventListener("dblclick", function(e) {
			text.innerHTML = Sun_content.value;
	   	});
 	    document.getElementById('closeBtn-out('+ t_No +')').addEventListener("click", close);
 	    document.getElementById('closeBtn-in('+ t_No +')').addEventListener("click", close);
 	    document.querySelector(".bg").addEventListener("click", close);
	}
	
	function NDay(t_No){
		var NDay = document.getElementById('NDay('+t_No+')');
		var N_content = document.getElementById('N_content('+t_No+')');
		var text = document.getElementById('text('+t_No+')');
		// modal 창 띄우기

 	    const open = () => {
 	    	document.querySelector('.modalNo'+t_No).classList.remove("Cal_hidden");
 	    }

 	    const close = () => {
 	        document.querySelector('.modalNo'+t_No).classList.add("Cal_hidden");
 	    }

 	  	N_content.addEventListener("dblclick", open);
 	    N_content.addEventListener("dblclick", function(e) {
			text.innerHTML = N_content.value;
	   	});
 	    document.getElementById('closeBtn-out('+ t_No +')').addEventListener("click", close);
 	    document.getElementById('closeBtn-in('+ t_No +')').addEventListener("click", close);
 	    document.querySelector(".bg").addEventListener("click", close);
	}

	function updateBtn(t_No){
		
		var text = document.getElementById('text('+t_No+')');
		var calNo = document.getElementById('c_hidden('+t_No+')');
		var month = document.getElementById('month').value;
		var year = document.getElementById('year').value;
		
		console.log(text.value); // 잘나옴
		console.log(calNo.value)
		console.log(month);
		console.log(year);
		
		//ajax 처립 부분
        var xhr = new XMLHttpRequest();
        
        xhr.onreadystatechange = function() {
       	if(xhr.readyState == 4 && xhr.status == 200){
       		var str = xhr.responseText;
       		
       		document.getElementById('T_content('+t_No+')').innerHTML = str;
       		
       	}else {
       		
       	}
        }
        
        xhr.open("POST", "${path}/calendar/update", true);
        
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded;")
        
        xhr.send("text="+text.value+"&dayNo="+t_No+"&calNo="+calNo.value+"&month="+month+"&year="+year);
	}
	
	

</script>

