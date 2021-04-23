<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<title>Insert title here</title>
</head>
<body>
	<script>
		//alert('${msg}');
		swal.fire({
				text:'${msg}',
				confirmButtonText: '확인',	
		  }).then((result) => {
		    	//확인을 눌렀을 때 수행할 일
		    	location.replace('${pageContext.request.contextPath}${location}');	
		      })

	</script>
</body>
</html>