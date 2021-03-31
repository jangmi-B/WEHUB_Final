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
  <script src="${path}/js/jquery-3.5.1.js"></script>
  <script src="https://kit.fontawesome.com/d854b17d02.js" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
  <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
  <link rel="icon" type="image/png" href="${path}/images/logo.png">
  <link rel="stylesheet" href="${path}/css/style.css">
  <link rel="stylesheet" href="${path}/css/homeContent.css">
  <link rel="stylesheet" href="${path}/css/HumanManagement_green.css">
  <link rel="stylesheet" href="${path}/css/board_notice.css">
  <link rel="stylesheet" href="${path}/css/board_notice_list.css">
  <link rel="stylesheet" href="${path}/css/board_notice_detail.css">
  <link rel="stylesheet" href="${path}/css/modal.css">
  <link rel="stylesheet" href="${path}/css/message_list.css">
  <title>WEHUB</title>
</head>
<body>
	  <nav id="navbar">
    <div class="header_logo">
      <a href="${path}/home"><img src="${path}/images/logo.png"></a>
    </div>
    <div class="header_user_wrap">
      <div class="header_profile">
        <i class="far fa-user-circle"></i>
      </div>
      <div class="header_userInfo">
        <ul id="header_user">
          <li><a href="#">${ loginMember.user_name } ${ loginMember.rank }</a>
            <ul>
              <li><a href="#">Logout</a></li>
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
        <li><a href="${path}/home"><i class="fas fa-home home_contents active"></i></a></li>
        <li><a href="${path}/notice/list"><i class="fas fa-bullhorn home_contents"></i></a></li>
        <li><a href="${path}/memberInfo/list"><i class="far fa-address-card home_contents" ></i></a></li>
        <li><a href="${path}/message/list"><i class="far fa-envelope home_contents"></i></a></li>
        <li><a href="#"><i class="fas fa-users home_contents"></i></a></li>
        <li><a href="#"><i class="far fa-calendar-alt home_contents"></i></a></li>
      </ul>
    </div>

