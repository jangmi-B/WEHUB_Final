<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>
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
	
	
<form name="calendarFrm" id="calendarFrm" action="" method="GET">
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
						</div>
						<div id="T_content">
							${dateList.schedule_content}						
						</div>
					</td>
				</c:when>
				<c:when test="${date_status.index%7==6}">
				<!-- 토요일 -->
					<td class="sat_day" id="satDay(${dateList.date})">
						<div class="sat">
							${dateList.date}
						</div>
						<div>
							${dateList.schedule_content}
						</div>
					</td>
				</c:when>
				<c:when test="${date_status.index%7==0}">
				<!-- 일요일 -->
	</tr>
	<tr>	
				<td class="sun_day" id="sunDay(${dateList.date})">
					<div class="sun">
						${dateList.date}
					</div>
					<div>
						${dateList.schedule_content}
					</div>
				</td>
				</c:when>
				<c:otherwise>
				<!-- 나머지  -->
				<td class="normal_day" id="NDay(${dateList.date})">
					<div class="date">
						${dateList.date}
					</div>
					<div>
						${dateList.schedule_content}
					</div>
				</td>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</tr>
</tbody>

</table>
</div>
</form>
<script>

	$(document).ready(function () {
	    $('.calendar-form').on('click', function() {
	        $('.calendar-form > div').slideToggle();
	    });
	});

	function today(t_No){
		
		console.log(t_No);
		
		
		
		
		
	}


</script>

