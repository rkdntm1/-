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
		
		<section class="sec1"></section>
			<label>출발주소</label><input id="start" value="">
			<input id="member_addr" type="text" placeholder="주소" readonly onclick="findAddr()"> <br>
			<input id="member_detailAddr" type="text" placeholder="상세주소 입력하기"><br>
			<label>도착주소</label><input id="end" value="">
			<input id="member_addr2" type="text" placeholder="주소" readonly onclick="findAddr2()"> <br>
			<input id="member_detailAddr2" type="text" placeholder="상세주소 입력하기">
			<input type="button" onclick="locationTransfer()">
										
										
		<section class="content">
			<h1>배달 경로</h1>
		<div id="map" style="width:100%;height:400px;">
	<p></p>
	</div>
    <script src="https://code.jquery.com/jquery-1.5.1.js" integrity="sha256-4uoKbKa5hKlAWnWdJM88UesxZOXEPpXD6aWbMWvns7k=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=3v0t1qkrps&submodules=geocoder"></script>
   
    <script>
    			// 출발지 요청
    			//"C:\Program Files\Google\Chrome\Application\chrome.exe" --user-data-dir="C:/Chrome dev session" --disable-web-security
                $.ajax({
                	method : "GET",
                	headers: { "X-NCP-APIGW-API-KEY-ID" : "3v0t1qkrps",
                     		   "X-NCP-APIGW-API-KEY" : "Vd4UlcTuPNuR9lcXXlpbyX2ZkAM1Iy1J8y5NYs3G",
                     			 },
               contentType : "application/json; charset:UTF-8",
                        url: "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving",
                       data: { "start" : "127.1058342, 37.359708", 
                    	   	    "goal" : "126.69514591292, 37.44695691889" }
                })
                   .done(function (obj) {
                    	var arr = obj.route.traoptimal[0].path
                    	var polylinePath = []
                    	
                    	arr.forEach(function(arr) { 
                    		polylinePath.push(arr); 
                    		})
                    		
                    		console.log(polylinePath);
                    	
                    	var pathlength = polylinePath.length	
                    	var mid = Math.round((pathlength)/2)
            	    	var x = polylinePath[mid][0]
            			var y = polylinePath[mid][1]
            	    	
            	    	var map = new naver.maps.Map('map', {
            	            zoom: 15,
            	            center: new naver.maps.LatLng(y, x)
            	        });
                    	
                    	var startMarker = new naver.maps.Marker({
                       	    position: new naver.maps.LatLng(polylinePath[0][1], polylinePath[0][0]),
                       	    map: map,
            	           	icon: {
            	                content: '<img src="http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png">',
            	                size: new naver.maps.Size(22, 35),
            	                anchor: new naver.maps.Point(11, 35)
            	            }
                       	});
                           
                       	var EndMarker = new naver.maps.Marker({
                       	    position: new naver.maps.LatLng(polylinePath[pathlength-1][1], polylinePath[pathlength-1][0]),
                       	    map: map,
            	           	icon: {
            	                content: '<img src="http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png">',
            	                size: new naver.maps.Size(22, 35),
            	                anchor: new naver.maps.Point(11, 35)
            	            }
                       	});
                        // 붓
                        var polyline = new naver.maps.Polyline({
                            path: polylinePath,
                            strokeColor: '#00CA00',
                            strokeOpacity: 0.8,
                            strokeWeight: 6,
                            zIndex: 2,
                            clickable: true,
                            map: map
                        });
                    	
                    	
                    });
                
    </script>
			
		</section>
		<section class="sec2"></section>
		<section class="sec3"></section>
	</body>
</html>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fc84bb357e689489432517c4afd4cbda&libraries=services"></script>
<script>
var start = $("#start");

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            start.val(roadAddr);
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
            }
        }
    }).open();
}
function findAddr2(){
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            $("#end").val(roadAddr);
            if(roadAddr !== ''){
                document.getElementById("member_addr2").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr2").value = jibunAddr;
            }
        }
    }).open();
}

locationTransfer();

function locationTransfer() {
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	var star = start.val();

	//주소로 좌표를 검색합니다
	geocoder.addressSearch(star, function(result, status) {

	// 정상적으로 검색이 완료됐으면 
	 if (status === kakao.maps.services.Status.OK) {

	    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    star = result[0].y;
	    console.log(star);
	}	
 });
}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>