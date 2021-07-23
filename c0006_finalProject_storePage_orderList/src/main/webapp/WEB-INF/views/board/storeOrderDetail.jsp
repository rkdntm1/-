<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
	<head>
		<title>메인페이지</title>
		<link href="/resources/css/mainStyle.css" rel="stylesheet" type="text/css">
		<script	src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<script type="text/javascript">
			$(window).on('scroll', function() {
				if($(window).scrollTop()){
					$('nav').addClass('black');
				}
				else {
					$('nav').removeClass('black');
				}
			})
		</script>		
	</head>
	<body>
	
				<form action="/delivery/registerRequest" method="get">
					<input type="text" name="id" value="${order.id}">
					<input type="text" name="storeId" value="${order.storeId}">
					<input type="text" name="memberId" value="${order.memberId}">
					<input type="text" name="msg" value="${order.msg}">
					<button type="submit" class="btn btn-secondary"> 수락</button>
				</form>
						
	</body>
</html>