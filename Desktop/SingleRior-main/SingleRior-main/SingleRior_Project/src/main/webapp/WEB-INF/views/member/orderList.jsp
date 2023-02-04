<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{
		margin:auto; 
	 	margin-top:50px; 
	 	max-width:1300px;
	}
	#orderStatus{
	 	padding:60px;
		background-color:#F5F5F5;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
		font-size:35px;
		text-align:center;
	}
	.a{display:inline-block; padding:20px; text-decoration:none; color:black; cursor:pointer;}
	.a:hover{font-weight:bold;}
	.orderStatusCount{color:#008cd4;}
	.orderDetail{
		margin:auto; 
	 	margin-top:50px; 
	 	max-width:1300px;
	 	height:370px;
	 	padding:20px;
	 	background-color:rgba(0, 140, 212, 0.2);
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
	}
	.orderDetail table{
		width:1100px;
        flex-direction: row;
        justify-content: center;
	}
	.orderDetail td{padding:15px; word-break:break-all;}
	.line{border-left : thick solid gray; height : 140px;}
	
	.orderProductDetail{float:right; cursor:pointer;}
	.orderProductDetail:hover{text-decoration:underline; font-weight:bold;}
	.orderStatusBtn{float:right}
	.img:hover{cursor:pointer}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<section>
		<div id="orderStatus">
				<div class="a"><div class="orderStatusTitle">입금대기</div><div class="orderStatusCount"></div></div>
				<span>></span>
				<div class="a"><div class="orderStatusTitle">결제완료</div><div class="orderStatusCount"></div></div>
				<span>></span>
				<div class="a"><div class="orderStatusTitle">배송준비</div><div class="orderStatusCount"></div></div>
				<span>></span>
				<div class="a"><div class="orderStatusTitle">배송중</div><div class="orderStatusCount"></div></div>
				<span>></span>
				<div class="a"><div class="orderStatusTitle">배송완료</div><div class="orderStatusCount"></div></div>
				<span>></span>
				<div class="a"><div class="orderStatusTitle">구매확정</div><div class="orderStatusCount"></div></div>
		</div>
		<br><br>
		<hr width="1300px;" style="margin:auto"><br><br>
		<div id="selectDate" class="btn-group">
		 <div class="col mb-3" id="dateDiv">
			<select class="form-select form-select-sm" name="date" id="date" >
				<option <c:if test="${date != '1개월' && date != '3개월' && date != '1년'}">selected</c:if>>전체</option> 
				<option <c:if test="${date == '1개월'}">selected</c:if>>1개월</option>
				<option <c:if test="${date == '3개월'}">selected</c:if>>3개월</option>
				<option <c:if test="${date == '1년'}">selected</c:if>>1년</option>
			</select>
		 </div>&nbsp;
		  <c:if test="${ status != '전체'}">
			<div>
				<button type="button" class="btn btn-light" id="cancelStatus" style="height:31px;">
	 				 ${ status }<i class="bi bi-x-lg"></i>
				</button>
			</div>
		</c:if>
		</div>
			<c:if test="${ !empty oiList }">
				<c:forEach items="${ oiList }" var="oi">
					<div class="orderDetail">
						<span>주문번호 : ${fn:replace(oi.orderDate, '-', '')}${oi.orderNo }</span>&nbsp;&nbsp;&nbsp;
						<span>주문일자 : ${ oi.orderDate }</span>
						<input type="hidden" value="${ oi.boardNo }" name="boardNo">
						<input type="hidden" value="${ oi.productNo }" name="productNo">
						<form action="${contextPath}/orderProductDetail.me" method="post" class="detailForm">
							<span class="orderProductDetail">상세보기</span><br><br>
							<input type="hidden" value="${ oi.orderNo }" name="orderNo">
						</form>
						<div>
							<span class="badge text-bg-light" style="font-size:1em">${ oi.status }</span><br>
						</div>
						<table>
							<tr>
								<td rowspan="2" width="200px;"><img src="${ contextPath }/resources/uploadFiles/${oi.imgRename }" width="160" class="img"></td>
								<td  height="50px;" width="450">${oi.boardTitle }</td>
								<td rowspan="2" width="50px;"><div class="line"></div></td>
								<td colspan="2">가격</td>
							</tr>
							<tr>
								<td>${oi.productOption }</td>
								<td><fmt:formatNumber value="${oi.salePrice }" pattern="#,###"/>원</td>
							</tr>
						</table>
						<c:if test="${ oi.status == '입금대기' or oi.status == '결제완료' or oi.status == '배송준비'}">
							<button type="button" class="orderStatusBtn btn btn-light orderCancel" data-bs-toggle="modal" data-bs-target="#orderCancelModal">
							  주문취소
							</button>
							<input type="hidden" value="${ oi.orderDetailNo }" class="orderDetailNo">	
						</c:if>
						<c:if test="${ oi.status == '배송중'}">
							<button type="button" class="orderStatusBtn btn btn-light" data-bs-toggle="modal" data-bs-target="">
							  운송장확인
							</button>
							<input type="hidden" value="${ oi.orderDetailNo }" class="orderDetailNo">
						</c:if>
						<c:if test="${ oi.status == '배송완료'}">
							<button type="button" class="orderStatusBtn btn btn-light orderCommit" data-bs-toggle="modal" data-bs-target="#orderCommitModal">
							  구매확정
							</button>
							<input type="hidden" value="${ oi.orderDetailNo }" name="orderDetailNo" class="orderDetailNo">
						</c:if>
						<c:if test="${ oi.status == '구매확정'}">
							<button type="button" class="orderStatusBtn btn btn-light orderReview" onClick="location.href='${contextPath}/myReviewNDoneList.me'">
							  리뷰작성
							</button>
							<input type="hidden" value="${ oi.orderDetailNo }" class="orderDetailNo">
						</c:if>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${ empty oiList }">
				<div class="alert alert-secondary" role="alert">조회 결과가 없습니다.</div>			
			</c:if>
			<br><br>
				<c:if test="${ !empty oiList }">
					<nav aria-label="Standard pagination example">
					<ul class="pagination justify-content-center">
					 <c:if test="${ pi.currentPage > 1 }">
						<li class="page-item"><c:url var="goBack" value="${ loc }">
								<c:param name="page" value="${ pi.currentPage-1 }" />
								<c:param name="status" value="${ status }"/>
								<c:param name="date" value="${ date }"/>
							</c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
						</a></li>
						</c:if>
						<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
							<c:url var="goNum" value="${ loc }">
								<c:param name="page" value="${ p }" />
								<c:param name="status" value="${ status }"/>
								<c:param name="date" value="${ date }"/>
							</c:url>
							<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
						</c:forEach>
						<c:if test="${ pi.currentPage < pi.maxPage }">
						<li class="page-item"><c:url var="goNext" value="${ loc }">
								<c:param name="page" value="${ pi.currentPage+1 }" />
								<c:param name="status" value="${ status }"/>
								<c:param name="date" value="${ date }"/>
							</c:url> <a class="page-link" href="${ goNext }" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						</c:if>
					</ul>
				</nav>
			</c:if>
	</section>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	
	<!-- 주문 취소 모달창 -->
	<div class="modal" tabindex="-1" id="orderCancelModal">
		<div class="modal-dialog modal-dialog-centered">
			<form action="${contextPath}/orderCancel.me" method="post">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">주문을 취소하시겠습니까?</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>배송중이거나 구매확정일 경우 관리자에 주문취소가 철회될 수 있습니다.</p>
						<select class="form-select form-select-lg mb-3"
							aria-label=".form-select-lg example" name="cancelCate">
							<option selected>취소 이유 선택</option>
							<option value="단순변심">단순변심</option>
							<option value="배송지연">배송지연</option>
							<option value="품절">품절</option>
							<option value="재주문">재주문</option>
							<option value="주문실수">주문실수</option>
							<option value="서비스불만족">서비스 불만족</option>
							<option value="기타">기타</option>
						</select>
						<div class="mb-3">
							<textarea class="form-control" id="exampleFormControlTextarea1"
								rows="3" placeholder="기타를 선택하신 경우 입력해주세요." style="resize: none;" name="cancelReason"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">창닫기</button>
						<button type="submit" class="btn btn-light"
							style="background: #008cd4; color: white">주문취소</button>
								<input type="hidden" value="" name="orderNo" id="orderCancelNo">
								<input type="hidden" value="" name="orderDetailNo" id="orderCancelDetailNo">
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<!--  구매 확정 모달 -->
	<div class="modal" tabindex="-1" id="orderCommitModal">
		<div class="modal-dialog modal-dialog-centered">
			<form action="${contextPath}/orderCommit.me" method="post">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">구매확정</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>구매확정을 하시면 환불/반품이 불가합니다.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
						<button type="submit" class="btn btn-light" style="background:#008cd4; color:white">구매확정</button>
					<input type="hidden" value="" name="orderDetailNo"  id="orderCommit">
					</div>
				</div>
			</form>
		</div>
	</div>
	

	<script>
		const orderProductDetails = document.getElementsByClassName("orderProductDetail");
		console.log(orderProductDetails);
		for(orderProductDetail of orderProductDetails){
			orderProductDetail.addEventListener('click',function(){
// 				var orderNo = this.parentNode.childNodes[5].value;
				var detailForm =  this.parentNode;
// 				console.log(detailForm);
				detailForm.submit();
// 				location.href='${contextPath}/orderProductDetail.me?orderNo=' + orderNo;
			});
		}
		
		var imgs = document.getElementsByClassName("img");
		for(img of imgs){
			img.addEventListener('click',function(){
				var boardNo = this.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[5].value;
				var productNo = this.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[7].value;
				console.log(productNo);
				location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo + '&page=' + ${pi.currentPage};
				
			});
		}
	
		window.onload = () =>{
			var orderStatusCounts = document.getElementsByClassName("orderStatusCount");
			var arr = ${countStatus};
			var count = 0;
			
			for(orderStatusCount of orderStatusCounts){
				orderStatusCount.innerText = arr[count];
				count++;
			}
			
			var orderStatusTitles = document.getElementsByClassName("orderStatusTitle");
// 			console.log(orderStatusTitles);
			
			for(orderStatusTitle of orderStatusTitles){
				orderStatusTitle.addEventListener("click",function(){
					var status = this.innerText;
					console.log(status);
					var date = '${ date }';
					location.href='${contextPath}/orderList.me?date=' + date + '&status=' + status;
				});
			}

			$('select[name=date]').change(function(){
				var date = $('select[name=date]').val();
	 			console.log(date);
// 	 		 	page = '${pi.currentPage}';
// 				console.log(page);
	 			let status = '${ status }';
	 			console.log(status);
				location.href='${contextPath}/orderList.me?date=' + date + '&status=' + status;
				
			});
			
			
			var orderCommits = document.getElementsByClassName("orderCommit");
			
			for(orderCommit of orderCommits){
				orderCommit.addEventListener('click',function(){
					var orderDetailNo = this.parentNode.childNodes[17].value;
					console.log(orderDetailNo);
					document.getElementById("orderCommit").value = orderDetailNo;
				});
			}
			
			var orderCancels = document.getElementsByClassName("orderCancel");
// 			console.log(orderCancels);
			for(orderCancel of orderCancels){
				orderCancel.addEventListener("click",function(){
					var orderDetailNo = this.parentNode.childNodes[17].value;
					console.log(orderDetailNo);
					document.getElementById("orderCancelDetailNo").value = orderDetailNo;
					var orderNo = this.parentNode.childNodes[9].childNodes[5].value;
					console.log(orderNo);
					document.getElementById("orderCancelNo").value = orderNo;
				})
			}
			
			var cancelStatus = document.getElementById("cancelStatus");
			cancelStatus.addEventListener("click", function(){
				var status = '전체';
				var date = '${date}';
				location.href='${contextPath}/orderList.me?date=' + date+ '&status=' + status;
			})
		}
	</script>
</body>
</html>