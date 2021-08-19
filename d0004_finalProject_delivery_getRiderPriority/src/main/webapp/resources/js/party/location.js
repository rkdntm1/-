/* 모듈 패턴
   이벤트, DOM, Ajax 처리 등을 하나의 jsp에 다 넣기에는 복잡해짐. 유지보수성 저하
   이에 javascript를 별도 file로 만들어 분할 정복.

CallBack 함수 : 특정 이벤트에 시에 이를 불러 준다.
*/

var locationService = (function() {
	function add(memberId, longitude, latitude, detailAddr, successCallBack, errorCallBack) {
		//https://api.jquery.com/jquery.ajax/
		$.ajax({
			type : 'post',	//methos alias
			url : '/party/newAddr/' + originalId,
			data : {memberId, longitude, latitude, detailAddr},	//객체를 json 문자열로 출력
			dataType: "json",
			contentType : 'application/json; charset=UTF-8',
			success : function(resObj, status, xhr) {
				if (successCallBack)   {
					successCallBack(resObj);
				}
			},
			error : function (xhr, status, errMsg) {
				if (errorCallBack) {
					errorCallBack(errMsg);
				}
			}
		});
	}

	
	//정의된 함수를 알려 주는 곳
	return {
		addLocation : add,
		};
})();











