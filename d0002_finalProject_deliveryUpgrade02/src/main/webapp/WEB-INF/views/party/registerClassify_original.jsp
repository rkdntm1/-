<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 유형을 선택하시오</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<button data-oper='storeRegist' class="btn btn-primary">가게회원</button>
	<button data-oper='riderRegist' class="btn btn-primary">라이더회원</button>
	<button data-oper='genenalRegist' class="btn btn-primary">일반회원</button>
	
	<form id='frmClassify' action="/party/joinMember" method="get">
		<input type="hidden" id="classifyName" name="classifyName" value="">
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