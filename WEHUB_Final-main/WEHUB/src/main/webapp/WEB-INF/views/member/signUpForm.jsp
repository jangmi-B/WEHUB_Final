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
    <script src="${path}/js/jquery-3.5.1.js"></script>
    <title>Document</title>
    <link rel="stylesheet" href="${path}/css/FindPwd.css">
</head>
<body>
    <div class="wrapper">
        <div class="container">
            <div id="title">
                <h1><a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/LogInForm.html">Create an account</a></h1>
		        <h2><a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/LogInForm.html">Welcome</a></h2>
            </div>
            
            <form class="form" action="${path}/member/signUpForm" method="post" style="margin-top: -187px;">

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
            </form>
            <form class="form1">    
                <button type="submit" id="login-button">Create</button>
                <p id="findPwdAndSignUp">
                    <a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/LogInForm.html" id="fpas">Already have an account?</a>
                </p>
            </form>
        </div>
    </div>
</body>
<script>
    $("#login-button").click(function(event){
		event.preventDefault();
	
	    $('form').fadeOut(500);
	    $('.wrapper').addClass('form-success');

        setTimeout(function() {
        // alert("회원가입이 정상적으로 완료되었습니다.");
        location.href="${path}/";
    }, 3000);
    });
</script>
</html>