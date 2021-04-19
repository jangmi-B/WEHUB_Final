<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<style>
	@font-face {
	    font-family: 'InfinitySans-RegularA1';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	h1 { font-family: 'InfinitySans-RegularA1'; font-size: 45px; color: #5b18ff; letter-spacing: -2px; height: 35px;}
	
	.withDrawal {
		margin-top: 10%;
		display: flex;
		justify-content: center;
		/* height: 800px; */
	}
	
	/* #haeder { color: #5b18ff; font-family: 'InfinitySans-RegularA1'; font-size: 22px; } */
	
	.updateInfo { font-size: 17px; font-family: 'InfinitySans-RegularA1'; height: 50px;}
	#haeder_side {
		font-family: 'InfinitySans-RegularA1';
		font-size: 15px;
		color: gray;
		text-align: center;
	}
	#goUpdatePassBtn {
		font-family: 'InfinitySans-RegularA1';
		font-size: 18px;
		margin: 35px 0 0 15px;
		border: 1px solid #5b18ff;
		border-radius: 3px;
		background-color: #5b18ff;
		color: #fff;
		width: 150px;
		height: 48px;
	}
	#goUpdatePassBtn:hover { 
		border: 1px solid #5b18ff;
	    background: linear-gradient(to right, #5b18ff, #8b5dff);
	    color: white; 
    }
    
    #notupdatePassBtn {
    	font-family: 'InfinitySans-RegularA1';
		font-size: 18px;
		margin-top: 35px;
		border: 1px solid #5b18ff;
		border-radius: 3px;
		background-color: #fff;
		color: #5b18ff;
		width: 120px;
		height: 48px;
    }
    #notupdatePassBtn:hover { 
		border: 1px solid #5b18ff;
	    background: linear-gradient(to right, #fff, #e1daf6);
	    color: #5b18ff; 
    }
    .passInput {
    	width: 250px;
    }
    .updateInfo {
    	text-align: right;
    	padding: 13px 0 0 0;
    }
    
    input[type=password]{
    	border: 1px solid #5b18ff;
    	border-radius: 3px;
    	margin: 8px 0;
    	outline: none;
    	padding: 8px;
    	box-sizing: border-box;
    	transition: .3s;
    }
    input[type=password]:focus {
    	border-color: #5b18ff;
    	box-shadow: 0 0 8px 0 #5b18ff;
    }
    #checkPwd { font-family: 'InfinitySans-RegularA1'; color : red; }
</style>

<div class="EPay-index_section">
    <h2 style="margin-left:19px;"><a style="color:black; font-family: 'InfinitySans-RegularA1';">마이페이지</a></h2>
    <li class="memDA EPay-form">
        <a href="${path}/member/memModify" style="color:black; font-family: 'InfinitySans-RegularA1';">회원 수정</a>
    </li>
    <li class="memDA EPay-list">
        <a href="${path}/member/newUpdatePassword" style="color:black; font-family: 'InfinitySans-RegularA1';">비밀번호 수정</a>
    </li>
    <li class="memDA EPay-box">
        <a href="${path}/member/DeactivateAccount" style="color:black; font-family: 'InfinitySans-RegularA1';">회원 탈퇴</a>
    </li>
</div>

<form method="post" action="${path}/member/updatePass" name="formUpdatePass">
	<div class="withDrawal">
		<table> <!-- border="1px soild black;" -->
			<tr>
				<th colspan="3"><h1>비밀번호 변경</h1></th>
			</tr>
			<tr>
				<td colspan="3">
					<div id="haeder_side">
						비밀번호는 7~15자리의 대문자, 소문자, 숫자, 특수문자 중 2종류 이상 조합하여 사용해야 합니다.<br>
						또한, 동일한 숫자 또는 문자를 3번 연속 사용할 수 없으며 아이디와 일치할 수 없습니다.
						<br><br><br>
					</div>
				</td>
			</tr>
			<!-- <tr>
				<td><div class="updateInfo">현재 비밀번호</div></td>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><input type="password" id="user_pwd" class="passInput" name="user_pwd"/></td>
			</tr> -->
			<tr>
				<input type="hidden" id="loginId" value="${ loginMember.user_id }">
				<td><div class="updateInfo" id="updatePass">변경할 비밀번호</div></td>
				<td>&nbsp;</td>
				<td><input type="password" id="user_pwd" class="passInput"  name="user_pwd" /></td>
			</tr>
			<tr>
				<td><div class="updateInfo" id="updatePassChk">비밀번호 확인</div></td>
				<td>&nbsp;</td>
				<td>
					<input type="password" name="newPassChk" id="newPassChk" class="passInput"  onkeyup="checkPwd()"/>
					<div id="checkPwd">동일한 암호를 입력하세요.</div>					
				</td>
			</tr>
			<tr>
				<th colspan="3"><br><br>
					<input type="button" id="notupdatePassBtn" onclick="location.href='${path}/main'" value="홈으로">
					<input type="button" id="goUpdatePassBtn" onclick="javascript:chekPassword();" value="비밀번호 변경">
				</th>
			</tr>
		</table>
	</div>
</form>	

<script>
	// 안내 멘트
	function checkPwd(){
		var f1 = document.forms[0];
		var pw1 = f1.user_pwd.value;
		var pw2 = f1.newPassChk.value;
		  
		if(pw1!=pw2){
			document.getElementById('checkPwd').style.color = "red";
			document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
		} else {
			document.getElementById('checkPwd').style.color = "#32CD32";
			document.getElementById('checkPwd').innerHTML = "암호가 확인되었습니다.";
		}
	}
	
	// 가입 넘어가기전 alert 경고
	function chekPassword(){
		var mbrId = $("#loginId").val();   // id 값 입력
		var mbrPwd = $("#user_pwd").val();  // pw 입력
		var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9]).{7,15}$/.test(mbrPwd);   //영문,숫자
		var check2 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{7,15}$/.test(mbrPwd);  //영문,특수문자
		var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{7,15}$/.test(mbrPwd);  //특수문자, 숫자
		var updateForm = document.formUpdatePass;
	
		if(!(check1||check2||check3)){
			alert("사용할 수 없은 조합입니다.\n패스워드 설정안내를 확인해 주세요.");
	
			return false;
		}
	
		if(/(\w)\1\1/.test(mbrPwd)){
			alert('같은 문자를 3번 이상 사용하실 수 없습니다.\n패스워드 설정안내를 확인해 주세요.');
	
			return false;
		}
	
		if(mbrPwd.search(mbrId)>-1){
			alert("비밀번호에 아이디가 포함되었습니다.\n패스워드 설정안내를 확인해 주세요.");
	
			return false;
		}
		
		updateForm.submit();
	}
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>