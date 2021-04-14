<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<link rel="stylesheet" href="${path}/css/appAutocomplete.css">

<% Calendar today =  Calendar.getInstance(); %>

<style>
	 * {font-family: 'InfinitySans-RegularA1'; }
	
	/* 휴가 구분 css */
	.form-radio{
	    display: inline-block; 
	    line-height: 20px; 
	    vertical-align: middle;
	    font-size: 14px; 
	}
	.form-chek::before, .form-radio::before{
	    content: ""; 
	    display: inline-block; 
	    width: 10px; 
	    height: 10px; 
	    background: #ffffff; 
	    border: 1px solid #3d3d3e; 
	    margin-right: 8px;
	}
	.form-radio::before{ border-radius: 50%; }
	.input-chek, .input-radio{ display: none; }
	.input-chek:checked + .form-chek::before, .input-radio:checked + .form-radio::before{ background: #5b18ff; }
	.input-chek:checked + .form-chek, .input-radio:checked + .form-radio{ color: #5b18ff; }
	.leaveDetailTextArea { font-size: 25px; }
</style>

<%@ include file="../approval/approvalSubMenu.jsp" %>	
    
<form action="${path}/approval/updateLeave" method="POST">
    <div class="cash-form-section" style="height: 100%; width:1000px; margin: 0 300px 0 300px;">
        <div class="cash-disbursement" style="text-align: center; margin: 80px 0px 80px 200px; border: 2px solid black;">
            <table border="2" style="width: 100%; font-size: 20px; border-collapse: collapse;">
                <tr>
                    <td rowspan="2" colspan="4" style="width: 300px; height: 120px; font-family: 'InfinitySans-RegularA1'; font-size: 40px; font-weight: 600;">휴 가 신 청 서</td>
                    <td rowspan="2" style="width: 15px; padding-top: 20px; font-family: 'InfinitySans-RegularA1'; font-size: 20px;">결 재</td>
                    <td style="height: 30px; width: 100px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">최초승인자</td>
                    <td style="width: 100px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">중간승인자</td>
                    <td style="width: 100px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">최종승인자</td>
                </tr>
                <tr>
                	<td style=""> <!-- 이미지화 시켜서 인쇄할 수 있는 방법 찾아보기 -->
                		<input type="text" value="" id="firstApprover" name="firstApprover" readonly="readonly" class="nameView">
                		<input type="button" value="검색" class="searchMember" id="firstBtn" name="firstApprover">
                	</td>
                	<td>
                		<input type="text" value="" id="interimName" name="interimApprover" readonly="readonly" class="nameView">
                		<input type="button" value="검색" class="searchMember" id="secondBtn" name="interimApprover">
                	</td>
                	<td>
                		<input type="text" value="" id="finalApprover" name="finalApprover" readonly="readonly" class="nameView">
                		<input type="button" value="검색" class="searchMember" id="thirdBtn" name="finalApprover">
                	</td>
                </tr>
                <tr>
                    <td colspan="8" style="height: 50px;">수신참조자</td>
                </tr>
                <tr>
                	<td colspan="8" style="height: 50px;"></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">성 명</td>
                    <td><input type="text" name="" value="${ loginMember.user_name }" readonly></td>
                    <td style="width: 80px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">부 서</td>
                    <td><input type="text" value="${ loginMember.dept_code }" readonly></td>
                    <td style="width: 80px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">직 급</td>
                    <td colspan="3"><input type="text" value="${ loginMember.rank }" readonly></td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 70px; width: 80px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">비 상 연 락 망</td>
                    <td colspan="5"><input type="tel" placeholder="전화번호만 입력하세요." class="callNumber" name="appEmergncyCall" style="font-size: 18px;" required/></td>
                </tr>
	                <script>
	                    $(document).on("keyup", ".callNumber", function() {
	                    	$(this).val( $(this).val()
	                    			.replace(/[^0-9]/g, "")
	                    			.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
	                    });
	                </script>
                <tr>
                    <td colspan="3" style="height: 70px; width: 80px;  font-family: 'InfinitySans-RegularA1'; font-size: 15px;">기 간</td>
                    <td colspan="5">
                        <span>
                            <input style="width: 160px; font-size: 18px;" type="date" name="leaveStart" id="startDate" />
                        </span>
                        &nbsp;&nbsp; ~ &nbsp;&nbsp;
                        <span>
                            <input style="width: 160px; font-size: 18px;" type="date" name="leaveFinish" id="endDate" /> 
                        </span>
	                        <script type="text/javascript">
	                     		// 시작일 < 종료일
		                        var start = document.getElementById('startDate');
		                        var end = document.getElementById('endDate');
		
		                        start.addEventListener('change', function() {
		                          if (start.value)
		                            end.min = start.value;
		                        }, false);
		                        end.addEventLiseter('change', function() {
		                          if (end.value)
		                            start.max = end.value;
		                        }, false);
	                        </script>
                    </td>
                </tr>
                <tr>
                	<td style="width: 80px; height: 70px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">휴가 구분</td>
                	<td colspan="8">
                		<!-- <input type="checkbox" id="ex_chk3"> https://webdir.tistory.com/433
  						<label for="ex_chk3">연차</label>  --> 
  						<div class="form-checkbox-wrap">
					        <sapn class="form-inline">
					            <input type="radio" name="leaveClassify" class="input-radio" id="radio1" value="연차"> &nbsp;&nbsp;&nbsp;
					            <label for="radio1" class="form-radio">연차</label>
					        </sapn>
					        <sapn class="form-inline">
					            <input type="radio" name="leaveClassify" class="input-radio" id="radio2" value="반차"> &nbsp;&nbsp;&nbsp;
					            <label for="radio2" class="form-radio">반차</label>
					        </sapn>
					        <sapn class="form-inline">
					            <input type="radio" name="leaveClassify" class="input-radio" id="radio3" value="병가"> &nbsp;&nbsp;&nbsp;
					            <label for="radio3" class="form-radio">병가</label>
					        </sapn>
					        <sapn class="form-inline">
					            <input type="radio" name="leaveClassify" class="input-radio" id="radio4" value="보상휴가"> &nbsp;&nbsp;&nbsp;
					            <label for="radio4" class="form-radio">보상휴가</label>
					        </sapn>
					        <sapn class="form-inline">
					            <input type="radio" name="leaveClassify" class="input-radio" id="radio5" value="기타"> &nbsp;&nbsp;&nbsp;
					            <label for="radio5" class="form-radio">기타(세부사항 상세 기술)</label>
					        </sapn>
					    </div>
                	</td>
                </tr>
                <tr>
                    <td style="width: 80px; font-family: 'InfinitySans-RegularA1'; font-size: 15px;">세부사항</td>
                    <td colspan="8">
                        <input style="height: 300px;" type="text" name="leaveDetail" class="leaveDetailTextArea">
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</td>
                </tr>
                <tr style="border: white;">
                    <td colspan="8" style="text-align: center; height: 100px;">
                        <%= today.get(java.util.Calendar.YEAR) %> 년 &nbsp;
                        <%= today.get(java.util.Calendar.MONTH) + 1 %> 월 &nbsp;
                        <%= today.get(java.util.Calendar.DATE) %> 일 &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
                        신청자 : <input type="text" style=" width:200px; border: none; text-align: center;" maxlength="4" value="${ loginMember.user_name }" readonly="readonly">
                        (인)
                    </td>
                </tr>
            </table>
        </div>
        <div id="button">
        	<input type="hidden" name="approvalKinds" value="휴가신청서">
        	<button type="submit" class="goToLeave" onclick="">등록</button><!-- ${path}/approval/updateLeave -->
        	<input type="text" style="border: none; width: 40px;" disabled>
        	<button type="reset" class="resetLeave" onclick="">취소</button>
        </div>
    </div>
</form>    
    
    <!-- 중간 승인자 모달창  -->
    <div id="testForm">
	    <div class="appModal Amodal">
	    	<div class="appModal_content">
	    	<div class="appModalInputName">이름을 입력해 주세요.</div>
	    		<div>
	    			<input type="text" id="memSearchInput2" name="userName" class="APPLE_searchArea"> <lable class="anserMember">님이 맞으신가요?</lable>
	    		</div>
	    		<br><br>
	    			<button class="modalSearchMember" type="button" id="appModalClose2" style="">확인</button>
	    	</div>
	    </div>
    </div>
    
    <!-- 최초 승인자 모달창  -->
    <div id="testForm1">
	    <div class="appModal Amodal1">
	    	<div class="appModal_content">
	    	<div class="appModalInputName">이름을 입력해 주세요.</div>
	    		<div>
	    			<input type="text" id="memSearchInput1" name="userName" class="APPLE_searchArea"> <lable class="anserMember">님이 맞으신가요?</lable>
	    		</div>
	    		<br><br>
	    			<button class="modalSearchMember" type="button" id="appModalCloseFirst">확인</button>
	    	</div>
	    </div>
    </div>
    
    <!-- 최종 승인자 모달창  -->
    <div id="testForm3">
	    <div class="appModal Amodal3">
	    	<div class="appModal_content">
	    	<div class="appModalInputName">이름을 입력해 주세요.</div>
	    		<div>
	    			<input type="text" id="memSearchInput3" name="userName" class="APPLE_searchArea"> <lable class="anserMember">님이 맞으신가요?</lable>
	    		</div>
	    		<br><br>
	    			<button class="modalSearchMember" type="button" id="appModalCloseThird">확인</button>
	    	</div>
	    </div>
    </div>
    
<script>
	
</script>

<%@ include file="appAutocomplete.jsp" %> <!-- 자동완성 Ajax & script -->

<%@ include file="../common/footer.jsp" %>