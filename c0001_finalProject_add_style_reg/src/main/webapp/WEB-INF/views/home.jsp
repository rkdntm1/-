<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<nav>
			<div class="logo">
				<img src="/resources/img/노른자.png">
			</div>
			<ul>
				<li><a href="/" class="active">Home</a></li>
				<li><a href="#">미구현</a></li>
				<li><a href="#">미구현</a></li>
				<li><a href="#">미구현</a></li>
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
		<h1>검색 및 개인화서비스이용 해쉬태그 달기</h1>
		<p>해쉬태그를 사용한 검색시스템 구축과 로그인한 이용자가 가장 이용많이한 해쉬태그 추천</p>
		</section>
		<section class="sec2"></section>
		<section class="sec3"></section>
	</body>
</html>