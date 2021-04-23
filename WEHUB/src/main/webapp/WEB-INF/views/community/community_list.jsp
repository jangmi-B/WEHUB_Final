<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>
<script type="text/javascript" src="${path}/ckeditor/ckeditor.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

   
       <div class="CM-index_section">
           <h1>커뮤니티</h1>
           <div class="line"></div>
           <button id="CM_write_Btn">게시글 작성</button>
           <li class="CM-form">보관함
               <div>
                   <ul>
                       <li><a href="${path}/community/myList">-내가 작성한 목록</a></li>
                       <li><a href="${path}/community/favList">-즐겨찾기</a></li>
                   </ul>
               </div>
           </li>
       </div>
      <form id="listform" method="get" action="${path}/community/list">
       <div id="searchArea">
          <input type="text" name="CM_searchText" placeholder="검색" style="border-radius: 18px; width: 450px; height: 39px; text-align: center; margin: 40px 0px 0px 36%">   
           <button type="submit" style='border: none; background: none;' ><i class="fas fa-search" style='font-size: 25px;cursor: pointer;'></i></button>       
       </div>
         <table id="CM-table" style=" margin: 30px 0px 30px 470px; border-radius: 10px;   border:1px solid darkblue; line-height : 4;">
            <thead style="text-align: center;">
               <tr style="height:50px; background: lavender;">
                  <td style="width:120px;">번호</td>
                  <td style="width:600px;">제목</td>
                  <td style="width:120px;">조회수</td>
                  <td style="width:120px;">날짜</td>
               </tr>
            </thead>
            <tbody id="CM_Content" style="text-align: center;">
               <c:choose>
                   <c:when test=" ${ list == null || list.size() == 0 }">
                      <tr><td colspan="4" align="center"> 존재하지 않습니다.</td></tr>
                   </c:when>
                   <c:when test="${ list != null}">
                        <c:forEach var="list" items="${list}">
                             <tr id='tag_TR${list.cm_no}' style='cursor:pointer;' class='tag_TR' onclick="view(${list.cm_no})">
                                 <td id='listNo'>${list.rownum}</td>
                                 <td>${list.cm_title}</td>
                                 <td>${list.cm_readCount}</td>
                                 <td><fmt:formatDate type="date" value="${list.cm_date}"/></td>
                             </tr>
                       </c:forEach>
                    </c:when>
                 </c:choose>
            </tbody>
         </table>
      </form>
      <div id="CM_Content1" style="text-align: center;">
      <c:if test="${CM_searchText == null}">
         <button style=" font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?page=1'">처음페이지</button>
         <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?page=${pageInfo.getPrvePage()}'">&lt;&lt;</button>
         <c:forEach var="page" begin="${pageInfo.getStartPage()}" end="${pageInfo.getEndPage()}">
             <c:choose>
                <c:when test="${page} == ${pageInfo.getCurrentPage()}">
                   <button style="font-size: 18px; border:none; background:none; cursor:pointer;" disabled="disabled">${page}</button>
                </c:when>
                <c:otherwise>
                   <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?page=${page}'">${page}</button>
                </c:otherwise>
             </c:choose>
          </c:forEach>
         <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?page=${pageInfo.getNextPage()}'">&gt;&gt;</button>
         <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?page=${pageInfo.getMaxPage()}'">마지막페이지</button>
      </c:if>
      <c:if test="${CM_searchText != null}">
         <button style=" font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?CM_searchText=${CM_searchText}&page=1'">처음페이지</button>
         <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?CM_searchText=${CM_searchText}&page=${pageInfo.getPrvePage()}'">&lt;&lt;</button>
         <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
                <c:if test="${status.current == pageInfo.currentPage}">
                   <button style="font-size: 18px; border:none; background:none; cursor:pointer;" disabled><c:out value="${status.current}"/></button>
                </c:if>
                <c:if test="${status.current != pageInfo.currentPage}">
                   <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?CM_searchText=${CM_searchText}&page=${status.current}'"><c:out value="${status.current}"/></button>
               </c:if>
          </c:forEach>
         <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?CM_searchText=${CM_searchText}&page=${pageInfo.getNextPage()}'">&gt;&gt;</button>
         <button style="font-size: 18px; border:none; background:none; cursor:pointer;" onclick="location.href='${path}/community/list?CM_searchText=${CM_searchText}&page=${pageInfo.getMaxPage()}'">마지막페이지</button>
      </c:if>
      </div>
      
      <div class="modal fade">
          <div class="bg"></div>
          <div class="modalContainer">
            <h2 style="margin-left:18px;">쪽지쓰기 </h2>
              <div class="info">
                 <input type="hidden" id="msgFrom" name="msgFrom" value="<c:out value="${loginMember.user_no}"/>">
                 <input type="hidden" id="msgTo" name="msgTo">
                <label>To : </label> <input type="text" id="memSearchInput" name="userName" readonly>
              </div>
              <div style="float:right; padding-right:25px; font-size:12px; margin-top:15px;">
                <span id="writeCnt">0</span>/<span id="writeMax">300</span>
              </div>
              <div class ="write_form">
                <textarea class = "form-control" rows="3" id="msgContent" name ="msgContent" style="overflow: scroll;"></textarea>
              </div>
              <div class ="write_form">
                 <button type="button" id="sendBtn" class ="sendBtn">보내기</button>
                 <button type="button" class ="closeBtn">닫기</button>
              </div>
          </div>
        </div>

   <script>
   $(document).ready(function () {
        $('.CM-form').on('click', function() {
            $('.CM-form > div').slideToggle();
        });
    });
   
   
   $(document).ready(function() {
      $('#CM_write_Btn').one('click', function() {
         $.ajax({
            type:"GET",
            url:"writeView",
            
            success:function(data) {
               console.log(data)
               
               $('#listform').remove();
               $('#CM_Content1').remove();
               $('#viewForm').remove();
               $('#returnList').remove();
               $('#searchArea').remove();
               $('#updateList').remove();
               $('#deleteList').remove();
               
               var form = $("<form id='writeForm' action='/community/writeView' method='get' enctype='multipart/form-data'></form>").insertAfter('.CM-index_section');
                  var divFirst = $("<div style='height: 600px; margin: 100px 400px 80px 500px; font-size: 23px; border: 1px solid; border-radius: 10px;'></div>").appendTo(form);
                  $("<span style='display: block; float: left; padding: 0px 0px 0px 10px; font-weight: 900;'></span>").text("작성자 : " + data.user_name).appendTo(divFirst);
                  $("<span style='display: block; text-align: end; border-bottom:1px solid black;'></span>").text("ID : " + data.user_id).appendTo(divFirst);
                  $("<label style='display: block; border-bottom: 1px solid;height: 40px;'>제목 : <input id='cm_title' type='text' style='width: 90%;height:100%;border: none; font-size: 23px;'></label>").appendTo(divFirst);
                  $("<textarea class='writeArea' id='writeArea'></textarea>").appendTo(divFirst);
                  CKEDITOR.replace("writeArea",{
                     filebrowserUploadUrl:'${path}/community/upload'
                  });
                  $("<button id='cancelBtn' style='background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>취소</button>").insertAfter(form);
                  $("<button id='insertBtn' style='margin: 0px 100px 0px 45%;background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>등록</button>").insertAfter(form);
                  
                  $('#cancelBtn').on('click', function() {
                     location.href='${path}/community/list'
                  });
                  
                  
                  $('#insertBtn').on('click', function() {
                     var title = $('#cm_title').val();
                     var text = CKEDITOR.instances.writeArea.getData();
                     
                     if(title == "" || text == ""){
                        swal({
                             title: "내용을 확인해주세요!",
                             icon: "warning",
                             button: "확인",
                             dangerMode: true,
                           });
                     }else {
                        $.ajax({
                           type:"POST",
                           url:"write",
                           data:{
                              title : title,
                              text : text,
                           },
                              
                           success:function(data) {
                               location.href="${path}/community/list"
                           },
                           error: function(error){
                              console.log("오류오류");
                           }
                        });
                     }
                  });
               },
            error: function(error){
               console.log("오류오류");
            }
         });
      });
   });
   
   function view(no){
      
      $.ajax({
         type:"GET",
         url:"view",
         data:{
            no:no,
         },
            
         success:function(data) {
            console.log(data)
            console.log(data.view);
            
            $('#listform').remove();
            $('#CM_Content1').remove();
            $('#searchArea').remove();
            
            var form = $("<form id='viewForm'></form>").insertAfter('.CM-index_section');
            var cm_mark = $("<a><i id='cm_mark' style='margin: 80px 0px 0px 510px; color: gold; font-size: 40px;' class='fas fa-star'></i><--찜하기click!</a>").appendTo(form);
            var cm_msg = $("<a><i id='cm_msg' style='margin-left: 40px; font-size: 37px; color: cornflowerblue; cursor:pointer;' class='far fa-envelope home_contents'></i><--Msg!</a>").appendTo(form);
            var divFirst = $("<div style='height: 600px; margin: 0px 400px 80px 500px; font-size: 23px; border: 1px solid; border-radius: 10px;'></div>").appendTo(form);
            
               $("<span style='display: block; float: left; padding: 0px 0px 0px 10px; font-weight: 900;'></span>").text("작성자 : " + data.view.user_name).appendTo(divFirst);
               $("<span style='display: block; text-align: end; border-bottom:1px solid black;'></span>").text("ID : " + data.view.user_id).appendTo(divFirst);
               $("<label style='display: block; border-bottom: 1px solid; height: 50px; text-align:center; padding-top: 6px; text-align: center; font-weight: 600;'>"+data.view.cm_title+"</label>").appendTo(divFirst);
               $("<div class='viewArea' id='viewArea' style='padding: 10px; overflow: scroll; height: 500px;'>"+data.view.cm_content+"</div>").appendTo(divFirst);
               
               if(data.loginMember.user_no == data.view.user_no){
                  $("<button id='deleteList' style='width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >삭제</button>").insertAfter(form);
                  $("<button id='returnList' style='width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >목록으로</button>").insertAfter(form);
                  $("<button id='updateList' style='margin: 0px 0px 0px 40%; width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >수정</button>").insertAfter(form);
               }else {
                  $("<button id='returnList' style='margin: 0px 0px 0px 48%; width: 150px; cursor: pointer; border:none; background:none; font-size:25px;' type='button' >목록으로</button>").insertAfter(form);
               }
               
            $('#cm_mark').on('click', function() {
               if(data.loginMember.user_no == data.view.user_no){
                  swal({
                     title:"본인입니다!",
                     icon: "warning",
                     button : true,
                     dangerMode: true,
                  });
               }else {
               if(data.view.cm_Mark == "Y"){
                  javaScript:cm_deleteMark(no, data.loginMember.user_no);
                  data.view.cm_Mark = "N";
                  swal("즐겨찾기 해제되었습니다.");
               }else {
                  javaScript:cm_bookMark(no, data.loginMember.user_no);
                  data.view.cm_Mark = "Y";
                  swal("즐겨찾기 추가되었습니다.")
                  .then((value) => {
                     swal({
                       title: "쪽지를 보내시겠습니까?",
                       icon: "info",
                       buttons: {
                          cancle : {
                             text : '취소',
                             value : false,
                             className : 'SwalCancelBtn'
                          },
                          confirm : {
                             text : '보내기',
                             value : true,
                             className : 'SwalGoMsgBtn'
                          }
                       }
                     });
                     
                     $('.SwalGoMsgBtn').on('click', function() {
                        javaScript:GoMsg(no, data.view.user_id, data.view.user_no);
                     })
                  });
               }
              }
            });
            
            $('#cm_msg').on('click', function() {
               if(data.loginMember.user_no == data.view.user_no){
                  swal({
                     title:"본인입니다!",
                     icon: "warning",
                     button : true,
                     dangerMode: true,
                  });
               }else {
                  javaScript:GoMsg(no, data.view.user_id, data.view.user_no);
               }
            });
            
            $('#returnList').on('click', function() {
               location.href="${path}/community/list"
            });
            
            $('#updateList').on('click', function() {
               swal({
                    title: "수정 하시겠습니까?",
                    icon: "warning",
                    buttons: {
                       cancle : {
                          text : '취소',
                          value : false,
                          className : 'SwalCancelBtn'
                       },
                       confirm : {
                          text : '수정',
                          value : true,
                          className : 'SwalUpdateBtn'
                       }
                    }
                  })
               $(document).ready(function () {
                  $('.SwalUpdateBtn').on('click',function() {
                     javaScript:updateBtn(no);
                  });
               });
            });
            
            $('#deleteList').on('click', function() {
               swal({
                    title: "삭제 하시겠습니까?",
                    icon: "warning",
                    buttons: {
                       cancle : {
                          text : '취소',
                          value : false,
                          className : 'SwalCancelBtn'
                       },
                       confirm : {
                          text : '삭제',
                          value : true,
                          className : 'SwalDeleteBtn'
                       }
                    },
                    dangerMode: true,
                  })
                  
               $(document).ready(function () {
                  $('.SwalDeleteBtn').on('click',function() {
                     javaScript:deleteBtn(no);
                  });
               });
            });
         },
         error: function(error){
            console.log("오류오류");
         }
      });
   }
   
   function updateBtn(no) {
      
      $.ajax({
         type:"GET",
         url:"updateView",
         data:{
            no:no,
         },
         
         success:function(data) {
            
            $('#listform').remove();
            $('#CM_Content1').remove();
            $('#viewForm').remove();
            $('#returnList').remove();
            $('#searchArea').remove();
            $('#updateList').remove();
            $('#deleteList').remove();
            
            var form = $("<form id='writeForm' action='/community/updateView' method='get' enctype='multipart/form-data'></form>").insertAfter('.CM-index_section');
               var divFirst = $("<div style='height: 600px; margin: 100px 400px 80px 500px; font-size: 23px; border: 1px solid; border-radius: 10px;'></div>").appendTo(form);
               $("<span style='display: block; float: left;'></span>").text("작성자 : " + data.member.user_name).appendTo(divFirst);
               $("<span style='display: block; text-align: end;'></span>").text("ID : " + data.member.user_id).appendTo(divFirst);
               $("<label style='display: block; border: 1px solid; border-radius: 10px;height: 50px;'>제목 : <input id='cm_title' type='text' value='"+data.view.cm_title+"' style='width: 90%;height:100%;border: none; font-size: 23px;'></label>").appendTo(divFirst);
               $("<textarea class='writeArea' id='writeArea'></textarea>").appendTo(divFirst);
                  CKEDITOR.replace("writeArea",{
                     filebrowserUploadUrl:'${path}/community/upload'
                  });
                  CKEDITOR.instances.writeArea.setData(data.view.cm_content);
               $("<button id='cancelBtn' style='background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>취소</button>").insertAfter(form);
               $("<button id='insertBtn' style='margin: 0px 100px 0px 45%;background: none;border-radius: 8px;width: 100px;height: 30px;font-size: 20px;'>등록</button>").insertAfter(form);
               
               $('#cancelBtn').on('click',function() {
                  location.href="${path}/community/list"
               });
               
               $('#insertBtn').on('click', function() {
                  var title = $('#cm_title').val();
                  var text = CKEDITOR.instances.writeArea.getData();
                  
                  if(title == "" || text == ""){
                     swal({
                          title: "내용을 확인해주세요!",
                          icon: "warning",
                          button: "확인",
                          dangerMode: true,
                        });
                  }else {
                     $.ajax({
                        type:"POST",
                        url:"update",
                        data:{
                           title : title,
                           text : text,
                           no: no,
                        },
                        success:function(data) {
                           location.href="${path}/community/list"
                        },
                        error: function(error){
                           console.log("오류오류");
                        }
                     });
                  }
               });
            },
         error: function(error){
            console.log("오류오류");
         }
      });
   }
   
   function deleteBtn(no) {
      $.ajax({
         type:"POST",
         url:"delete",
         data:{
            no: no,
         },
         success:function(data) {
            location.href="${path}/community/list"
         },
         error: function(error){
            console.log("오류오류");
         }
      });
   }
   
   function GoMsg(no,userId,userNo){
         document.querySelector(".modal").classList.remove("fade");
         document.getElementById("memSearchInput").value= userId;
         document.getElementById("msgTo").value= userNo;
     
       const close = () => {
         document.getElementById("memSearchInput").value= "";
         document.getElementById("msgContent").value= "";
         document.querySelector(".modal").classList.add("fade");
       }
       
//        document.querySelector(".SwalDeleteBtn").addEventListener("click", open);     
       document.querySelector(".closeBtn").addEventListener("click", close);
       
       
       $("#msgContent").on("keyup",function(){
           let inputLength = $(this).val().length;

           $("#writeCnt").text(inputLength);

           let remain = $("#writeMax").text() - inputLength;

           if(remain < 0){
             $("#writeCnt").css("color","red");
           } else {
             $("#writeCnt").css("color","black");
           }
      });
   }
   
   $(function(){
      $("#sendBtn").on("click",function(){
         let msgFrom = $("#msgFrom").val();
         let msgTo = $("#msgTo").val();
         let userName = $("#memSearchInput").val();
         let msgContent = $("#msgContent").val();
         let writeCnt = parseInt($("#writeCnt").text());
         let writeMax = parseInt($("#writeMax").text());
         
         if(userName == ""){
            Swal.fire({
                 icon: 'error',
                 text: '받는사람을 작성하지 않으셨습니다!',
                 didClose: () => {
                    $('#memSearchInput').focus();
                 }
               })
         } else if(msgContent == ""){
            Swal.fire({
                 icon: 'error',
                 text: '내용을 작성하지 않으셨습니다.!',
                 didClose: () => {
                    $('#msgContent').focus();
                 }
               })
         } else if(writeCnt > 300){
            Swal.fire({
                 icon: 'error',
                 text: writeMax + "자를 초과입력할 수 없습니다.!",
                 didClose: () => {
                    $('#msgContent').focus();
                 }
               })
         } else{
            $.ajax({
               type: "post",
               url:"${path}/community/Msgsend",
               data:{
                  msgFrom:msgFrom,
                  msgTo:msgTo,
                  msgContent:msgContent
               },
               success:function(data){
                  Swal.fire({
                            icon: 'success',
                            text: '쪽지를 성공적으로 전송하였습니다.'
                        });
                  
                  document.getElementById("memSearchInput").value= "";
                   document.getElementById("msgContent").value= "";
                  document.querySelector(".modal").classList.add("fade");
               },
               error: function(e){
                  alert("실패");
                  console.log(e);
               }
            });
         }
      });
   });
   
   function cm_bookMark(no, userNo){
      $.ajax({
         type:"post",
         url:"${path}/community/bookmark",
         data:{
            no:no,
            userNo:userNo,
         },
         success:function(){
            console.log("왔니?");
         },
         error: function(e){
            console.log("실패");
            console.log(e);
         }
      });
   }
   
   function cm_deleteMark(no, userNo){
      $.ajax({
         type:"post",
         url:"${path}/community/deleteMark",
         data:{
            no:no,
            userNo:userNo,
         },
         success:function(){
            
         },
         error: function(e){
            console.log("실패");
            console.log(e);
         }
      });
   }
   
   
   </script>



<%@ include file ="../common/footer.jsp" %>