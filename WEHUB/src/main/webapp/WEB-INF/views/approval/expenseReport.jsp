<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<link rel="stylesheet" href="${path}/css/expenseReport.css">
<script src="${path}/js/jquery-3.5.1.js"></script>

<%@ include file="../approval/approvalSubMenu.jsp" %>

    <div class="cash-form-section" style="height: 100%; margin: 0 300px 0 300px;">
        <div class="cash-disbursement" style="text-align: center; margin: 80px 0px 80px 200px; border: 2px solid black;">
            <table border="2" style="width: 100%; font-size: 20px; border-collapse: collapse;">
                <tr>
                    <td rowspan="2" colspan="4" style="width: 300px; height: 120px; font-size: 40px; font-weight: 600;">지 출 결 의 서</td>
                    <td rowspan="2" style="width: 20px; padding-top: 30px; font-size: 25px;">결 재</td>
                    <td style="height: 30px; width: 100px;">최초승인자</td>
                    <td style="width: 100px;">중간승인자</td>
                    <td style="width: 100px;">최종승인자</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="8" style="height: 50px;">수신참조자</td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">성 명</td>
                    <td><input type="text" name="" id=""  ></td>
                    <td style="width: 80px;">부 서</td>
                    <td><input type="text"  ></td>
                    <td style="width: 80px;">직 급</td>
                    <td colspan="3"><input type="text"  ></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">지출금액</td>
                    <td colspan="7"><input type="text"  ></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">제 목</td>
                    <td colspan="7"><input type="text"  ></td>
                </tr>
                <tr>
                    <td rowspan="10" style="width: 80px;">내 역</td>
                    <td colspan="2">적 요</td>
                    <td colspan="2">금 액</td>
                    <td colspan="2">비 고</td>
                    <td colspan="1" style="font-size:17px">행 추가 삭제</td>
                </tr>
                <tr>
                    <td colspan="2"><input type="text" name="briefs" id="briefs"></td>
                    <td colspan="2"><input type="text" name="price" id="price"></td>
                    <td colspan="2"><input type="text" name="etc" id="etc"></td>
                    <td colspan="1">
                    	<button type="button" style="width:45px;height:30px; font-size:15px;" name="etc" id="etc">추가</button>
                    	<button type="button" style="width:45px;height:30px; font-size:15px;" name="etc" id="etc">삭제</button>
                    </td>
                    
                </tr>
                <script>
                	$('.btnAdd').click (function() {
                		var 
                		
                	});
                
                </script>
                
                <tr>
                    <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위 금액을 청구하오니 결재바랍니다.</td>
                </tr>
                <tr style="border: white;">
                    <td colspan="8" style="text-align: center; height: 100px;">
                        20 <input type="text" style="border: none; width: 40px; font-size: 20px;">년
                        <input type="text" style="border: none; width: 40px; font-size: 20px;">월
                        <input type="text" style="border: none; width: 40px; font-size: 20px;">일
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
                        영수인 : <input type="text" style=" width:200px; border: none; text-align: center;" maxlength="4">
                        (인)
                    </td>
                </tr>
            </table>
        </div>
        <div id="button">
        <button>등록</button>
        <input type="text" style="border: none; width: 40px;" disabled>
        <button>취소</button>
        </div>
    </div>

<%@ include file="../common/footer.jsp" %>