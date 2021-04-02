<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/css/updatePassword.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<style>
	.UserModifyImg {
		  display: inline-flex;
		  width: 40px;
		  height: 40px;
		  border-radius: 50%;
		  overflow: hidden;
		  object-fit: cover;
		}
	</style>
	
	<div class="member__modify">
      <div id="member__modify__form">
        <form action="${path}/member/updatePass" method="post">
        <br><br><br><br>
		<span id="modify_name">비밀번호 수정</span>
			<table>
				<tr>
				    <td><label for="modify_password">현재 비밀번호</label></td>
				    <td><input class="modify_input" id="updatePassword" type="password" name="oldUserPwd" placeholder="현재 쓰시는 비밀번호를 입력해 주세요." ></td>
				    <td><%-- <button class="btn" id="modify_btn_pw" type="button" id="pw_modify" onclick="location.href='${path}/member/updatePassword'">비밀번호변경</button> --%></td>
				</tr>
				<tr>
				    <td><label for="modify_password">새 비밀번호</label></td>
				    <td><input class="modify_input" id="updatePassword" type="password" name="user_pwd" placeholder="변경할 비밀번호를 입력해 주세요." ></td>
				    <td><%-- <button class="btn" id="modify_btn_pw" type="button" id="pw_modify" onclick="location.href='${path}/member/updatePassword'">비밀번호변경</button> --%></td>
				</tr>
				<tr>
					<td><label for="modify_password">새 비밀번호 확인</label></td>
				    <td><input class="modify_input" id="updateChkPassword" type="password" name="chkUserPwd" placeholder="비밀번호를 다시 입력하세요." ></td>
				</tr>
				<tr>
					<td></td>
					<td><label id="chkPass" style="font-size: 13px; color: red;"></label></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>
			</table>
          <div id="modify_button">
            <button class="btn" id="updatePass_btn" type="submit" onclick="location.href='${path}/member/updatePassword'">비밀번호 수정</button>
            <button class="btn" id="resetPass_btn" type="reset">비밀번호를 잊으셨나요?</button>
        </div> 
        <%-- location.href='${path}/member/updatePass' --%>
        
        
        </form>
      </div>  
    </div>
    
<script>
	/* function chkPassword() {
		var pass1 = document.getElementById("updatePassword").value;
		var pass2 = document.getElementById("updateChkPassword").value;
		var chkPass = document.getElementById("chkPass").text;
		
		if(pass1 != pass2) {
			chkPass.innerHTML="비밀번호 확인을 정확하게 입력해 주시길 바랍니다!";
		}
		
		if(pass1.length < 4 || != pass2.length < 4) {
			chkPass.innerHTML="비밀번호 확인을 정확하게 입력해 주시길 바랍니다!";
		}
	} */
	
	
</script>
   
<%@ include file="/WEB-INF/views/common/footer.jsp" %>