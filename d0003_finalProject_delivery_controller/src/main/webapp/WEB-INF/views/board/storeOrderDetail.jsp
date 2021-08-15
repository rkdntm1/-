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
		<h1>임의의 요청정보 만들기</h1>
		<form id="frmRequest" action="/delivery/registerRequest" method="post">
			<div>
			<label>가게id: </label><input type="text" name="storeId" value="${storeId}" readonly>
			</div>					
			<div>
			<label>주문자id: </label><input type="text" name="memberId">
			</div>
			<div>
			<label>물품: </label><input type="text" name="orderContents" >
			</div>
			<div>
			<label>도착주소: </label><input type="text" id="endAddr" name="endAddr" placeholder="도착주소지클릭" onclick="findAddr()" readonly>
			</div>
			<div>
			<label>도착위도: </label><input type="text" id="endLat" name="endLat" readonly>
			</div>
			<div>
			<label>도착경도: </label><input type="text" id="endLng" name="endLng" readonly>
			</div>			
			<div>
			<label>배달팁: </label><input type="text" name="deliveryTip">
			</div>
			<div>
			<label>조리완료예정시간: </label><input type="text" name="cookedTime">
			</div>
			<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
			<button id="btnSubmit" type="submit" class="btn btn-secondary"> 완료</button>
		</form>
	</body>
	
	<!-- api -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	fc84bb357e689489432517c4afd4cbda&libraries=services"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script type="text/javascript">
$(document).ready(function(){
	var csrFHN = "${_csrf.headerName}";
	var csrfTV = "${_csrf.token}";
	
	$(document).ajaxSend(
		function(e, xhr) {
			xhr.setRequestHeader(csrFHN, csrfTV);
		}
	);
	
	$('#btnSubmit').on('click', function(eInfo) {
		var request= {
				
		}
		
		$.ajax({	
		    url: '/delivery/matchingRequest',
		    type: 'post',
		    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
		    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
		    data: newBieId,
		    success: function(result){
		    	if(result == "0"){ //중복 아이디 없을 경우
			         console.log("아이디 없음");
			         console.log(result);
			         $("#userPwdOrgin").focus();
			         idCheck.html("아이디 체크완료");
			         
			         }else { //중복 아이디 있을 경우
			        	$("#userId").focus();
			        	console.log(result);
			         	console.log("아이디 있음");
			         	idCheck.html("중복된 아이디 존재");
			         }
		    },
		    error: function (){ 
		    }
		});
	});
});
</script>
	
	<script>
	/* 다음주소 API를 통한 상세주소 입력 및 카카오API를 통한 경위도 주소 가져오는 기능(locationTransfer) 구현 */
	function findAddr(){
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var jibunAddr = data.jibunAddress; // 지번 주소 변수
	            if(roadAddr !== ''){
	                document.getElementById("endAddr").value = roadAddr;
	                locationTransfer(roadAddr);
	            } 
	            else if(jibunAddr !== ''){
	                document.getElementById("endAddr").value = jibunAddr;
	                locationTransfer(jibunAddr);
	            }
	        }
	    }).open();
	}

	/* 카카오API - 상세주소값을 가지고 해당 주소의 경위도 값을 찾아 longitude, latitude 각 input에 담아준다.*/
	function locationTransfer(star) {
		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();	

		//주소로 좌표를 검색합니다
		geocoder.addressSearch(star, function(result, status) {

		// 정상적으로 검색이 완료됐으면 
		 if (status === kakao.maps.services.Status.OK) {

		    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		    longitude = result[0].x; //경도	    
		    latitude = result[0].y;  //위도
		    $("#endLat").val(result[0].x);
		    $("#endLng").val(result[0].y);
		    console.log(latitude, longitude); //경도 위도 값 확인용
		}	
	 });
	}
	</script>
</html>