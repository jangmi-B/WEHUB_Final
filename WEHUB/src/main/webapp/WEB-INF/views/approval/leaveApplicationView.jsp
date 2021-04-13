<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<link rel="stylesheet" href="${path}/css/leaveApplication.css">
<script src="${path}/js/jquery-3.5.1.js"></script>

<%@ include file="../approval/approvalSubMenu.jsp" %>	
	
    <form action="${path}/approval/leaveApplication" method="post">
	    <div class="cash-form-section" style="height: 100%; margin: 0 300px 0 300px;">
	        <div class="cash-disbursement" style="text-align: center; margin: 80px 0px 80px 200px; border: 2px solid black;">
	            <table border="2px" style="width: 100%; font-size: 20px; border-collapse: collapse;">
	                <tr>
	                    <td rowspan="2" colspan="4" style="width: 300px; height: 120px; font-size: 40px; font-weight: 600;">휴 가 신 청 서</td>
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
	                    <td colspan="2" style="height: 70px;">
	                        <h3>수신참조자</h3>
	                    </td>
	                    <td colspan="6" style="height: 70px;">
	                    	<span id="referList"></span>
	                    </td>	
                	</tr>
	                <tr>
	                    <td style="height: 70px; width: 80px;">성 명</td>
	                    <td><input type="text" readonly></td>
	                    <td style="width: 80px;">부 서</td>
	                    <td><input type="text" readonly></td>
	                    <td style="width: 80px;">직 급</td>
	                    <td colspan="3"><input type="text" readonly></td>
	                </tr>
	                <tr>
	                    <td colspan="3" style="height: 70px; width: 80px;">비 상 연 락 망</td>
	                    <td colspan="5"><input type="text" readonly></td>
	                </tr>
	                <tr>
	                    <td colspan="3" style="height: 70px; width: 80px;">기 간</td>
	                    <td colspan="5">
	                        <span style="float: left;">
	                            <input style="width: 260px;" type="date" name="" id="">
	                        </span>
	                        ~
	                        <span>
	                            <input style="width: 280px;" type="date" name="" id=""> 
	                        </span>
	                    </td>
	                </tr>
	                <tr>
	                    <td style="width: 80px;">세부사항</td>
	                    <td colspan="8">
	                        <input style="height: 300px;" type="text" readonly>
	                    </td>
	                </tr>
	                <tr>
	                    <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</td>
	                </tr>
	                <tr style="border: white;">
	                    <td colspan="8" style="text-align: center; height: 100px;">
	                        20 <input type="text" style="border: none; width: 40px; font-size: 20px;" value="" readonly>년
	                        <input type="text" style="border: none; width: 40px; font-size: 20px;" value="" readonly>월
	                        <input type="text" style="border: none; width: 40px; font-size: 20px;" value="" readonly>일
	                    </td>
	                </tr>
	                <tr>
	                    <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
	                        신청자 : <input type="text" style=" width:200px; border: none; text-align: center;" maxlength="4" value="" readonly>
	                        (인)
	                    </td>
	                </tr>
	            </table>
	        </div>
	        
	        <div id="button">
		        <c:if test="">
		        	<button>결재</button>
		        	<input type="text" style="border: none; width: 40px;" disabled>
		        	<button style="color:red">반려</button>
			        <input type="text" style="border: none; width: 40px;" disabled>
		        </c:if>
		        <button>취소</button>
        	</div>
	    </div>
	</form>
 
<%@ include file="../common/footer.jsp" %>
