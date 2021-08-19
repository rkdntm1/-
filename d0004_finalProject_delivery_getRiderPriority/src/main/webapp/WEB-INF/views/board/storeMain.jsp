<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="www.dream.com.delivery.model.DeliveryRequestVO"%>
<jsp:useBean id="tablePrinter" class="www.dream.com.framework.printer.TablePrinter"/>
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
		<nav>
			<div class="logo">
				<img src="/resources/img/노른자.png">
			</div>
			<ul>
				<li><a href="/post/readOrder" class="active">가게메인페이지</a></li>
				<sec:authorize access="isAnonymous()">
					<li><a href="/party/customLogin">로그인</a></li>
					<li><a href="/party/registerClassify">회원가입</a></li>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<li><a href="/party/customLogout">로그아웃</a></li>
				</sec:authorize>
			</ul>
		</nav>
		<section class="sec1"></section>
		<section class="content">
		<h1>주문 리스트</h1>
			<form id='frmRequest'>
				<div class="table-responsive">
				<table border="1">
					<thead>
						<tr><%=tablePrinter.printHeader(DeliveryRequestVO.class)%></tr>
					</thead>
					<tbody>
						<c:forEach items="${matchingRequest}" var="request">
							<tr>
								${tablePrinter.printTableRow(request, "anchor4post")}
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
				<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
			</form>
		</section>
		<section class="sec2">
		<input type='text' id='req'>
		</section>		
		<section class="sec3"></section>
	</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
	var csrFHN = "${_csrf.headerName}";
	var csrfTV = "${_csrf.token}";
	
	$(document).ajaxSend(
		function(e, xhr) {
			xhr.setRequestHeader(csrFHN, csrfTV);
		}
	);
	
	var req = '<c:out value="${req}" />';
	$("#req").val(req);
	
	var frmRequest = $('#frmRequest');
	
	/* 특정 게시물에 대한 상세 조회 처리 */
	$('.anchor4post').on('click', function(e) {
		e.preventDefault();
		var orderId = $(this).attr('href');
		frmRequest.append("<input name='orderId' type='hidden' value='" + orderId + "'>");
		frmRequest.attr('action', '/delivery/readOrder');
		frmRequest.attr('method', 'get');
		frmRequest.submit();
		/*$.ajax({	
		    url: '/delivery/registerRequest',
		    type: 'post',
		    dataType: 'json', //서버로부터 내가 받는 데이터의 타입
		    contentType : 'application/json',//내가 서버로 보내는 데이터의 타입
		    data: JSON.stringify(requestId),
		    success: function(result){
		    	console.log("아작스성공")
		    },
		    error: function (){		    	
		    }
		});*/
		
	});
});
</script>