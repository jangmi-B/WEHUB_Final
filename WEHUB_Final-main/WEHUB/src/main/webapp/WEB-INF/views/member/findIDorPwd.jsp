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
    <title>Document</title>
    <link rel="stylesheet" href="${path}/css/FindIDorPwd.css">
</head>
<body>
 <div class="wrapper">
        <div class="container">
            <form class="form" action="${path}/member/findIDorPwd" method="post">

             <button type="button" onclick="location.href='${path}/member/findID'"  id="login-button">Find ID</button>
     		<button type="button" onclick="location.href='${path}/member/findPwd'"  id="login-button">Find PWD</button>

            </form>
        </div>
    </div>
</body>
</html>