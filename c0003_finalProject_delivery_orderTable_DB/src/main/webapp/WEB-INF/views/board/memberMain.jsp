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
		<nav>
			<div class="logo">
				<img src="/resources/img/노른자.png">
			</div>
			<ul>
				<sec:authorize access="isAnonymous()">
					<li><a href="/party/customLogin">로그인</a></li>
					<li><a href="/party/registerClassify">회원가입</a></li>
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<input id="member_addr" class="form-control" value="" type="text" placeholder="너의 위치를 적어라" readonly onclick="findAddr()"> 
					<input id="member_post" type="hidden"  readonly >
					
					<input type="hidden" id="loc" name="location" value="" readonly>
					<li><a href="/post/memberMain" class="active">유저메인페이지</a></li>
					<li><a href="/party/customLogout">로그아웃</a></li>
				</sec:authorize>
			</ul>
		</nav>
		
		<section class="sec1">
			
		</section>
		
		<section class="content">
			<h1>개인화 서비스</h1>
			<form id='frmSearching' action='/post/listBySearch' method='get'>
				<input type="text" name="searching" value='${pagenation.searching}'>
				<button id="btnSearch" class='btn btn-default'>검색</button>
				
				<c:forEach items="${categoryList}" var="cartegory">
					<a href="/post/listBySearch?boardId=${cartegory.id}">${cartegory.name}</a>
					&emsp;
				</c:forEach>
								
				<input type="hidden" name='boardId' value='${boardId}'>
				<input type="hidden" name='pageNumber' value='${pagenation.pageNumber}'>
				<input type="hidden" name='amount' value='${pagenation.amount}'>
			</form>
			
		</section>
		
		<section class="sec2">
			<form action="/board/storeMain" method="get">
				<label>상품명<input type="text" name="pdtName"></label>
				<label>개수<input type="text" name="pdtCnt"></label>
				<label>가격<input type="text" name="pdtPrice"></label>
				<button type="submit">눌러</button>
			</form>
		</section>
		
		<section class="sec3">
		</section>
	</body>
</html>

<script>
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
            }
        }
    }).open();
}	
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>