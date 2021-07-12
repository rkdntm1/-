<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<mete name="viewport" content="width=device-width", initial-scale=1.0">
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
					<form method="post" action="/party/joinMember">
						<div class="inputBox">
							<label>아이디</label> <input id="userId" name="userId" placeholder="아이디를 입력하세요" >
							<input id="idCheck" type="button" value="중복체크(체크필요)">
						</div>				
						<div id="PwdCheck" class="inputBox">
							<label>패스워드</label> <input id="userPwdOrgin" name="userPwd1" type="password" placeholder="숫자,문자포함 8~20자로 입력하시오">
							<label>패스워드 재입력</label> <input id="userPwdCheck" name="userPwd" type="password">
						</div>
						<p id="pwCheckMsg">패스워드를 일치시켜주세요</p>				
						<div class="inputBox">
							<label>회원 닉네임</label> <input id="memberName" name="name" placeholder="닉네임을 입력하세요">
						</div>
						<div class="inputBox">
							<label>생년월일</label>
							<input id="birthDt" type="date" pattern="yyyy-MM-dd" name="birthDate" >
						</div>
						<div class="inputBox">
							<p>성별</p>
				     		<label>남자</label><input type="radio" name="male" value="1" checked="checked">
				      		<label>여자</label><input type="radio" name="male" value="0"> 
						</div>
						<c:forEach items="${listCPType}" var="contactPointType" varStatus="status">
							<div class="inputBox">
								<c:choose>
									<c:when test="${contactPointType.description eq '주소지'}">
										<label>${contactPointType.description}</label>
										<input id="member_post"  type="text" placeholder="우편번호찾기" readonly onclick="findAddr()">
			    						<input id="member_addr" type="text" placeholder="주소" readonly> <br>
			    						<input id="member_detailAddr" type="text" placeholder="상세주소 입력하기">
										<input type="hidden" id="contact${status.index}" name="listContactPoint[${status.index}].info">
										<input type="hidden" name="listContactPoint[${status.index}].contactPointType" value="${contactPointType.contactPointType}">
									</c:when>
									<c:otherwise>
										<label>${contactPointType.description}</label>
										<input type="hidden" name="listContactPoint[${status.index}].contactPointType" value="${contactPointType.contactPointType}">
										<input id="contact${status.index}" name="listContactPoint[${status.index}].info"> 
									</c:otherwise>
								</c:choose>	
							</div>
						</c:forEach>
						<div class="inputBox">
							<input id="btnJoin" type="submit" value="가입">
						</div>
						
						<input type="hidden" name = "descrim" value="${memberType}">
						<input type="hidden" name="boardId" value="${boardId}">
						<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
					</form>
				</div>		
			</div>
		</div>
	</section>
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
	
	$('#PwdCheck').keyup(function(){
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
	
	var idCheck = $("#idCheck");
	idCheck.on("click", function(){
		var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
		
		if(! idReg.test($("#userId").val().trim())) {
			alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
			$("#userId").focus();
			return false;
		}
		
		id = $("#userId").val();
		
		$.ajax({	
		    url: '/party/idCheck',
		    type: 'POST',
		    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
		    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
		    data: id,

		    success: function(data){
		         if(data == 0){
		         console.log("아이디 없음");
		         alert("사용하실 수 있는 아이디입니다.");
		         }else{
		         	console.log("아이디 있음");
		         	alert("중복된 아이디가 존재합니다.");
		         }
		    },
		    error: function (){        
		    }
		  });
		idCheck.val("아이디 체크완료");
	});
	
	$("#btnJoin").on("click", function() {
		var addr = $("#member_addr").val();
		var detailAddr = $("#member_detailAddr").val();
		
		var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d~!@#$%^&*()+|=]{8,20}$/;
		var nickReg = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/;
		var addrNumReg = /^\d{2,3}-\d{3,4}-\d{4}$/;
		var mobiNumReg = /^\d{3}-\d{3,4}-\d{4}$/;
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		$("#contact0").val(addr + " " + detailAddr);
		
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
			alert("최소 8자, 최소 하나의 문자 및 하나의 문자로 이루어진 패스워드를 입력하시오.");
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
			alert("전화번호를 ###-###-### 형식에 맞춰서 입력하시오");
			$("#contact1").focus();
			return false;
		}
		
		if (! mobiNumReg.test($("#contact2").val().trim())) {
			alert("핸드폰번호를 ###-###-### 형식에 맞춰서 입력하시오");
			$("#contact2").focus();
			return false;
		}
		
		if (! emailReg.test($("#contact3").val().trim())) {
			alert("제대로된 이메일 양식을 입력하시오");
			$("#contact3").focus();
			return false;
		}
	});
	
});

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('member_post').value = data.zonecode;
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
