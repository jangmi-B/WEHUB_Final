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
                    <td colspan="2" style="height: 70px;">
                        <h3>수신참조자</h3>
                    </td>
                    <td colspan="6" style="height: 70px;">
                    	<span id="referList"></span>
                    </td>	
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">성 명</td>
                    <td><input type="text" name="" id="" readonly></td>
                    <td style="width: 80px;">부 서</td>
                    <td><input type="text" readonly ></td>
                    <td style="width: 80px;">직 급</td>
                    <td colspan="3"><input type="text" readonly ></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">지출금액</td>
                    <td colspan="7"><input type="text" readonly ></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">제 목</td>
                    <td colspan="7"><input type="text" readonly ></td>
                </tr>
                <tr>
                    <td rowspan="10" style="width: 80px;">내 역</td>
                    <td colspan="2">적 요</td>
                    <td colspan="2">금 액</td>
                    <td colspan="3">비 고</td>
                </tr>
                <!-- for문으로 감싸야함 -->
                <tr>
                    <td colspan="2"><input type="text" value="" readonly ></td>
                    <td colspan="2"><input type="text" value="" readonly ></td>
                    <td colspan="3"><input type="text" value="" readonly ></td>
                </tr>
                
                <tr>
                    <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위 금액을 청구하오니 결재바랍니다.</td>
                </tr>
                <tr style="border: white;">
                    <td colspan="8" style="text-align: center; height: 100px;">
                        20 <input type="text" style="border: none; width: 40px; font-size: 20px;"readonly>년
                        <input type="text" style="border: none; width: 40px; font-size: 20px;"readonly>월
                        <input type="text" style="border: none; width: 40px; font-size: 20px;"readonly>일
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
                        영수인 : <input type="text" style=" width:200px; border: none; text-align: center;" maxlength="4" readonly>
                        (인)
                    </td>
                </tr>
            </table>
        </div>
        <div id="button">
	        <button>결재</button>
	        <input type="text" style="border: none; width: 40px;" disabled>
	        <button>취소</button>
	        <input type="text" style="border: none; width: 40px;" disabled>
	        <button style="color:red" id="openRejection">반려</button>
        </div>
    </div>
    
    <!-- 모달 테이블(반려 확인) -->
    
	<div class="modal modal1 hidden">
        <div class="bg"></div>
        <div class="modalBox" style="width:600px; height:400px; border-radius:20px">
            <div style="font-size:26px; margin:30px">
            	정말 반려처리 하시겠습니까?
            </div>
            <div style="margin: 43% 0px 0% 53%;">
                <span style="padding-right: 20px; margin-left:46px; float: left;" >
                    <button type="submit" class="closeBtn-in rejModalOk1" id="rejectOrNo">확인</button>
                </span>
                <button class="closeBtn-out rejModalNo1">취소</button>
            </div>
        </div>
    </div>
    
    <!-- 모달 테이블(반려 사유 작성) -->
    
	<div class="modal modal2 hidden">
        <div class="bg"></div>
        <div class="modalBox" style="width:600px; height:400px; border-radius:20px">
            <div style="font-size:26px; margin:30px">
            	반려 사유를 입력해주세요.
            </div>
            <textarea rows="8" cols="70" style="margin-left:23px; resize: none;"></textarea>
            <div style="margin: 10.5% 0px 0% 53%;">
                <span style="padding-right: 20px; margin-left:46px; float: left;" >
                    <button type="submit" class="closeBtn-in rejModalOk2" id="rejectReason">확인</button>
                </span>
                <button class="closeBtn-out rejModalNo2">취소</button>
            </div>
        </div>
    </div>
    
    <!-- 모달 스크립트 -->
    <script>
    	const open = () => {
	    	document.querySelector(".modal1").classList.remove("hidden");
	    }
	
	    const close = () => {
	        document.querySelector(".modal1").classList.add("hidden");
	    }
	
	    document.querySelector("#openRejection").addEventListener("click", open);
	    document.querySelector(".rejModalNo1").addEventListener("click", close);
    		
	    /* 모달 반려사유 */
	    
    	const open2 = () => {
	    	document.querySelector(".modal2").classList.remove("hidden");
	    }
	
	    const close2 = () => {
	        document.querySelector(".modal2").classList.add("hidden");
	    }
		
	    document.querySelector(".rejModalOk1").addEventListener("click", close);
	    document.querySelector(".rejModalOk1").addEventListener("click", open2);
	    document.querySelector(".rejModalNo2").addEventListener("click", close2);

	    
    	document.querySelector(".rejModalOk2").addEventListener("click",close2);
    	
    	$(document).ready(function() {
	    	$('.rejModalOk2').click(function() {
	    		var url = "${path}/approval/approvalMain";

	    		alert("결재반려 처리가 정상적으로 완료되었습니다.");
		    	$(location).attr('href',url);
	    	});
    	});
    </script>
    	
<%@ include file="../common/footer.jsp" %>