<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri= "http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:useBean id="tablePrinter" class="www.dream.com.framework.printer.TablePrinter"/>


<div class="form-group">
	<label>아이디</label> <input name="id" value="${post.id}" class="form-control" readonly>
</div>

<div class="form-group">
	<label>제목</label> <input id="title" name="title" value="${post.title}" class="form-control" readonly>
</div>

<div class="form-group">
	<label>내용</label>
	<!-- textarea id="content" 이렇게는 오작동. 원인 파악 후 버그 레포팅 -->
	<textarea id="txaContent" name="content" class="form-control" rows="3" readonly>${post.content}</textarea>
</div>

<!-- 음식점 메뉴 정보 입력 부분   
<c:forEach items="${listMPType}" var="listMenuType" varStatus="status">
	<div class="form-group">
		<label>${listMenuType.description}</label>
		<input type="hidden" name="listMenu[${status.index}].menuPointType" value="${listMenuType.menuPointType}">
		<input id="menuInfo${status.index}" name="listMenu[${status.index}].info">
	</div>
</c:forEach>
-->
<div class="form-group">
	<label>가게위치정보</label>
	<input id="member_post"  type="text" placeholder="우편번호찾기" readonly onclick="findAddr()">
	<input id="member_addr" type="text" placeholder="주소" readonly> <br>
	<input id="member_detailAddr" type="text" placeholder="상세주소 입력하기">
	<input type="hidden" id="loc" name="location" value="" class="form-control" readonly>
</div>
<div class="form-group">
	<c:choose>
	    <c:when test="${empty post}">
			 <input value= '<sec:authentication property="principal.curUser.name"/>' class="form-control" readonly>
	    </c:when>
	    <c:otherwise>
	        <input value="${post.writer.name}" class="form-control" readonly>
	    </c:otherwise>
	</c:choose>	
</div>

<div class="form-group">
	<label>조회수</label> <input value="${post.readCnt}" readonly>
	<label>별점</label> <input value="${post.likeCnt}" readonly>
</div>

<div class="form-group">
	<label>등록시점 : </label> 
	<fmt:formatDate pattern="yyyy-MM-dd" value="${post.registrationDate}"/>
	<label>, 수정시점 : </label> 
	<fmt:formatDate pattern="yyyy-MM-dd" value="${post.updateDate}"/>
</div>
<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>

<script type="text/javascript">
	<!-- 수정 처리 시 title, content에는 readonly는 없어야 함 -->
	<!-- 신규 처리 시 title, content에는 value가 없고 readonly는 없어야 함 -->
	function controlInput(includer) {
		if (includer === '수정' || includer === '신규') {
			$('#title').attr("readonly", false);
			$('#txaContent').attr("readonly", false);
		}
	}
	
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


				
	
