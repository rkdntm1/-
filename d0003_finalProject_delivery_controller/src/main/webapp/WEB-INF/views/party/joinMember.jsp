<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale=1.0">
<title>회원가입페이지</title>
<link rel="stylesheet" href="/resources/css/loginStyle.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head> 
<body>
	<section>
		<div class="color"></div>
		<div class="color"></div>
		<div class="color"></div>
		<div class="box">
			<div class="square" style="--i:0;"></div>
			<div class="square" style="--i:1;"></div>
			<div class="square" style="--i:2;"></div>
			<div class="square" style="--i:3;"></div>
			<div class="square" style="--i:4;"></div>
				
			<div class="container">
				<div class="form">
					<h2>회원가입</h2>
					<form id="frmJoinMember" method="post" action="/party/joinMember">
					<div class="inputBox">
						<c:choose>
							<c:when test="${partyType eq 'CEO'}">
								<label>가게 아이디</label> <input id="storeId" name="storeId" placeholder="가게 아이디를 입력하세요" >
								<p><input id="storeIdCheck" type="button" value="중복체크(체크필요)"></p>
							</c:when>
							<c:otherwise>
								<input type="hidden" name="storeId" value="">
							</c:otherwise>
						</c:choose>
						</div>
						
						<div class="inputBox">
							<label>아이디</label> <input id="userId" name="userId" placeholder="아이디를 입력하세요" >
							<p id="idCheck">중복체크(체크필요)</p>
						</div>
										
						<div id="PwdCheck" class="inputBox">
							<label>패스워드</label> <input id="userPwdOrgin" name="userPwd1" type="password" placeholder="숫자,문자포함 최소 6자로 입력">
							<label>패스워드 재입력</label> <input id="userPwdCheck" name="userPwd" type="password">
						</div>
						<p id="pwCheckMsg">패스워드를 일치시켜주세요</p>	
									
						<div class="inputBox">
							<label>회원 닉네임</label> <input id="memberName" name="userName" placeholder="닉네임을 입력하세요">
						</div>
						
						<div class="inputBox">
							<label>생년월일</label>
							<input id="birthDt" type="date" pattern="yyyy-MM-dd" name="birthDate" value="2000-01-01">
						</div>
						
						<div class="inputBox">
							<fieldset>
							<legend>성별</legend>
							<label>남자</label><input type="radio" name="sex" value="1" checked="checked">
				      		<label>여자</label><input type="radio" name="sex" value="0">
							</fieldset>
						</div>
						
						<c:forEach items="${listCPType}" var="contactPointType" varStatus="status">
							<div class="inputBox">
								<c:choose>
									<c:when test="${contactPointType.description eq '주소지'}">
										<label>${contactPointType.description}</label>
			    						<input id="member_addr" type="text" placeholder="주소" readonly onclick="findAddr()"> <br>
			    						<input id="member_detailAddr" type="text" placeholder="상세주소 입력하기">
										<input type="hidden" id="contact${status.index}" name="listContactPoint[${status.index}].info">
										<input type="hidden" name="listContactPoint[${status.index}].contactPointType" value="${contactPointType.contactPointType}">
									</c:when>
									<c:otherwise>
										<label>${contactPointType.description}</label>
										<input id="contact${status.index}" name="listContactPoint[${status.index}].info"> 
										<input type="hidden" name="listContactPoint[${status.index}].contactPointType" value="${contactPointType.contactPointType}">
									</c:otherwise>
								</c:choose>	
							</div>
						</c:forEach>
						
						<div class="inputBox">
							<input id="btnJoin" type="button" value="가입">
						</div>
						<input type="hidden" name="personType" value="${partyType}">
						<input type="hidden" name="descrim" value="Person">
						<input type="hidden" name="listLocation[0].latitude" id="firstLatitude" value="">
						<input type="hidden" name="listLocation[0].longitude" id="firstLongitude"  value="">
						<input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token}">
						
					</form>
				</div>		
			</div>
		</div>
	</section>
</body>
</html>
<!-- 카카오맵APi, 다음주소APi -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	fc84bb357e689489432517c4afd4cbda&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	var idCheck = $("#idCheck");
	var frmJoinMember = $("#frmJoinMember");
	
	var csrFHN = "${_csrf.headerName}";
	var csrfTV = "${_csrf.token}";
	
	$(document).ajaxSend(
		function(e, xhr) {
			xhr.setRequestHeader(csrFHN, csrfTV);
		}
	);
	
	
	/* 아이디 입력칸 focusout 될 경우 정규식 및 아이디 중복 조회 기능 구현 */
	$("#userId").on("focusout", function(){
		var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
		
		if(! idReg.test($("#userId").val().trim())) {
			$("#userId").focus();
			idCheck.html("<font color='#FF3333'>영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다. </font>");
			return false;
		}
		
		//회원 ID가 유일한가를 Ajax로 검사하고 그렇지 못할때는 focus를 다시 받음
		var newBieId = $(this).val();

		$.ajax({	
		    url: '/party/chkIdDup',
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
	
	/* 패스워드 재입력칸 focusout시 본래 패스워드와의 값을 비교하여 일치유무 구현 */
	$('#PwdCheck').on("focusout", function(){
		if($('#userPwdOrgin').val().trim() == "" || $('#userPwdCheck').val().trim() == ""){
			$('#pwCheckMsg').html("제대로 입력해주세요");
		} else {
			if($('#userPwdOrgin').val()!=$('#userPwdCheck').val()){
				$('#pwCheckMsg').text('');
		  		$('#pwCheckMsg').html("<font color='#FF3333'>패스워드 확인이 불일치 합니다. </font>");
		 	}else{
			  	$('#pwCheckMsg').text('');
			  	$('#pwCheckMsg').html("<font color='#70AD47'>패스워드 확인이 일치 합니다.</font>");
		 	}	
		}
		
	});
	
	/* 가입 버튼을 눌렀을시 아이디, 패스워드 체크유무 재확인 및 정규식에 따른 오류가 있을시 해당 위치로 focus이동. 모두 완료시 submit 가능하도록 구현 */
	$("#btnJoin").on("click", function() {
		var addr = $("#member_addr").val();
		var detailAddr = $("#member_detailAddr").val();
		
		$("#contact0").val(addr + " " + detailAddr); //도로명(지번주소)와 상세주소를 연결시켜줌
		
		var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;					//아이디 정규식:영문자로 시작하는 6~20자 영문자 또는 숫자 
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;	//패스워드 정규식:최소 6자, 최소 하나의 문자 및 하나의 숫자
		var nickReg = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/;	//닉네임 정규식:한글, 영문, 숫자만 가능하며 2-10자리 가능
		var addrNumReg = /^\d{2,3}\d{3,4}\d{4}$/;				//전화번호 정규식 (2~3)(3~4)(4)
		var mobiNumReg = /^\d{3}\d{3,4}\d{4}$/;					//모바일번호 정규식 (3)(3~4)(4)
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;	//이메일 정규식

		if(! idReg.test($("#userId").val().trim())) {
			alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
			$("#userId").focus();
			return false;
		}
		if($("#userPwdOrgin").val() != $("#userPwdCheck").val()){
			alert("비밀번호가 일치하지 않습니다.");
			$("#userPwdOrgin").focus();
			return false;
		}
		
		if(! pwReg.test($("#userPwdCheck").val().trim())) {
			alert("최소 6자, 최소 하나의 문자 및 하나의 문자로 이루어진 패스워드를 입력하시오.");
			$("#userPwdOrgin").focus();
			return false;
		}
		
		if(! nickReg.test($("#memberName").val().trim())) {
			alert("닉네임은 한글, 영문, 숫자만 가능하며 2-10자리 가능.");
			$("#memberName").focus();
			return false;
		}
		
		if ($("#birthDt").val() == "") {
			alert("생년월일을 입력해주세요");
			return false;
		}
		
		if (! addrNumReg.test($("#contact1").val().trim())) {
			alert("제대로 번호를 입력하세요");
			$("#contact1").focus();
			return false;
		}
		
		if (! mobiNumReg.test($("#contact2").val().trim())) {
			alert("제대로 번호를 입력하세요");
			$("#contact2").focus();
			return false;
		}
		
		if (! emailReg.test($("#contact3").val().trim())) {
			alert("제대로된 이메일 양식을 입력하시오");
			$("#contact3").focus();
			return false;
		}
		frmJoinMember.submit();
	});
});

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
                document.getElementById("member_addr").value = roadAddr;
                locationTransfer(roadAddr);
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
                locationTransfer(jibunAddr);
            }
        }
    }).open();
	$("#member_detailAddr").focus(); //도로명(지번주소) 선택후 상세주소로 focus넘기기
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
	    $("#firstLongitude").val(result[0].x);
	    $("#firstLatitude").val(result[0].y);
	    console.log(latitude, longitude); //경도 위도 값 확인용
	}	
 });
}
</script>
