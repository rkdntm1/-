<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
	<head>
		 <meta charset="UTF-8">
	     <meta name="viewport" content="width=device-width, initial-scale=1.0">
   		 <meta http-equiv="X-UA-Compatible" content="ie=edge">
	    <title>간단한 지도 표시하기</title>
	    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=c4yw03xtaw"></script>
	    
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
				<li><a href="/post/riderListOrder" class="active">라이더메인페이지</a></li>
				<sec:authorize access="isAnonymous()">
					<li><a href="/party/customLogin">로그인</a></li>
					<li><a href="/party/registerClassify">회원가입</a></li>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<li><a href="/party/customLogout">로그아웃</a></li>
				</sec:authorize>
			</ul>
		</nav>
		
		<section class="sec1">
			 <c:forEach items="${listRiderPriority}" var="riderId">
			 	<p><c:out value="${riderId}"/></p>
			</c:forEach>
		</section>									
										
		<section class="content">
			<h1>배달 경로</h1>
			<div id="map" style="width:100%;height:400px;">
			</div>
		</section>
		<section class="sec2"></section>
		<section class="sec3"></section>
	</body>
</html>
<script>

</script>
