<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
   		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<title>메인페이지</title>
		<script	src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=c4yw03xtaw"></script>
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=3v0t1qkrps&submodules=geocoder"></script>  
	</head>
	<body>
	<div id="map" style="width:100%;height:400px;">
	</div>
	<script>
	
	var startLat = ${request.startLat}
	var startLng = ${request.startLng}
	var endLat = ${request.endLat}
	var endLng = ${request.endLng}
	
	console.log(startLat, startLng)
    			// 출발지 요청
    			//"C:\Program Files\Google\Chrome\Application\chrome.exe" --user-data-dir="C:/Chrome dev session" --disable-web-security
                $.ajax({
                	method : "GET",
                	headers: { "X-NCP-APIGW-API-KEY-ID" : "3v0t1qkrps",
                     		   "X-NCP-APIGW-API-KEY" : "Vd4UlcTuPNuR9lcXXlpbyX2ZkAM1Iy1J8y5NYs3G",
                     			 },
               contentType : "application/json; charset:UTF-8",
                        url: "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving",
                       data: { "start" : startLng + "," + startLat, 
                    	   	    "goal" : endLng + "," + endLat }
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
	
		<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
	</body>
</html>

<script>
</script>