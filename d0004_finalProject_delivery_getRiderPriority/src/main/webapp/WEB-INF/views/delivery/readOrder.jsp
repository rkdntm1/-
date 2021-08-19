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
		<h1>들어온 주문에 배달팁, 조리예상시간을 넣어서 요청 만들기 </h1>
		<form id="frmRequest" action="/delivery/registerRequest" method="post">
			<div>
			<label>주문번호: </label><input type="text" name="id" value="${order.id}" readonly>
			</div>
			<div>
			<label>가게id: </label><input type="text" name="storeId" value="${order.storeId}" readonly>
			</div>					
			<div>
			<label>주문자id: </label><input type="text" name="memberId" value="${order.memberId}" readonly>
			</div>
			<div>
			<label>물품: </label><input type="text" name="orderContents" value="${order.orderContents}" readonly>
			</div>
			<div>
			<label>도착주소: </label><input type="text" id="endAddr" name="endAddr" value="${order.endAddr}" readonly>
			</div>
			<div>
			<label>배달팁: </label><input type="text" name="deliveryTip">
			</div>
			<div>
			<label>조리완료예상시간: </label><input type="text" name="cookedTime">
			</div>						
			<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
			<button id="btnSubmit" type="submit" class="btn btn-secondary"> 완료</button>
		</form>
	</body>
	
	<script type="text/javascript">
$(document).ready(function(){
	var csrFHN = "${_csrf.headerName}";
	var csrfTV = "${_csrf.token}";
	
	var frmRequest = $('#frmRequest');
	
	$(document).ajaxSend(
		function(e, xhr) {
			xhr.setRequestHeader(csrFHN, csrfTV);
		}
	);
	
	$('#btnSubmit').on('click', function(eInfo) {
		var requestId = '${order.id}';
		console.log(requestId);
		frmRequest.submit();
		
		$.ajax({	
		    url: '/matching/' + requestId,
		    type: 'post',
		    dataType: 'json', //서버로부터 내가 받는 데이터의 타입
		    contentType : 'application/json',//내가 서버로 보내는 데이터의 타입
		    data: JSON.stringify(requestId),
		    success: function(result){
		    	console.log("아작스성공")
		    },
		    error: function (){		    	
		    }
		});
		
	});
});
</script>
</html>