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
    <script src="js/jquery-3.5.1.js"></script>
    <title>Document</title>
    <link rel="stylesheet" href="${path}/css/FindPwd.css">
</head>
<body>
    <div class="wrapper">
        <div id="title">
            <h1><a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/LogInForm.html">Forgot your Password?</a></h1>
        </div>
        <div class="container">
            <form class="form" action="${path}/member/findPwd" method="post">
                <input type="text" id="user_id"name="user_id"placeholder="User ID ">
                <input type="email"id="email" name="email"placeholder="E-mail">

                <button type="submit" id="login-button">Find</button>
            </form>
        </div>
    </div>
</body>
<script>

	$("#login-button").click(function(){
		$.ajax({
			url : "member/findPwd",
			type : "POST",
			data : {
				user_id : $("#user_id").val(),
				email : $("#email").val()
			},
			success : function(result) {
				alert(result);

			},
		})
	});
    
    
</script>
</html>