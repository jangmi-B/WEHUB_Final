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
    
</style>
	
	<div class="withDrawal">
		<table> <!-- border="1px soild black;" -->
			<tr>
				<th colspan="3"><h1>비밀번호 변경</h1></th>
			</tr>
			<tr>
				<td colspan="3">
					<div id="haeder_side">
						비밀번호는 대문자, 소문자, 숫자, 특수문자 중 2종류 이상을 조합하여 최소 10자리 이상 또는<br>
						3종류 이상을 조합하여 최소 7자리 이상만 사용할 수 있습니다. 
						<br><br><br>
					</div>
				</td>
			</tr>
			<tr>
				<td><div class="updateInfo">현재 비밀번호</div></td>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><input type="password" id="nowPass" class="passInput"/></td>
			</tr>
			<tr>
				<td><div class="updateInfo" id="updatePass">변경할 비밀번호</div></td>
				<td>&nbsp;</td>
				<td><input type="password" id="newPass" class="passInput"  name="user_pwd" /></td>
			</tr>
			<tr>
				<td><div class="updateInfo" id="updatePassChk">변경할 비밀번호</div></td>
				<td>&nbsp;</td>
				<td><input type="password" id="newPassChk" class="passInput" /></td>
			</tr>
			<tr>
				<th colspan="3"><br><br>
					<input type="button" id="notupdatePassBtn" onclick="location.href='${path}/main'" value="홈으로">
					<input type="button" id="goUpdatePassBtn" onclick="location.href='${path}/member/updatePassword'" value="비밀번호 변경">
				</th>
			</tr>
		</table>
	</div>
	
<script>
	    var pageLink = '${path}/member/delete?user_id=${ loginMember.user_id }';
	    
	
	$(document).ready(() => {
		$("#id_Check_Btn").on("click", () => {
			let nowPass = $("#nowPass").val().trim();
			var idReg = /^[a-z][a-z0-9]{3,10}$/g;/* 패스워드 유효성 찾아보기 */
			
			if(!idReg.test(user_id)) {
				alert("아이디는 영문 소문자와 숫자를 4~12자리로 입력하세요.");
				
				return;
			}
			
			$.ajax({
				type: "post",
				url: "${path}/member/idCheck",
				dataType: "json",
				data: {
					user_id: nowPass // 파라미터_키값: value값
				},
				success: function(data) {
					console.log(data);
					
					if(data.validate !== true) {
						alert("사용 가능한 아이디 입니다.");
					} else {
						alert("이미 사용중인 아이디 입니다. 다시 입력하여 주십시오.");						
					}
				},
				error: function(e) {
					console.log(e);
				}				
			});
		});
	});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>