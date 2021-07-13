<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>API 연습</title>
</head>

<body>
    <h1>내 사이트임 ㅎㅇ</h1>
	<div id="map" style="width:100%;height:400px;">
	<p></p>
	</div>
    
    <script src="https://code.jquery.com/jquery-1.5.1.js" integrity="sha256-4uoKbKa5hKlAWnWdJM88UesxZOXEPpXD6aWbMWvns7k=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=3v0t1qkrps&submodules=geocoder"></script>
    <script>
    
    			// 출발지 요청
                $.ajax({
                	method : "GET",
                	headers: { "X-NCP-APIGW-API-KEY-ID" : "3v0t1qkrps",
                     		   "X-NCP-APIGW-API-KEY" : "Vd4UlcTuPNuR9lcXXlpbyX2ZkAM1Iy1J8y5NYs3G",
                     			 },
               contentType : "application/json; charset:UTF-8",
                        url: "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving",
                       data: { "start" : "127.1058342, 37.359708", 
                    	   	    "goal" : "129.075986, 35.179470" }
                })
                    .done(function (obj) {
                    	console.log(obj);
                    });
    			
                // 지도 생성 
                
                var map = new naver.maps.Map('map', {
                    zoom: 10,
                    center: new naver.maps.LatLng(37.3614483, 127.1114883)
                });
                
                var marker = new naver.maps.Marker({
                    position: map.getCenter(),
                    map: map,
                    clickable: true
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

                
    </script>
</body>

</html>