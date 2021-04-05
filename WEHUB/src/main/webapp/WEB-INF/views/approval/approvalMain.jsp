<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<script src="${path}/js/jquery-3.5.1.js"></script>

    <div class="EPay-index_section">
        <h2>전자결재</h2>
        <li class="EPay-form">양식작성
            <div>
                <ul>
                    <li><a href="${path}/approval/letterOfApproval">-품의서</a></li>
                    <li><a href="${path}/approval/expenseReport">-지출결의서</a></li>
                    <li><a href="${path}/approval/leaveApplication">-휴가신청서</a></li>
                </ul>
            </div>
        </li>
        <li class="EPay-list">
            결재리스트
            <div>
            <ul>
                <li><a href="">-개인별</a></li>
                <li><a href="">-부서별</a></li>
                <li><a href="">-전체</a></li>
            </ul>
            </div>
        </li>
        <li>보관함
            <ul>
                <li><a href="">품의서</a></li>
                <li><a href="">지출결의서</a></li>
                <li><a href="">휴가신청서</a></li>
            </ul>
        </li>
    </div>
    <div class="index_section2">
        <form action="">
            <h2>내결재</h2>
            <div id="e-pay-status">
                <span>
                    미결
                    <div>00건</div>
                </span>
                <span>
                    미정
                    <div>00</div>
                </span>
                <span>
                    미정
                    <div>00</div>
                </span>
            </div>
        </form>

        <form action="">
            <h2 style="margin-bottom: 0;">결재리스트</h2>
            <table id="e-pay-list">
                <tr>
                    <th>번호</th>
                    <th>종류</th>
                    <th>제목</th>
                    <th>기안자</th>
                    <th>기안일</th>
                    <th>상태</th>
                </tr>
                <tr>
                    <td>001</td>
                    <td>휴가신청서</td>
                    <td><a href="">000 휴가신청</a></td>
                    <td>김정현</td>
                    <td>2021.03.11</td>
                    <td>결재대기</td>
                </tr>
                <tr>
                    <td>002</td>
                    <td>지출결의서</td>
                    <td><a href="">000 휴가신청</a></td>
                    <td>김정현</td>
                    <td>2021.03.11</td>
                    <td>결재중</td>
                </tr>
                <tr>
                    <td>003</td>
                    <td>품의서</td>
                    <td><a href="">000 휴가신청</a></td>
                    <td>김정현</td>
                    <td>2021.03.11</td>
                    <td>결재완료</td>
                </tr>
            </table>
        </form>
    </div>

<script>
    $(document).ready(function () {
        $('.EPay-form').on('click', function() {
            $('.EPay-form > div').slideToggle();
        });
    });

    $(document).ready(function () {
        $('.EPay-list').on('click', function() {
            $('.EPay-list > div').slideToggle();
        });
    });


</script>

<%@ include file="../common/footer.jsp" %>