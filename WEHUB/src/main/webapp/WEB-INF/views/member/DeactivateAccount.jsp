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
	
	h1 { font-family: 'InfinitySans-RegularA1'; font-size: 45px; }
	
	.withDrawal {
		margin-top: 3%;
		display: flex;
		justify-content: center;
		height: 800px;
		padding-left: 200px;
	}
	
	#haeder { color: #5b18ff; font-family: 'InfinitySans-RegularA1'; font-size: 25px; }
	
	#haeder_side {
		font-family: 'InfinitySans-RegularA1';
		font-size: 15px;
		color: gray;
	}
	
	#content { border: 1px solid #D5D4D4; }
	
	#contentOne  { 
		font-family: 'InfinitySans-RegularA1';
		font-size: 16px;
		padding: 10px 30px 10px 15px;
		line-height: 1.7em;
		background-color: #EEE7F8;
		letter-spacing: -0.03em;
	}
	
	#header_2 { color: #5b18ff; font-family: 'InfinitySans-RegularA1'; font-size: 25px; height: 25px; }
	
	#contentTwo { 
		font-family: 'InfinitySans-RegularA1';
		font-size: 16px;
		line-height: 1.7em;
		padding: 10px 30px 10px 15px;
		background-color: #F3F3F3;
		letter-spacing: -0.03em;
	}
	
	#chkment{ font-size: 16px; font-family: 'InfinitySans-RegularA1'; }
	
	#byeBtn {
		font-family: 'InfinitySans-RegularA1';
		font-size: 20px;
		margin-top: 35px;
		border: 1px solid #5b18ff;
		border-radius: 3px;
		background-color: #5b18ff;
		color: #fff;
		width: 130px;
		height: 53px;
	}
	#byeBtn:hover { 
		border: 1px solid #5b18ff;
	    background: linear-gradient(to right, #5b18ff, #8b5dff);
	    color: white; 
    }
    
    #notByeBtn {
    	font-family: 'InfinitySans-RegularA1';
		font-size: 20px;
		margin-top: 35px;
		border: 1px solid #5b18ff;
		border-radius: 3px;
		background-color: #fff;
		color: #5b18ff;
		width: 130px;
		height: 53px;
    }
    #notByeBtn:hover { 
		border: 1px solid #5b18ff;
	    background: linear-gradient(to right, #fff, #e1daf6);
	    color: #5b18ff; 
    }
    #byeBtnArea { margin: 30px;}
</style>

	<div class="EPay-index_section">
	    <h2 style="margin-left:19px;"><a style="color:black; font-family: 'InfinitySans-RegularA1';">마이페이지</a></h2>
	    <li class="memDA EPay-form">
	        <a href="${path}/member/memModify" style="color:black; font-family: 'InfinitySans-RegularA1';">회원 수정</a>
	    </li>
	    <li class="memDA EPay-list">
	        <a href="${path}/member/updatePassword" style="color:black; font-family: 'InfinitySans-RegularA1';">비밀번호 수정</a>
	    </li>
	    <li class="memDA EPay-box">
	        <a href="${path}/member/DeactivateAccount" style="color:black; font-family: 'InfinitySans-RegularA1';">회원 탈퇴</a>
	    </li>
	</div>
	
	<div class="withDrawal">
		<table>
			<tr>
				<td><h1>회원탈퇴</h1></td>
			</tr>
			<tr>
				<td><span id="haeder">회원을 탈퇴하시겠습니까?</span></td>
			</tr>
			<tr>
				<td><span id="haeder_side">
						회원탈퇴 시 개인정보 및 WEHUB에서 만들어진 모든 데이터는 삭제됩니다.<br>
						(단, 아래 항목은 표기된 법률에 따라 특정 기간 동안 보관됩니다.)<br><br>
					</span>
					<div id="content">
						<div id="contentOne">
							1. 계약 또는 청약청회 등에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간 : 5년<br>
							2. 대금결제 및 재화 등의 공급에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간 : 5년<br>
							3. 전자금융 거래에 관한 기록 보존 이유 : 전자금융거래법 보존 기간 / 보존 기간 : 5년<br>
							4. 소비자의 불만 또는 분쟁처리에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 보존 기간 / 보존 기간 : 3년<br>
							5. 신용정보의 수집/처리 및 이용 등에 관한 기록 보존 이유 : 신용정보의 이용 및 보호에 관한 법률 보존 기간 / 보존 기간 : 3년<br>
							6. 전자(세금)계산서 시스템 구축 운영하는 사업자가 지켜야 할 사항 고시(국세청 고시 제 2016-3호)(전자세금계산서 사용자에 한함) / 보존 기간 : 5년<br>
							&nbsp;&nbsp;&nbsp;(단, (세금)계산서 내 개인식별번호는 3년 경과 후 파기)<br>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td><br><span id="header_2">유의사항</span></td>
				<td></td>
			</tr>
			<tr>
				<td>
					<div id="content">
						<div id="contentTwo">
							- 회원탈퇴 처리 후에는 회원님의 개인정보를 복원할 수 없으며, 회원탈퇴 진행 시 해당 아이디는 영구적으로 삭제되어 재가입이 불가능합니다.<br>
							- 소속된 회사가 존재할 경우, "탈퇴"회원으로 조회됩니다.<br>
							- 회사가 WEHUB 내에 존재하는 경우, 회사에 귀속된 데이터에 대해서는 보관됩니다.
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td><br>
					<input type="checkbox" name="agree"><span id="chkment"> 해당 내용을 모두 확인했으며, 회원 탈퇴에 동의합니다.</span>
				</td>
			</tr>
			<tr>
				<th>
					<div id="byeBtnArea">					
						<input type="button" id="notByeBtn" onclick="location.href='${path}/main'" value="홈으로">
						<input type="button" id="byeBtn" onclick="agreeAndDeleteMember();" value="탈퇴하기">
					</div>
				</th>
			</tr>
		</table>
	</div>
	
<script>
	// 코드 돌려막기
	function agreeAndDeleteMember() { 
	    var chkbox = document.getElementsByName('agree'); 
	    var chk = false; 
	    var pageLink = '${path}/member/delete?user_id=${ loginMember.user_id }';
	    
	    for(var i=0 ; i < chkbox.length ; i++) { 
	        if(chkbox[i].checked) { 
	            chk = true; 
	        } else { 
	            chk = false; 
	        } 
	    }
	    
	    if(chk) { 
	    	
	        return location.href=pageLink; 
	    } else { 
	        alert("약관에 동의하지 않으면 탈퇴할 수 없습니다.");
	    } 
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>