<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<form style="margin-top: -90px; margin-left: -230px;">
<div class="search">
    <table>
        <tr>
            <td>
                <i class="fa fa-search" aria-hidden="true"></i>
            </td>
            <td>
                <input type='text' class='src' placeholder='검색어를 입력하세요.'/>
            </td>
        </tr>
    </table>
</div>
<div id="contentForm">
    <div class="flex-grid">
        <div style="border-radius: 20px;">
        <h2 class="h2d">최근 공지사항<a href="#"><i class="fas fa-plus" id="con1" style="color: lightgray;"></i></a></h2>
        
        <ul>
            <li><a href="#">[03/09] 개발 1팀 사무실 공사 안내</a><i class="fas fa-info" id="con1" style="color: red;"></i></li>
            <li>[03/09] 인사행정팀 전산오류 안내<i class="fas fa-info" id="con1" style="color: red;"></i></li>
            <li>[03/02] 이 달의 사원(2월) 투표 종료 안내</li>
            <li>[02/26] 구내식당 오픈 행사</li>
            <li>[02/22] 웹 애플리케이션 개발자 신입 채용 안내</li>
        </ul>
        </div>
        <div>
        <h2 class="h2d">오늘 결재사항<a href="#"><i class="fas fa-plus" id="con1" style="color: lightgray;"></i></a></h2>
        <ul>
            <li>[03/09] 지출결의서_개발2팀</li>
            <li>[03/09] 지출결의서_인사행정팀</li>
        </ul>
        </div>
        <div>
        <h2 class="h2d">오늘 일정<a href="#"><i class="fas fa-plus" id="con1" style="color: lightgray;"></i></a></h2>
        <ul>
            <li>09시 50분 팀 회의</li>
            <li>15시 20분 거래처 방문</li>
            <li>18시 00분 앙 퇴근띠</li>
            <li>20시 30분 치맥</li>
        </ul>
        </div>
    </div>
    
    <div class="flex-grid">
        <div>
        <h2>Whatever :)</h2>
        Some Content
        </div>
        <div>
        <h2>Whatever :)</h2>
        Some Content
        </div>
    </div>
    <div class="flex-grid">
        <div>
        <h2>Whatever :)</h2>
        Some Content
        </div>
    </div>