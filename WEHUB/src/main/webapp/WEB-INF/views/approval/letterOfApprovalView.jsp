<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<script src="${path}/js/jquery-3.5.1.js"></script>

<%@ include file="../approval/approvalSubMenu.jsp" %>

    <div class="cash-form-section" style="height: 100%; margin: 0 300px 0 300px;">
        <div class="cash-disbursement" style="text-align: center; margin: 80px 0px 80px 200px; border: 2px solid black;">
            <table border="2" style="width: 100%; font-size: 20px; border-collapse: collapse;">
                <tr>
                    <td rowspan="2" colspan="4" style="width: 300px; height: 120px; font-size: 40px; font-weight: 600;">품 의 서</td>
                    <td rowspan="2" style="width: 20px; padding-top: 30px; font-size: 25px;">
                        <button style="border: none; width: 80px;">결 재</button>
                    </td>
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
                        <button class="send-open" type="button" disabled>수신참조자 +</button>
                    </td>
                    <td colspan="6" style="height: 70px;">
                    	<textArea readonly name="referList" id="referList" style="border:none;margin-bottom:-12px; font-size:19px; width:600px; height:60px; text-align: center; resize: none;">${approval.referList}</textArea>
                    </td>	
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">성 명</td>
                    <td><input type="text" readonly value="${approval.userName}"></td>
                    <td style="width: 80px;">부 서</td>
                    <td><input type="text" readonly value="${approval.deptName}"></td>
                    <td style="width: 80px;">직 급</td>
                    <td colspan="3"><input type="text" readonly value="${approval.rank}"></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">제 목</td>
                    <td colspan="8"><input type="text" readonly value="${approval.loaTitle}"></td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 90px;" >
                        <h3>파일첨부</h3>
                    </td>
                    <td colspan="6" style="height: 70px;">
                    	<span id="referList"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="height: 70px; width: 80px;">품의사유 및 상세내용</td>
                </tr>
                <tr>
                    <td colspan="8">
                        <textarea name="" id="" cols="151px" rows="11px" style="width: 100%; height: 100%; border: none; resize: none; overflow: hidden; font-size: 25px;" readonly>${approval.loaContent}</textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위와 같은 품의사유로, 검토 후 결재 바랍니다.</td>
                </tr>
                <tr style="border: white;">
                    <td colspan="8" style="text-align: center; height: 100px;">
                        <input type="text" style="text-align:center; font-size: 30px;" readonly><fmt:formatDate value="${approval.appWriteDate}" pattern="yyyy 년 MM 월 dd 일"/></input>
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
                        신청자 : <input type="text" style="width:200px; border: none; text-align: center;" maxlength="4" readonly value="${approval.userName}">
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
	        <button style="color:red">반려</button>
        </div>
    </div>

<%@ include file="../common/footer.jsp" %>