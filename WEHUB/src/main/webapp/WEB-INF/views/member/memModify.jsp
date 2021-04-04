<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="${path}/css/member_modify.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<c:set var="adressArr" value="${ loginMember.address }"></c:set>
	<c:set var="arr" value="${fn:split(adressArr,',')}"/>
	
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
	
	<c:out value="${memAdress[0]}"></c:out>
	<c:out value="${memAdress[1]}"></c:out>
	<c:out value="${memAdress[2]}"></c:out>
	
	<div class="member__modify">
      <div id="member__modify__form">
        <form action="${path}/member/update" method="post" enctype="multipart/form-data">
		<span id="modify_name">회원정보수정</span>
			<table>
				<tr>
				    <td><label for="modify_img">프로필 사진</label></td>
				    <td id="imgTd">
					    <img class="UserModifyImg" src="${path}/upload/userProfileImg/${loginMember.user_imgRename}">
					    <input type="file" id="modify_img" type="text" name="user_img" value="" style="">
					</td>
				    <td>
			    		<%-- <c:set var="userImgChk" value="${path}/upload/userProfileImg/${loginMember.user_imgRename}">
							<c:choose>
								<c:when test="${ empty userImgChk }">
									<img class="UserModifyImg" src="${path}/images/userImage.png">
								</c:when>
								<c:when test="${ !empty userImgChk }">
									<img class="UserModifyImg" src="userImgChk">
								</c:when>		
							</c:choose>
						</c:set> --%>
				    </td>
				</tr>
				<tr>
				    <td><label for="modify_id">아이디</label></td>
				    <td><input id="modify_id" type="text" name="user_id" value="${ loginMember.user_id }" readonly></td>
				    <td></td>
				</tr>
				<%-- <tr>
				    <td><label for="modify_password">비밀번호</label></td>
				    <td><input class="modify_input" id="modify_password" type="password" name="user_pwd" placeholder="변경할 비밀번호를 입력해 주세요." ></td>
				    <td><button class="btn" id="modify_btn_pw" type="button" id="pw_modify" onclick="location.href='${path}/member/updatePassword'">비밀번호변경</button></td>
				</tr> --%>
				<tr>
				    <td><label for="modify_company">회사명</label></td>
				    <td><input id="modify_company" name="user_companyname" type="text" value="${ loginMember.user_companyname }" readonly></td>
				    <td></td>
				</tr>
				<tr>
				    <td><label for="modify_userNo">사번</label></td>
				    <td><input id="modify_userNo" name="userNo" type="text" value="A12345" readonly></td>
				    <td></td>
				</tr>
				<tr>
				    <td><label for="modify_userName">사원명</label></td>
				    <td><input id="modify_userName" name="user_name" type="text" value="${ loginMember.user_name }" readonly></td>
				    <td></td>
				</tr>
				<tr>
				    <td><label for="modify_Grade">직급</label></td>
				    <td><input id="modify_Grade" name="rank" type="text" value="${ loginMember.rank }" readonly></td>
				    <td></td>
				</tr>
				<tr>
				    <td><label for="modify_email">이메일</label></td>
				    <td><input class="modify_input" name="email" id="modify_email" type="email" value="${ loginMember.email }"></td>
				    <td></td>
				</tr>
				<tr>
				    <td><label for="modify_phone">내선전화</label></td>
				    <td><input class="modify_input" name="comcall" id="modify_phone" type="tel" value="${ loginMember.comcall }"></td>
				    <td></td>
				</tr>
				<tr>
				    <td><label for="modify_cellPhone">휴대전화</label></td>
				    <td><input class="modify_input" name="phone" id="modify_cellPhone" type="tel" value="${ loginMember.phone }"></td>
				    <td></td>
				</tr>
				<tr>
				    <td><label for="modify_address">주소</label></td>
				    <td><input class="modify_input" name="address" id="kakao_postcode" type="text" value="${arr[0]}" readonly="readonly"></td>
				    <td><button class="btn" id="modify_btn_addr" type="button" onclick="sample6_execDaumPostcode();">주소찾기</button></td>
				</tr>
				<tr>
				    <td></td>
				    <td><input class="modify_input" name="address" id="kakao_address" type="text" value="${arr[1]}" readonly="readonly"></td>
				    <td></td>
				</tr>
				<tr>
				    <td></td>
				    <td><input class="modify_input" name="address" id="kakao_detailAddress" type="text" value="${arr[2]}"></td>
				    <td></td>
				</tr>
				<tr>
				    <td></td>
				    <td><input class="modify_input" name="address" id="kakao_extraAddress" type="text" value="${arr[3]}" readonly="readonly"></td>
				    <td></td>
				</tr>
			</table>
          <div id="modify_button">
            <button class="btn" id="modify_btn" type="submit" onclick="location.href='${path}/member/update'">회원정보수정</button>
            <button class="btn" id="modify_btn_b" type="button" onclick="javascript:deleteMember();">회원탈퇴</button>
        </div> 
        <button class="btn" id="pass_btn" type="button" onclick="location.href='${path}/member/updatePassword'">비밀번호수정</button>
        </form>
      </div>  
    </div>
    
<script>
	$(document).on("keyup", "#modify_cellPhone, #modify_phone", function() { 
		$(this).val( $(this).val()
				.replace(/[^0-9]/g, "")
				.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3")
				.replace("--", "-") ); 
	});
	
	function deleteMember() {
		if(confirm("정말로 탈퇴하시겠습니까?")) {
			location.replace("${path}/member/delete?user_id=${ loginMember.user_id }")
		}
	}
	
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
</script>
   
<%@ include file="/WEB-INF/views/common/footer.jsp" %>