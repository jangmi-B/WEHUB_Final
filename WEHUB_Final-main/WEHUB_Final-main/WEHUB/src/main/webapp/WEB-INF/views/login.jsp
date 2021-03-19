<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${path}/js/jquery-3.5.1.js "></script>
 <link rel="stylesheet" href="css/LogInForm.css">
<title>LogInForm</title>
</head>
<body>
<c:if test="${ loginMember == null }">
<div class="wrapper">

        <div class="container">
            <img src="resources/images/wehub(white).png"/>
            <form class="form">
                <input type="text" placeholder="Username ">
                <input type="password" placeholder="Password">
                <button type="submit" id="login-button">Log in</button>
                <p id="findPwdAndSignUp">
                    <a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/FindIDorPwd.html" id="fpas1">Forgot ID / Password?</a><a href="file:///C:/Users/User/Desktop/Coding/FinalProjectHTML/BeforeSignUp.html" id="fpas2">Sign Up</a>
                </p>
            </form>
        </div>
    </div></c:if>
    <c:if test="${ loginMember != null }">
	
	<a href="${path}/home"></a>



</c:if>
</body>
<script>
     $("#login-button").click(function(event){
		event.preventDefault();
	 
	    $('form').fadeOut(500);
	    $('.wrapper').addClass('form-success');

        setTimeout(function() {
        location.href="file:///C:/Users/User/Desktop/common_header_footer/header.html";
        }, 2800);

     });

    //  $("#fpas1").click(function() {

    //     alert();
    //  })
</script>
</body>
</html>