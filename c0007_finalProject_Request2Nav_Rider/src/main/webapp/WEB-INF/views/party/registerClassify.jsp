<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 유형을 선택하시오</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/resources/css/classifyStyle.css">
</head>
<body>
	<div class="container">
		<div class="card">
			<div class="content">
				<h2>01</h2>
				<h3>요식업자</h3>
				<p>미식인들이여 모여라 둘이먹다 한명 죽어도 모를 맛을 보여주지</p>
				<button data-oper='storeRegist' class="btn btn-primary">가게회원가입 바로가기</button>
			</div>
		</div>
		<div class="card">
			<div class="content">
				<h2>02</h2>
				<h3>라이더</h3>
				<p>음식점과 매칭되어 한치의 오차만 허락하는 신속한 배달의 달인</p>
				<button data-oper='riderRegist' class="btn btn-primary">라이더회원가입 바로가기</button>
			</div>
		</div>
		<div class="card">
			<div class="content">
				<h2>03</h2>
				<h3>미식인</h3>
				<p>맛있는 음식을 다양한 카테고리와 해쉬태그통해 즐길 수 있는 미식가들</p>
				<button data-oper='genenalRegist' class="btn btn-primary">일반회원가입 바로가기</button>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/resources/js/vanilla-tilt.js"></script>
	<script>
		VanillaTilt.init(document.querySelectorAll(".card"), {
		max: 25,
		speed: 400,
		glare: true,
		"max-glare": 1,
	});
	</script>
	<form id='frmClassify' action="/party/joinMember" method="get">
		<input type="hidden" id="classifyName" name="partyDescrim" value="">
	</form>
</body>
</html>

<script>
$(document).ready(function() {
	$("button[data-oper='storeRegist']").on("click", function() {
		$("#frmClassify").find("#classifyName").val("Store");
		$("#frmClassify").submit();
	});

	$("button[data-oper='riderRegist']").on("click", function() {
		$("#frmClassify").find("#classifyName").val("Rider");
		$("#frmClassify").submit();
	});
	
	$("button[data-oper='genenalRegist']").on("click", function() {
		$("#frmClassify").find("#classifyName").val("Member");
		$("#frmClassify").submit();
	});
	
});
</script>