<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../common/header.jsp" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="${path}/css/approvalStyle.css">
<script src="${path}/js/jquery-3.5.1.js"></script>

<section>
    <div class="EPay-index_section">
        <h2>전자결재</h2>
        <li class="EPay-form">양식작성
            <div>
                <ul>
                    <li><a href="">-품의서</a></li>
                    <li><a href="">-지출결의서</a></li>
                    <li><a href="">-휴가신청서</a></li>
                </ul>
            </div>
        </li>
        <li class="EPay-list">
            결재리스트
            <div>
            <ul>
                <li><a href="">-개인별</a></li>
                <li><a href="">-부서별</a></li>
                <li><a href="">-전체</a></li>
            </ul>
            </div>
        </li>
        <li>보관함
            <ul>
                <li><a href="">품의서</a></li>
                <li><a href="">지출결의서</a></li>
                <li><a href="">휴가신청서</a></li>
            </ul>
        </li>
    </div>
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
                    <td colspan="8" style="height: 70px;">
                        <button class="send-open">수신참조자+</button>
                    </td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">성 명</td>
                    <td><input type="text" name="" id=""  ></td>
                    <td style="width: 80px;">부 서</td>
                    <td><input type="text"  ></td>
                    <td style="width: 80px;">직 급</td>
                    <td colspan="3"><input type="text"  ></td>
                </tr>
                <tr>
                    <td style="height: 70px; width: 80px;">제 목</td>
                    <td colspan="8"><input type="text"  ></td>
                </tr>
                <tr>
                    <td colspan="8" style="height: 90px;" >
                        <button>파일첨부+</button>
                        파일이름.img
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="height: 70px; width: 80px;">품의사유 및 상세내용</td>
                </tr>
                <tr>
                    <td colspan="8">
                        <textarea name="" id="" cols="151px" rows="11px" style="width: 100%; height: 100%; border: none; resize: none; overflow: hidden; font-size: 25px;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: center; height: 100px; border-bottom: none;">위와 같이 휴가를 신청하오니 허락하여 주시기 바랍니다.</td>
                </tr>
                <tr style="border: white;">
                    <td colspan="8" style="text-align: center; height: 100px;">
                        20 <input type="text" style="border: none; width: 40px; font-size: 20px;">년
                        <input type="text" style="border: none; width: 40px; font-size: 20px;">월
                        <input type="text" style="border: none; width: 40px; font-size: 20px;">일
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align: right; height: 100px; padding-right: 50px;">
                        신청자 : <input type="text" style=" width:200px; border: none; text-align: center;" maxlength="4">
                        (인)
                    </td>
                </tr>
            </table>
        </div>
        <div id="button">
        <button>등록</button>
        <input type="text" style="border: none; width: 40px;" disabled>
        <button>취소</button>
        </div>
    </div>

    <!-- modal section -->
    <div class="modal hidden">
        <div class="bg"></div>
        <div class="modalBox">
            <div style="margin: 40px 0px 0px 60px;">
                <input type="text" style="width: 250px; height: 30px; border-radius: 10px; font-size: 20px; text-align: center;" maxlength="4" >
                <button>검색</button>
            </div>
            <div style=" border: 1px solid black; width: 280px; height: 440px; margin: 60px 0px 0px 60px; float: left; text-align: center;">
                <table id="refer-left-section" style="width: 100%; border-bottom: 1px solid black; border-collapse: collapse;">
                    <tr style="border-bottom: 1px solid black;">
                        <th>
                            <input type="checkbox" name="check-refer-listAll" id="refer-listAll" style="height: 15px; margin-top: 6px;">
                        </th>
                        <th>이 름</th>
                        <th>부 서</th>
                        <th>직 책</th>
                    </tr>
                    <tr>
                        <td>
                            <input type="checkbox" name="refer-list" id="refer-list" style="height: 15px;">
                        </td>
                        <td>홍길동</td>
                        <td>개발1팀</td>
                        <td>사원</td>
                    </tr>
                    <tr>
                        <td>
                            <input type="checkbox" name="refer-list" id="refer-list" style="height: 15px;">
                        </td>
                        <td>아무개</td>
                        <td>개발1팀</td>
                        <td>사원</td>
                    </tr>
                </table>
            </div>
            <div>
                <button class="refer-insert" style="margin: 200px 0px 0px 27px; float: left; position: absolute;"> -> </button>
                <button class="refer-delete" style="margin: 300px 0px 0px 27px; float: left;"> <- </button>
            </div>
            <div style=" border: 1px solid black; width: 280px; height: 440px; margin: 60px 0px 0px 440px; text-align: center;">
                <table id="refer-right-section" style=" width: 100%; border-bottom: 1px solid black; border-collapse: collapse;" >
                    <tr style="border-bottom: 1px solid black;">
                        <th>
                            <input type="checkbox" name="D-refer-listAll" style="height: 15px; margin-top: 6px;">
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
                    <button class="closeBtn-in">추가</button>
                </span>
                <button class="closeBtn-out">닫기</button>
            </div>
        </div>
    </div>

<script>
    $(document).ready(function () {
        $('.EPay-form').on('click', function() {
            $('.EPay-form > div').slideToggle();
        });
    });
    $(document).ready(function () {
        $('.EPay-list').on('click', function() {
            $('.EPay-list > div').slideToggle();
        });
    });
    // modal 창 띄우기
    const open = () => {
    document.querySelector(".modal").classList.remove("hidden");
    }
    const close = () => {
        document.querySelector(".modal").classList.add("hidden");
    }
    document.querySelector(".send-open").addEventListener("click", open);
    document.querySelector(".closeBtn-out").addEventListener("click", close);
    document.querySelector(".bg").addEventListener("click", close);
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
    $(document).ready(function() {
        $('.refer-insert').click(function() {
            var rowData = new Array();
            var tdArr = new Array();
            var checkbox = $("input[name=refer-list]:checked");
            
            checkbox.each(function(i) {
   
            // checkbox.parent() : checkbox의 부모는 <td>이다.
            // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
            var tr = checkbox.parent().parent().eq(i);
            var td = tr.children();
            
            // 체크된 row의 모든 값을 배열에 담는다.
            rowData.push(tr.text());
            
            // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
            var name = td.eq(1).text();
            var dept = td.eq(2).text();
            var position = td.eq(3).text();
            
            // 가져온 값을 배열에 담는다.
            tdArr.push(name);
            tdArr.push(dept);
            tdArr.push(position);
            console.log(name);
            console.log(tdArr);
            $('#refer-right-section > tbody:last').append('<tr><td><input type="checkbox" name="D-refer-listAll" style="height: 15px; margin-top: 6px;"></td>'
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
</script>

<%@ include file="../common/footer.jsp" %>