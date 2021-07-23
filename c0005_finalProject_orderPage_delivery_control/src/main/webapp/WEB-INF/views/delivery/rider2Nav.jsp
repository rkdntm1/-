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
		<form id="frmPost" method="get" action="/delivery/updateRequest">
			<c:forEach items="${requestList}" var="reqlist" varStatus="status">
				<tr>
				<input id="request${status.index}" type="submit" value="${reqlist}" readonly></br>
				</tr>
			</c:forEach>
		</form>
			<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
	</body>
</html>