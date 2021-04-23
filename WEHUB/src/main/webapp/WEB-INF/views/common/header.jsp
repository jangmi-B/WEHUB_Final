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
  <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="https://kit.fontawesome.com/d854b17d02.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="icon" type="image/png" href="${path}/images/logo.png">
  <link rel="stylesheet" href="${path}/css/style.css">
  <link rel="stylesheet" href="${path}/css/homeContent.css">
  <link rel="stylesheet" href="${path}/css/HumanManagement_green.css">
  <link rel="stylesheet" href="${path}/css/board_notice.css">
  <link rel="stylesheet" href="${path}/css/board_notice_list.css">
  <link rel="stylesheet" href="${path}/css/board_notice_detail.css">
  <link rel="stylesheet" href="${path}/css/modal.css">
  <link rel="stylesheet" href="${path}/css/community.css">
  <link rel="stylesheet" href="${path}/css/message_list.css">
  <link rel="stylesheet" href="${path}/css/project_list.css">
  <title>WEHUB</title>
</head>
<body>
	  <nav id="navbar">
    <div class="header_logo">
      <a href="${path}/main"><img src="${path}/images/logo.png"></a>
    </div>
    <div class="header_user_wrap">
      <div class="header_profile">
      	<c:choose>
      		<c:when test="${ loginMember.user_imgRename == null }">
            	<img alt="x" src="${path}/upload/userProfileImg/noUserImg.png" style="width: 35px; height:35px; border-radius: 30px; object-fit: cover;">
            </c:when>
            <c:otherwise>
		        <img alt="x" src="${path}/upload/userProfileImg/${loginMember.user_imgRename}" style="width: 35px; height:35px; border-radius: 30px; object-fit: cover;">
            </c:otherwise>
      	</c:choose>
      </div>
      <div class="header_userInfo">
        <ul id="header_user">
          <li><a href="#">${ loginMember.user_name } ${ loginMember.rank } </a>
            <ul>
              <li><a onclick="location.replace('${path}/logout')">Logout</a></li>
              <li><a href="${path}/member/memModify">MyPage</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <section>
    <div class="common_section">
      <ul>

        <li><a href="${path}/main"><i class="fas fa-home home_contents"></i></a></li>
        <li><a href="${path}/notice/list"><i class="fas fa-bullhorn home_contents"></i></a></li>
        <c:if test="${unreadCheck == 0 || unreadCheck == null}">
	        <li><a href="${path}/message/list"><i class="far fa-envelope home_contents"></i></a></li>
        </c:if>
        <c:if test="${unreadCheck != 0 && unreadCheck != null}">
	        <li><a href="${path}/message/list" style="color:#a484f3;"><i class="far fa-envelope home_contents"></i></a></li>
        </c:if>
        <li><a href="${path}/memberInfo/list"><i class="fas fa-users home_contents"></i></a></li>
        <li><a href="${path}/calendar/view"><i class="far fa-calendar-alt home_contents"></i></a></li>
        <li><a href="${path}/project/list"><i class="fas fa-project-diagram"></i></a></li>
        <li><a href="${path}/community/list"><i class="fas fa-shopping-cart home_contents"></i></a></li>
		<li><a href="${path}/approval/approvalMain"><i class="far fa-file-alt"></i></a></li>
      </ul>
    </div>