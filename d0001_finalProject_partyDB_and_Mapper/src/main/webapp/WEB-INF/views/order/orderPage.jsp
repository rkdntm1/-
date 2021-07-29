
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<html>
	<head>
		<title>주문페이지</title>
		<script	src="https://code.jquery.com/jquery-3.6.0.js"></script>
	</head>
	<body>
		<form action="/order/orderPage" method="post">
			<div class="inputBox">
				<label>상품명</label>
			    <input name="pdtName">
			</div>
			<div class="inputBox">
				<label>상품개수</label>
			    <input name="pdtCnt">
			</div>
			<div class="inputBox">
				<label>상품가격</label>
			    <input name="pdtPrice">
			</div>		
			<div class="inputBox">
				<label>요구메시지</label>
			    <input name="msg" placeholder="주문요청사항을 입력해주세요" >
			</div>
			<button type="submit">주문완료</button>
			<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
			<input type="hidden" name="userId" value="${memberId}">
		</form>
	</body>
</html>