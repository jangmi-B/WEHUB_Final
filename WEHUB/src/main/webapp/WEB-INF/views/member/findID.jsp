<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="${path}/js/jquery-3.5.1.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Document</title>
    <link rel="stylesheet" href="${path}/css/FindID.css">
</head>

<body>
	<div class="wrapper">
        <div id="title">
            <h1>Forgot your ID?</h1>
        </div>
        <div class="container">
            <form class="form" action="${path}/member/findID" method="post">
                <input type="text" name="user_name"  placeholder="User Name ">
                <input type="email"name="email" placeholder="E-mail">
                <input type="tel"name="phone" placeholder="-를 무조건 포함해주세요" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" title="형식 010-0000-0000">
            <!--    <input type="tel" name="phone" placeholder="Phone -를 무조건 포함해주세요"> -->
                <button type="submit" id="login-button" >Find</button>
            </form>
        </div>
    </div>
</body>
<!--  <script>
	 	$(document).on("keyup",  "phone", function() { 
	
		$(this).val( $(this).val()
				.replace(/[^0-9]/g, "")
				.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3")
				.replace("--", "-") 
					); 
	});	
  </script> -->
</html>