<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<html>
	<head>
		<title>메인페이지</title>
		<script	src="https://code.jquery.com/jquery-3.6.0.js"></script>
	</head>
	<body>
		<c:forEach items="${requestList}" var="request">
			<tr>
				${request}				
			</tr>
		</c:forEach>
	</body>
</html>