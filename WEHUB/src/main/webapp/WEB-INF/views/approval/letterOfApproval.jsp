<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>
<%-- <%@ include file="../approval/approvalSubMenu.jsp" %> --%>

<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<script src="${path}/js/jquery-3.5.1.js"></script>
<style>
	* {font-family: 'InfinitySans-RegularA1'; }
	@font-face {
	    font-family: 'InfinitySans-RegularA1';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	.searchMember{
		font-family: 'InfinitySans-RegularA1';
		font-size: 14px;
		width: 55px;
		height: 30px;
		background-color: #fff;
		border: 1px solid #5b18ff;
		border-radius: 5px;
	}
	.modalys{ 
		position:absolute; 	
		width:100%; 
		height:100%; 
		background: rgba(0,0,0,0.8); 
		top:0; 
		left:0; 
		display:none; 
	}
	.modal_content{
	  width:400px; height:315px;
	  background:#fff; border-radius:10px;
	  position:relative; top:50%; left:50%;
	  margin-top:-100px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box; padding:74px 0;
	  line-height:23px; cursor:pointer;
	}
	#modalClose {
		font-family: 'InfinitySans-RegularA1';
		font-size: 14px;
		margin: 15px; /* 50px */
	}
	.APPLE_searchArea {
	  border: 0; border-bottom: 3px solid #5b18ff;
	  font-size: 18px;
	  font-family: 'InfinitySans-RegularA1';
	  padding: 8px; /* 서치바랑 검 */
	}
	.APPLE_searchBox {
	  border: 0;
	  color: #5b18ff; background-color: #fff;
	  border-bottom: 2px solid #5b18ff;
	  margin-left: -20px;
	  margin-bottom: -20px;
	  border-radius: 0;
	}
	.fa-check { font-size: 10px; }	
	.nameView{ height: 50px; }
	label { display: inline-block; font-family: 'InfinitySans-RegularA1'; font-size: 14px; }
	.form-radio{
    display: inline-block; 
    line-height: 20px; 
    vertical-align: middle;
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
	.form-radio::before{
	    border-radius: 50%;
	}
	.input-chek, .input-radio{
	    display: none;
	}
	.input-chek:checked + .form-chek::before, .input-radio:checked + .form-radio::before{
	    background: #5b18ff;
	}
	.input-chek:checked + .form-chek, .input-radio:checked + .form-radio{
	    color: #5b18ff;
	}
	.modalInputName{font-family: 'InfinitySans-RegularA1'; font-size: 28px; padding-bottom: 50px; color:#5b18ff; }
	.anserMember{ font-size: 18px; }
</style>


<form action="${path}/approval/letterOfApproval" method="POST" name="loaWriteForm" onsubmit="return check_onclick()">
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
                	<td style="">
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
                    <td colspan="2" style="height: 70px;">
                        <button class="send-open" type="button">수신참조자 +</button>
                    </td>
                    <td colspan="6" style="height: 70px;">
                    	<textArea readonly name="referList" id="referList" style="border:none;margin-bottom:-12px; font-size:19px; width:600px; height:60px; text-align: center; resize: none;"></textArea>
                    </td>	
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">성 명</td>
                    <td><input type="text" name="writerName" value="${loginMember.user_name}" readonly></td>
                    <td style="width: 80px;">부 서</td>
                    <td><input type="text" value="${loginMember.dept_name}" readonly></td>
                    <td style="width: 80px;">직 급</td>
                    <td colspan="3"><input type="text" value="${loginMember.rank}" readonly></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">제 목</td>
                    <td colspan="8"><input type="text" name="loaTitle" id="loaTitle"></td>
                </tr>
                <tr>
                    <td colspan="8" style="height: 90px;" >
                        <button type="button">파일첨부 +</button>
                        파일이름.img
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="height: 70px; width: 80px;">품의사유 및 상세내용</td>
                </tr>
                <tr>
                    <td colspan="8">
                        <textarea name="loaContent" id="loaContent" cols="151px" rows="11px" style="width: 100%; height: 100%; border: none; resize: none; overflow: hidden; font-size: 25px;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위와 같은 품의사유로, 검토 후 결재 바랍니다.</td>
                </tr>
                <tr style="border: white;">
                    <td colspan="8" style="text-align: center; height: 100px;">
                        <input type="text" style="text-align:center; font-size: 30px;" readonly value="${ serverTime }">
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
                        <input type="button" name="proposer" id="proposer" style="font-size:15px; width:70px; height:30px; border: none; text-align: center; border-radius:20px; margin-right:10px" value="서명" />
                        신청자 : 
                        <textArea name="proposerText" id="proposerText" style="width:130px; border: none; text-align: center; resize: none; font-size:24px; margin-bottom:-42px"></textArea>
                        (인)
                    </td>
                </tr>
            </table>
        </div>
        <div id="button">
        	<button type="submit">등록</button>
	        <input type="text" style="border: none; width: 40px;" disabled>
	        <button>취소</button>
        </div>
    </div>
</form>

	<!-- 승인자 모달 -->

    <!-- 최초 승인자 모달창  -->
    <div id="testForm1" name="testForm1">
	    <div class="modalys Amodal1">
	    	<div class="modal_content">
	    	<div class="modalInputName">이름을 입력해 주세요.</div>
	    		<div>
	    			<input type="text" id="memSearchInput1" name="userName" class="APPLE_searchArea"> <lable class="anserMember">님이 맞으신가요?</lable>
	    		</div>
	    		<br><br>
	    			<button class="searchMember" type="button" id="modalCloseFirst">확인</button>
	    	</div>
	    </div>
    </div>
    
    <!-- 중간 승인자 모달창  -->
    <div id="testForm" name="testForm">
	    <div class="modalys Amodal">
	    	<div class="modal_content">
	    	<div class="modalInputName">이름을 입력해 주세요.</div>
	    		<div>
	    			<input type="text" id="memSearchInput2" name="userName" class="APPLE_searchArea"> <lable class="anserMember">님이 맞으신가요?</lable>
	    		</div>
	    		<br><br>
	    			<button class="searchMember" type="button" id="modalClose2" style="">확인</button>
	    	</div>
	    </div>
    </div>
    
    <!-- 최종 승인자 모달창  -->
    <div id="testForm3" name="testForm3">
	    <div class="modalys Amodal3">
	    	<div class="modal_content">
	    	<div class="modalInputName">이름을 입력해 주세요.</div>
	    		<div>
	    			<input type="text" id="memSearchInput3" name="userName" class="APPLE_searchArea"> <lable class="anserMember">님이 맞으신가요?</lable>
	    		</div>
	    		<br><br>
	    			<button class="searchMember" type="button" id="modalCloseThird">확인</button>
	    	</div>
	    </div>
    </div>

    <!-- modal section -->
    
    <div class="modal hidden">
        <div class="bg"></div>
        <div class="modalBox">
            <div style="margin: 40px 0px 0px 60px;">
                <input type="text" name="searchData" id="searchData" style="width: 250px; height: 30px; border-radius: 10px; font-size: 20px; text-align: center;" maxlength="4" >
                <button type="button" id="search1">검색</button>
            </div>
            
            <div style=" border: 1px solid black; width: 280px; height: 440px; margin: 60px 0px 0px 60px; float: left; text-align: center; overflow:scroll;">
                <table id="refer-left-section" style="width: 100%; border-bottom: 1px solid black; border-collapse: collapse;">
                    <tr style="border-bottom: 1px solid black;">
                        <th>
                            <input type="checkbox" name="refer-listAll" id="refer-listAll" style="height: 15px; margin-top: 6px;">
                        </th>
                        <th>이 름</th>
                        <th>부 서</th>
                        <th>직 책</th>
                    </tr>
                    <c:if test="${memberList != null}">
		                <c:forEach var="member" items="${memberList}">
			                <tr>
			                	<td>
                            		<input type="checkbox" name="refer-list" id="refer-list" style="height: 15px;">
                        		</td>
			                    <td>${member.user_name}</td>
			                    <td>${member.dept_name}</td>
			                    <td>${member.rank}</td>
			                </tr>
		                </c:forEach>
                	</c:if>
                    <tbody></tbody>
                </table>
            </div>
            <div>
                <button class="refer-insert" style="margin: 200px 0px 0px 27px; float: left; position: absolute;"> -> </button>
                <button class="refer-delete" style="margin: 300px 0px 0px 27px; float: left;"> <- </button>
            </div>
            <div style=" border: 1px solid black; width: 280px; height: 440px; margin: 60px 0px 0px 440px; text-align: center; overflow:scroll;">
                <table id="refer-right-section" style=" width: 100%; border-bottom: 1px solid black; border-collapse: collapse;" >
                    <tr style="border-bottom: 1px solid black;">
                        <th>
                            <input type="checkbox" name="D-refer-listAll" id="D-refer-listAll" style="height: 15px; margin-top: 6px;">
                        </th>
                        <th>이 름</th>
                        <th>부 서</th>
                        <th>직 책</th>
                    </tr>
                    <tbody></tbody>
                </table>
            </div>
            <div style="margin: 5% 0px 0px 37%;">
                <span style="padding-right: 60px; float: left;" >
                    <button type="submit" class="closeBtn-in" id="addRefer">추가</button>
                </span>
                <button class="closeBtn-out">닫기</button>
            </div>
        </div>
    </div>
    
    <!-- 필수 입력 스크립트 -->
	<script>

		function check_onclick() {
		    var loaWriteForm = document.loaWriteForm;
		    
		    if(loaWriteForm.loaContent.value=="" || loaWriteForm.loaTitle.value==""){
		        alert("상세내용 또는 제목란이 비어있습니다. 확인 후 등록하세요.");
		        
		        return false;
		    } else if(loaWriteForm.proposerText.value=="") {
		       alert("서명 후 등록을 완료해주세요.");
		       
		       return false;
			} else {
				return true;
			}
		    
		}

	</script>


    
    <!-- 서명 클릭 스크립트  -->
    
    <script>
    	$("#proposer").one("click",function(){
     		var proposerValue = $("input[name='writerName']").val();
     	
     		$("#proposerText").append(proposerValue);
    	});
    </script>
    
    
    <!-- 모달 내 검색 스크립트 -->
    
    <script>
    	$("#search1").on("click",function(){
        	var searchData = $("input[name='searchData']").val();
                	
            $.ajax({
                   type: "get",
                   url: "${path}/approval/searchMemberInModal",
                   data: {
   				       searchData:searchData
   				   },
                   success: function(data){
                   	   console.log(data);
                   	
                       $("#refer-left-section").empty();
                       $("#refer-left-section").append(
                       		'<tr style="border-bottom: 1px solid black;">'
                               +'<th>'
                               +'<input type="checkbox" name="refer-listAll" id="refer-listAll" style="height: 15px; margin-top: 6px;">'
                               +'</th>'
                               +'<th>이 름</th>'
                               +'<th>부 서</th>'
                               +'<th>직 책</th>'
                           +'</tr>'
                       );
                       
                       var str = '<tr>';
                   	
	                   $.each(data, function(i) {
	                       str +='<tr><td><input type="checkbox" name="refer-list" id="refer-list" style="height: 15px;"></td>'
	    	               +'<td>'+ data[i].user_name +'</td>'
	    	               +'<td>'+ data[i].dept_name +'</td>'
	    	               +'<td>'+ data[i].rank +'</td>';
	    	               str += '</tr>';
	                   });
                       
                       $("#refer-left-section").append(str);
                       
                       $("#refer-left-section").append(
				           '<tbody></tbody>'
                       );
                      
                       $("#refer-left-section").append(
                           "<script>"
	                           + "$(document).ready(function() {"
		               	           + "$('#refer-listAll').click(function() {"
		               	               + "if($('#refer-listAll').prop('checked')){"
		               	                   + "$('input[name=refer-list]:checkbox').prop('checked', true);"
	             	     	           + "} else {"
		               	                   + "$('input[name=refer-list]:checkbox').prop('checked', false);"
		               	               + "}"
		               	           + "});"
	               	           + "});"
               	           + "<\/script>"
               	           /* + 'document.querySelector(".closeBtn-out").addEventListener("click", close);' */
                       );
            	   },
                   error: function(){ alert("잠시 후 다시 시도해주세요."); }
       		});
		});
	</script>
	
	<!-- 모달 스크립트 -->
	
	<script>
	    // modal 창 띄우기
		
	    const open = () => {
	    	document.querySelector(".modal").classList.remove("hidden");
	    	
	    }
	
	    const close = () => {
	        document.querySelector(".modal").classList.add("hidden");
	    }
	
	    document.querySelector(".send-open").addEventListener("click", open);
	    document.querySelector(".closeBtn-out").addEventListener("click", close);
	
	    
	    // 수신참조자 추가하기 -> 전체 (선택, 해제)
	    
	    $(document).ready(function() {
	        $('#refer-listAll').click(function() {
	            if($('#refer-listAll').prop('checked')){
	                $('input[name=refer-list]:checkbox').prop('checked', true);
	            }else {
	                $('input[name=refer-list]:checkbox').prop('checked', false);
	            }
	        });
	    });
	
	    /* refer-insert */
	
	    $(document).ready(function() {
	        $('.refer-insert').click(function() {
	
	            var rowData = new Array();
	            var tdArr = new Array();
	            var checkbox = $("input[name=refer-list]:checked");
	            
	            
	            checkbox.each(function(i) {
		
		            var tr = checkbox.parent().parent().eq(i);
		            var td = tr.children();
		            
		            console.log('checkbox: ' + checkbox.parent().parent().eq(i));
		            console.log('tr.children(): ' + tr.children());
		            console.log('tr: ' + tr);
		            console.log('td: ' + td);
		            
		            rowData.push(tr.text());
		            
		            console.log('rowData: ' + rowData);
		            
		            var name = td.eq(1).text();
		            var dept = td.eq(2).text();
		            var position = td.eq(3).text();
		            
		            tdArr.push(name);
		            tdArr.push(dept);
		            tdArr.push(position);
					
		            console.log('name: ' + name);
		            console.log('dept: ' + dept);
		            console.log('position: ' + position);
		            console.log('tdArr: ' + tdArr);
		            
		            $('#refer-right-section > tbody:last').append('<tr><td><input type="checkbox" name="D-refer-list" id="D-refer-list" style="height: 15px; margin-top: 6px;"></td>'
		                +'<td>'+ name +'</td>'
		                +'<td>'+ dept +'</td>'
		                +'<td>'+ position +'</td></tr>');
		            
		                for (var i = 1; i < tdArr.length; i++) {
		                    if($('input[name=refer-list]:checked')){
		                        $(this).parent().parent().remove();
		                        $('input[id=refer-listAll]:checkbox').prop('checked', false);
		                    }
		                    
		                }
	            });
	        });
	    });
	    
	    /* refer-delete */
	    
	    $(document).ready(function() {
	        $('#D-refer-listAll').click(function() {
	            if($('#D-refer-listAll').prop('checked')){
	                $('input[name=D-refer-list]:checkbox').prop('checked', true);
	            }else {
	                $('input[name=D-refer-list]:checkbox').prop('checked', false);
	            }
	        });
	    });
	    
	    
	    $(document).ready(function() {
	        $('.refer-delete').click(function() {
	
	            var rowData = new Array();
	            var tdArr = new Array();
	            var checkbox = $("input[name=D-refer-list]:checked");
	            
	            checkbox.each(function(i) {
		
	            var tr = checkbox.parent().parent().eq(i);
	            var td = tr.children();
	            
	            rowData.push(tr.text());
	            
	            var name = td.eq(1).text();
	            var dept = td.eq(2).text();
	            var position = td.eq(3).text();
	            
	            tdArr.push(name);
	            tdArr.push(dept);
	            tdArr.push(position);
	
	            console.log('name: ' + name);
	            console.log('tdArr: ' + tdArr);
	            $('#refer-left-section > tbody:last').append('<tr><td><input type="checkbox" name="refer-list" id="refer-list" style="height: 15px; margin-top: 6px;"></td>'
	                +'<td>'+ name +'</td>'
	                +'<td>'+ dept +'</td>'
	                +'<td>'+ position +'</td></tr>');
	            
	                for (var i = 1; i < tdArr.length; i++) {
	                    if($('input[name=D-refer-list]:checked')){
	                        $(this).parent().parent().remove();
	                        $('input[id=D-refer-listAll]:checkbox').prop('checked', false);
	                    }
	                    
	                }
	
	            });
	        });
	    });
	    
	    $(document).ready(function() {
	        $('#addRefer').click(function() {
	        	
	            var tdArr = new Array();
	            var checkbox = $("input[name=D-refer-list]");
	            
	            checkbox.each(function(i) {
		            var tr = checkbox.parent().parent().eq(i);
		            var td = tr.children();
		            
		            var name = td.eq(1).text();
		            var dept = td.eq(2).text();
		            var position = td.eq(3).text();
		            
		            tdArr.push(name);
		            tdArr.push(dept);
		            tdArr.push(position);
	            	
		            var str = name + " " + position +"(" + dept + ")" + ", ";
		            
		            $('#referList').append(str);		            	
		           
		            $("#refer-right-section").empty();
                    $("#refer-right-section").append(
                    		'<tr style="border-bottom: 1px solid black;">'
                            +'<th>'
                            +'<input type="checkbox" name="refer-listAll" id="refer-listAll" style="height: 15px; margin-top: 6px;">'
                            +'</th>'
                            +'<th>이 름</th>'
                            +'<th>부 서</th>'
                            +'<th>직 책</th>'
                        +'</tr>'
                    );
                    
                    $("#refer-right-section").append(
 				    	'<tbody></tbody>'
                    );
	            });
	            
	            document.querySelector("#addRefer").addEventListener("click", close);
	        });
	    });
	    
	</script>
	
	<script>
	/* 중간 승인자 */
	$(function(){ 
    	$("#secondBtn").click(function(){ 
    		$(".Amodal").fadeIn(); 
    		$("#memSearchInput2").autocomplete({
    			source:function(request, response){
    				$.ajax({
    					url : "${path}/approval/search/json",
    					type : "get",
    					dataType : 'json',
    					data : {
    						userName:$("#memSearchInput2").val()
    					},
    					success : function(data){
    						var result = data;
    						response(result);
    						
    						console.log(data);
    						
    						let arr1 = result[0].split('_');
    						
    						console.log(arr1[0]);
    						console.log(arr1[1]);
    						console.log(arr1[2]);
    						
    						/* document.getElementById('interimName').value = data; */
    						document.getElementById('interimName').value = arr1[0];
    					},
    					error : function(e){
    						alert("ajax에러발생..!")
						}
					});
				},
				focus : function(event, ui) {    //포커스 가면
					return false;//한글 에러 잡기용도로 사용됨
				},
				minLength: 1,// 최소 글자수
				autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
				delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
    		 });
    	}); 
    	
    	$("#modalClose2").click(function(){ 
    		$(".Amodal").fadeOut(); 
    	}); 
    });
	
	/* 최초 승인자 */
	$(function(){ 
		$("#firstBtn").click(function(){ 
			$(".Amodal1").fadeIn(); 
			$("#memSearchInput1").autocomplete({
				source:function(request, response){
					$.ajax({
						url : "${path}/approval/search/json",
						type : "get",
						dataType : 'json',
						data : {
							userName:$("#memSearchInput1").val()
						},
						success : function(data){
							var result = data;
							response(result);
							
							console.log(data);
							
							let arr1 = result[0].split('_');
							
							console.log(arr1[0]);
							console.log(arr1[1]);
							console.log(arr1[2]);
							
							/* document.getElementById('interimName').value = data; */
							document.getElementById('firstApprover').value = arr1[0];
						},
						error : function(e){
							alert("ajax에러발생..!")
						}
					});
				},
				focus : function(event, ui) {    //포커스 가면
					return false;//한글 에러 잡기용도로 사용됨
				},
				minLength: 1,// 최소 글자수
				autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
				delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
			 });
		}); 
		
		$("#modalCloseFirst").click(function(){ 
			$(".Amodal1").fadeOut(); 
		}); 
	});
	
	/* 최종 승인자 */
	$(function(){ 
		$("#thirdBtn").click(function(){ 
			$(".Amodal3").fadeIn(); 
			$("#memSearchInput3").autocomplete({
				source:function(request, response){
					$.ajax({
						url : "${path}/approval/search/json",
						type : "get",
						dataType : 'json',
						data : {
							userName:$("#memSearchInput3").val()
						},
						success : function(data){
							var result = data;
							response(result);
							
							console.log(data);
							
							let arr1 = result[0].split('_');
							
							console.log(arr1[0]);
							console.log(arr1[1]);
							console.log(arr1[2]);
							
							/* document.getElementById('interimName').value = data; */
							document.getElementById('finalApprover').value = arr1[0];
						},
						error : function(e){
							alert("ajax에러발생..!")
						}
					});
				},
				focus : function(event, ui) {    //포커스 가면
					return false;//한글 에러 잡기용도로 사용됨
				},
				minLength: 1,// 최소 글자수
				autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
				delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
			 });
		}); 
		
		$("#modalCloseThird").click(function(){ 
			$(".Amodal3").fadeOut(); 
		}); 
	});
	</script>
<%@ include file="../common/footer.jsp" %>