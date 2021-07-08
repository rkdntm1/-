<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>simpleMap</title>
        <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxba54ba2c3e4442368842f819ce833a5e"></script>
       <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <script type="text/javascript">
			function initTmap(){
				// 1. 지도 띄우기
				var map = new Tmapv2.Map("map_div", {
					center: new Tmapv2.LatLng(37.566777390186154,127.00245938918971),
					width: "100%",
					height: "400px"
				});
				map.setZoom(14);
				// 2. 시작, 도착 심볼찍기
				// 시작
				addMarker("llStart",126.98605733268329,37.568085523663385,1);
				// 도착
				addMarker("llEnd",127.00973587385866,37.56445848334345,2);
				function addMarker(status, lon, lat, tag) {
					//출도착경유구분
					//이미지 파일 변경.
					var markerLayer;
					switch (status) {
						case "llStart":
							imgURL = 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png';
							break;
						case "llPass":
							imgURL = 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
							break;
						case "llEnd":
							imgURL = 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png';
							break;
						default:
					};
					var marker = new Tmapv2.Marker({
						position: new Tmapv2.LatLng(lat,lon),
						icon: imgURL,
						map: map
					});
					// 마커 드래그 설정
					marker.tag = tag;
				    marker.addListener("dragend", function(evt){
				    	markerListenerEvent(evt);
				    });
				    
				    marker.addListener("drag", function(evt){    	
				    	markerObject = markerList[tag];
				    });
				    markerObject = marker;
					return marker;
				}


				// 3. 경유지 심볼 찍기
					addMarker("llPass",126.99749158970432,37.56652289898868,3);
					addMarker("llPass",126.99823724381592,37.56450100535406,4);
					addMarker("llPass",127.00186090818215,37.570721714117965,5);
					addMarker("llPass",127.00221495976581,37.56568310756034,6);


				// 4. 경유지 최적화 API 사용요청
				var prtcl;
				var headers = {}; 
				headers["appKey"]="l7xxba54ba2c3e4442368842f819ce833a5e";
				$.ajax({
							type:"POST",
							headers : headers,
							url:"https://apis.openapi.sk.com/tmap/routes/routeOptimization30?version=1&format=json",//
							async:false,
							contentType: "application/json",
							data: JSON.stringify({
									  "reqCoordType": "WGS84GEO",
									  "resCoordType" : "WGS84GEO",
									  "startName": "출발",
									  "startX": "126.98605733268329",
									  "startY": "37.568085523663385",
									  "startTime": "201711121314",
									  "endName": "도착",
									  "endX": "127.00973587385866",
									  "endY": "37.56445848334345",
									  "searchOption" : "0",
									  "viaPoints": [
									    {
									      "viaPointId": "test01",
									      "viaPointName": "test01",
									      "viaX": "126.99749158970432",
									      "viaY": "37.56652289898868",
									      "viaTime": 600
									    },
									    {
									      "viaPointId": "test02",
									      "viaPointName": "test02",
									      "viaX": "126.99823724381592",
									      "viaY": "37.56450100535406",
									      "viaTime": 600
									    },
									    {
									      "viaPointId": "test03",
									      "viaPointName": "test03",
									      "viaX": "127.00186090818215",
									      "viaY": "37.570721714117965",
									      "viaTime": 600
									    },
									    {
									      "viaPointId": "test04",
									      "viaPointName": "test04",
									      "viaX": "127.00221495976581",
									      "viaY": "37.56568310756034",
									      "viaTime": 600
									    }
									  ]
							}),
							success:function(response){
							prtcl = response;
							// 5. 경유지 최적화 결과 Line 그리기
									//경유지 최적화 결과 POINT 찍기
									/* -------------- Geometry.Point -------------- */
								    var style_red = {
								            fillColor:"#FF0000",
								            fillOpacity:0.2,
								            strokeColor: "#FF0000",
								            strokeWidth: 3,
								            strokeDashstyle: "solid",
								            pointRadius: 2,
								            title: "this is a red line"
								       };
								    /* -------------- Geometry.Point -------------- */
								    //경유지 최적화 결과 Line 그리기
								    drawData(prtcl);
						
						
							// 6. 경유지 최적화 결과 반경만큼 지도 레벨 조정
							map.zoomToExtent(routeLayer.getDataExtent());
						
						},
						error:function(request,status,error){
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
			} 
		</script>
    </head>
    <body onload="initTmap()">
        <div id="map_div">
        </div>        
    </body>
</html>	

