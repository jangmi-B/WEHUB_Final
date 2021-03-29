<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WEHUB</title>
    <script src="${path}/js/jquery-3.5.1.js"></script>
    <link rel="stylesheet" href="${path}/css/SignUpForm.css">
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <div class="wrapper">
        <div class="container">
            <div id="title">
                <h1><a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/LogInForm.html">Create an account</a></h1>
		        <h2><a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/LogInForm.html">Welcome</a></h2>
            </div>
            
            <form class="form" action="${path}/member/signUpForm" method="post" style="margin-top: -187px;">
				<!--  
                <input type="text" name="user_id" placeholder="UserId">
                <input type="password" name="user_pwd"  placeholder="Password">
                <input type="password" placeholder="PasswordCheck">
                <input type="text"name="user_companyname"  placeholder="CompanyName">
                <input type="text" name="user_name" placeholder="UserName">
                <input type="text" name="dept_code" placeholder="DepartmentName">
                <input type="text" name="rank" placeholder="Rank">
                <input type="email" name="email" placeholder="E-Mail">
                <input type="text"name="address"  placeholder="Address">
                <input type="tel" name="comcall" placeholder="ExtensionNumber">
                <input type="tel"name="phone"  placeholder="Phone">
                -->
                 <input type="text" name="user_companyname"  placeholder="회사명  CompanyName" style="font-size: 13px;" required>
                <input type="button" name="user_companyname_btn"  value="회사 확인" onclick="" style="font-size: 13px;" required>
                <input type="text" name="user_id" placeholder="아이디  UserId" style="font-size: 13px;" id="user_id" required>
                <input type="button" name="user_id_btn" value="아이디 중복 확인" style="font-size: 13px;" id="id_Check_Btn" required>
                <input type="password" name="user_pwd"  placeholder="패스워드  Password" style="font-size: 13px;" id="pass1" required>
                <input type="password" placeholder="패스워드 확인  PasswordCheck" id="pass2"  style="font-size: 13px;">
                <input type="text" name="user_name" placeholder="이름  UserName" style="font-size: 13px;" required>
                <input type="text" name="dept_code" placeholder="부서이름  DepartmentName" style="font-size: 13px;">
                <input type="text" name="rank" placeholder="직급  Rank" style="font-size: 13px;">
                <input type="email" name="email" placeholder="이메일  E-Mail" style="font-size: 13px;">
                <input type="button" name="address"  value="주소 찾기" onclick="javascript:sample6_execDaumPostcode();" style="font-size: 13px;">
                <input type="text" name="address"  placeholder="우편번호 Zip/Postal Code" id="kakao_postcode" style="font-size: 13px;" readonly="readonly">
                <input type="text" name="address"  placeholder="주소  State/Province/Region/City" id="kakao_address" style="font-size: 13px;"  readonly="readonly">
                <input type="text" name="address"  placeholder="상세주소 Street Address" id="kakao_detailAddress" style="font-size: 13px;">
                <input type="hidden" name="address" placeholder="참고항목" id="kakao_extraAddress" style="font-size: 13px;">
                <input type="tel" name="comcall" placeholder="내선번호 ExtensionNumber" style="font-size: 13px;">
                <input type="tel"name="phone"  placeholder="휴대번호  Phone" style="font-size: 13px;">
                
                <!-- 실무에서는 우편번호와 주소지의 컬럼을 따로 받나...? -->
                <button type="submit" id="login-button">가입하기</button> <!-- Create -->
                <button type="submit" id="login-button" onclick="javascript:dataCheck();">기능확인</button>
                <p id="findPwdAndSignUp">
                    <!-- <a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/LogInForm.html" id="fpas">Already have an account?</a>
                    -->
                    <a href="${path}/" id="fpas" style="font-size: 12px;">벌써 회원이신가요?</a>
                </p>
            </form>
            <!--  
            <form class="form1">    
            </form>
            -->
        </div>
    </div>
</body>

<script>
	// kakao 주소찾기 api
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("kakao_extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("kakao_extraAddress").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('kakao_postcode').value = data.zonecode;
	            document.getElementById("kakao_address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("kakao_detailAddress").focus();
	        }
	    }).open();
	}
	
	function dataCheck() {
		var pass1 = document.getElementById('pass1').value;
		var pass2 = document.getElementById('pass2').value;
		
		if(pass1.length < 4) {
			alert("비밀번호를 4글자 이상 입력하세요.");
			
			return false;
		}
		
		if(pass1 != pass2) {
			alert("비밀번호 확인을 정확하게 입력하세요.");
			
			return false;
		}
	}
	
	$(document).ready(() => {
		$("#id_Check_Btn").on("click", () => {
			let user_id = $("#user_id").val().trim();
			var idReg = /^[a-z][a-z0-9]{3,10}$/g;
			
			if(!idReg.test(user_id)) {
				alert("아이디는 영문 소문자와 숫자를 4~12자리로 입력하세요.");
				
				return;
			}
			
			$.ajax({
				type: "post",
				url: "${path}/member/idCheck",
				dataType: "json",
				data: {
					user_id: user_id // 파라미터_키값: value값
				},
				success: function(data) {
					console.log(data);
					
					if(data.validate !== true) {
						alert("사용 가능한 아이디 입니다.");
					} else {
						alert("이미 사용중인 아이디 입니다.");						
					}
				},
				error: function(e) {
					console.log(e);
				}				
			});
			
			/* alert("제이쿼리 작동 확인"); */
		});
	});
</script>

</html>