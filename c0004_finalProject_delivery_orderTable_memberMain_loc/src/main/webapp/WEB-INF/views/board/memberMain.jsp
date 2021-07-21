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
					<input id="OpenMemberAddrModal" value="" type="text" placeholder="너의 위치를 적어라" readonly>
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
				
				<input type="hidden" name='memberId' value=''>
				<input type="hidden" name='longitude' value=''>
				<input type="hidden" name='latitude' value=''>
				<input type="hidden" name='detailAddress' value=''>					
				<input type="hidden" name='boardId' value='${boardId}'>
				<input type="hidden" name='pageNumber' value='${pagenation.pageNumber}'>
				<input type="hidden" name='amount' value='${pagenation.amount}'>
			</form>
			
		</section>
		
		<section class="sec2">
			<form action=""></form>		
		</section>
		
		<section class="sec3">
		</section>
		
		<!-- Modal -->
		<!-- 모달 안에서 상세주소까지 입력한 후 주소를 경도, 위도 값으로 바꿔서 LocationDB에 넣어주고
			 주소와 상세주소는 스트링으로 주문요청서에 넣어준다.
		 -->
		<div class="modal fade" id="modalMemberAddr" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">지번,도로명,건물명을 입력하세요.</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<input id="member_addr" name="Addr"class="form-control" value="" type="text" placeholder="예) 딜리셔링동 123-4 또는 딜리셔링빌라" readonly onclick="findAddr()">
						현 위치로 주소 설정
						<input id="detail_addr" name="detailAddr" class="form-control" value="" type="text" placeholder="상세주소를 입력하세요.">
						<input id="memberId" name ="member" value="${member.id}" type="hidden" readonly >
					</div>
					<div class="modal-footer">
						<button id='btnRegisterAddr' type="button" class="btn btn-primary">확인</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
	</body>
</html>
<script>
<sec:authentication property="principal" var="customUser"/>
	<sec:authorize access="isAuthenticated()">
		curUserName = "${customUser.curUser.name}";
		curUserId = "${customUser.curUser.userId}";
	</sec:authorize>
	
//모달관련 함수
var modalMemberAddr = $("#modalMemberAddr");
var longitude = null;
var latitude = null;

$("#OpenMemberAddrModal").on("click", function(e) {
	
	modalMemberAddr.find("input[name='member']").val(curUserId);
	showModalForCreate();
});

function showModalForCreate() {
	//모달에 들어 있는 모든 내용 청소
	modalMemberAddr.find(".form-control").val("");

	$("#modalMemberAddr").modal("show");
}

$("#btnRegisterAddr").on("click", function(e) {
	var addr = modalMemberAddr.find("#member_addr").val() 
	var detailAddr = addr + modalMemberAddr.find("#detail_addr").val() // addr + 상세주소를 String으로 저장
	locationTransfer(addr); //주소를 경도 위도 변환해서 DB에 넣어준다.
	$("input[name='detailAddress']").val(detailAddr);
	
	
	console.log($("input[name='detailAddress']").val(detailAddr),$("input[name='longitude']").val(longitude),$("input[name='latitude']").val(latitude))
	
/* 	locationService.addLocation(
		modalMemberAddr.find("#memberId").val(),
		longitude, 	//경도
		latitude,  	//위도
		detailAddr,	//주소
		function() {
			modalMemberAddr.find("input").val("");	//들어 있는 값 청소
			modalMemberAddr.modal("hide");
		},
		function(errMsg) {
			alert("주소 등록 오류 : " + errMsg);
		}
	); */
});

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
                document.getElementById("OpenMemberAddrModal").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
                document.getElementById("OpenMemberAddrModal").value = jibunAddr;
            }
        }
    }).open();
}

function locationTransfer(addr) {
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();	

	//주소로 좌표를 검색합니다
	geocoder.addressSearch(addr, function(result, status) {

	// 정상적으로 검색이 완료됐으면 
	 if (status === kakao.maps.services.Status.OK) {

	  var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	  $("input[name='longitude']").val(result[0].x);
	  $("input[name='latitude']").val(result[0].y);
	}	
 });
}
</script>
<link href="/resources/css/sb-admin-2.css" rel="stylesheet">
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	fc84bb357e689489432517c4afd4cbda&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>