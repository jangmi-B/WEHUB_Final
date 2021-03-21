<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://kit.fontawesome.com/d854b17d02.js" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="${path}/css/style.css">
  <link rel="stylesheet" href="${path}/css/homeContent.css">
  <title>WEHUB</title>
</head>
<body>
	  <nav id="navbar">
    <div class="header_logo">
      <a href="header.html"><img src="${path}/images/logo.png"></a>
    </div>
    <div class="header_user_wrap">
      <div class="header_profile">
        <i class="far fa-user-circle"></i>
      </div>
      <div class="header_userInfo">
        <ul id="header_user">
          <li><a href="#">홍길동 사원</a>
            <ul>
            <!--   <li><a href="#">Logout</a></li> -->
            <li><a onclick="location.replace('${path}/logout')">로그아웃</a></li>
              <li><a href="#">MyPage</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <section>
    <div class="common_section">
      <ul>
        <li><a href="#"><i class="fas fa-home" ></i></a></li>
        <li><a href="#"><i class="fas fa-bullhorn"></i></a></li>
        <li><a href="#"><i class="far fa-address-card" ></i></a></li>
        <li><a href="#"><i class="far fa-envelope"></i></a></li>
        <li><a href="#"><i class="fas fa-users"></i></a></li>
        <li><a href="#"><i class="far fa-calendar-alt"></i></a></li>
      </ul>
    </div>
