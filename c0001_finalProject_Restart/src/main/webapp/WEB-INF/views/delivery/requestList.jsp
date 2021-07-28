<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="www.dream.com.delivery.model.DeliveryRequestVO"%>

<%@include file="../includes/header.jsp"%>

<!-- TableHeader에 정의된 static method를 사용하기 위해 정의 함 -->
<jsp:useBean id="tablePrinter" class="www.dream.com.framework.printer.TablePrinter"/>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-body">
			<!-- Paging 이벤트에서 서버로 요청보낼 인자들을 관리합니다. -->
			<form id='frmMatchingRider' action='/delivery/requestList' method='post'>
				<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>
			</form>

			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr><%=tablePrinter.printHeader(DeliveryRequestVO.class)%></tr>
					</thead>
					
					<tbody>
						<c:forEach items="${searchRequest}" var="request">
							<tr>
								${tablePrinter.printTableRow(request, "anchor4post")}
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- /.container-fluid -->

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
	var frmMatchingRider = $('#frmMatchingRider');
	
	/* 특정 게시물에 대한 상세 조회 처리 */
	$('.anchor4post').on('click', function(e) {
		e.preventDefault();
		var requestId = $(this).attr('href');
		frmMatchingRider.append("<input name='requestId' type='hidden' value='" + requestId + "'>");
		frmMatchingRider.submit();
	});

});
</script>
