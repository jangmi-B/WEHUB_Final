<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%pageContext.setAttribute("replaceChar", "\n");%>
<%@ include file="../common/header.jsp"%>

<script src="${path}/js/jquery-3.5.1.js"></script>
<script src='https://cdn.jsdelivr.net/npm/moment@2.27.0/min/moment.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.5.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/moment@5.5.0/main.global.min.js'></script>
<link href="${path}/fullcalendar-5.6.0/lib/main.css" rel="stylesheet" />
<script src="${path}/fullcalendar-5.6.0/lib/main.js"></script>
<link rel="stylesheet" href="${path}/css/deptCalendar.css">

<script>
	$(document).ready(function() {
			      $.ajax({
						type : "get",
						url : "${path}/dept/listview",
						dataType : "json",
						success : function(resp) {
						
							var eventsArr = [];
							/* var start =moment(start).format('YYYY/MM/DD');
							var end =moment(end).format('YYYY/MM/DD '); */
							
							//alert('연결성공!');  
							let deptcalendar = resp.deptcalendar;
							let app = resp.app;
                 
                   			
					         if(deptcalendar!=null){
							    $(deptcalendar).each(function(idx, dept) {
								  eventsArr.push({
									 title : dept.user_name+" "+dept.leave_classify,
									 start : dept.leave_start,
									 end : dept.leave_finish+" 20:00:00"
								     }) //push		
									  console.log(dept);
							        })
						       }else{console.log("null");}
					   
					   
					         if(app!=null){
							    $(app).each(function(idx, dept) {
								    eventsArr.push({
									   title : dept.user_name+" "+dept.er_title,								
									   start : dept.er_deadline,
									   end : dept.er_deadline+" 20:00:00",
									   color:'purple'
								       }) //push		
									     console.log(dept);
							           })
						         }else{console.log("null");}
					   
					   
					          showCalendar(eventsArr);

					          /* console.log(eventsArr[0].title);
							     console.log(eventsArr[0].start);
							      console.log(eventsArr[0].end);  */

					       }, //success
					    
						  error : function(xhr) {
								console.log(xhr)
								alert("오류니");
							    }
						  });
			      
						function showCalendar(eventsArr) {
							var calendarEl = document.getElementById("calendar");
							var calendar = new FullCalendar.Calendar(
									calendarEl,
									 {
										googleCalendarApiKey : 'AIzaSyCCwZxu7OASpuOX__AcfbqzJ3Z_-3OjdSo',
										eventSources : [{
											googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com',
											className : "koHolidays",
											color : 'red',
											textColor : 'white'
										    }],					
										    
										displayEventTime: false,
										businessHours : true,
										weekNumbers : true,
										dayMaxEvents : true, // 한 날짜에 일정이 많을 경우 'more' 표시로 표현 여부
										navLinks : true,
										
										events : eventsArr,
										dateClick: function(arg) {
									      console.log(arg.date.toString()); 
										   },
											  
									    eventRender: function(arg) { 												
											  $(eventsArr).remove(".fc-event-time") // the time span in a full calendar event
								            },	  
										//  editable: true,	// 일정 수정(이동 및 기간 변경) 여부
										dayMaxEvents : true, // 한 날짜에 일정이 많을 경우 'more' 표시로 표현 여부
										initialView : 'dayGridMonth'
									});
							calendar.render();
						 };
				})
</script>

<form action="${path}/dept/view" id="notice_bar" method="get">
	<div>
		<ul>
			<li><span>캘린더</span>
				<div class="line"></div>
				<ul>
					<li><a href="${path}/calendar/view">개인 스캐줄관리</a></li>
					<li><a href="${path}/dept/view">부서별 스캐줄관리</a></li>
				</ul></li>
			<li>
		</ul>
	</div>

</form>

<div id="calendar"></div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
