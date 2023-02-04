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
		margin-top:70px;
		max-width:1500px;
	}
	.img:hover{cursor:pointer}


</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<section>
		<h1 style="text-align:left">주문취소/환불 내역</h1><br><br>
		<c:if test="${ !empty ocList }">
			<c:forEach items="${ocList }" var="oc" varStatus="pc">
				<div class="orderCancelProduct ing">
					<span>주문번호 : ${fn:replace(oc.orderDate, '-', '')}${oc.orderNo }</span>&nbsp;&nbsp;&nbsp;
					<span>주문일자 : ${oc.orderDate }</span>
					<h4><span class="badge bg-secondary" style="float:right">${oc.status }</span></h4>
					    <input type="hidden" class="boardNo" value="${oc.boardNo }">
					    <input type="hidden" class="productNo" value="${oc.productNo }">
					<table class="table">
					    <tr>
					      <td scope="row" colspan="4"></td>
					    </tr>
					    <tr height="15">
					    	<td scope="row" width="250" rowspan="3"><img src="${ contextPath }/resources/uploadFiles/${oc.imgRename }" width="160" class="img"></td>
					     	<td width="350">상품</td>
					      	<td width="450">옵션</td>
					      	<td>상품 금액</td>
					   	</tr>
					   	<tr>
					     	<td>
					      		<div>${oc.boardTitle }</div>
					      	</td>
					      	<td>
								<div>${oc.productOption }</div>		      
					      	</td>
					      	<td>
					      		<div><fmt:formatNumber value="${oc.salePrice }" pattern="#,###"/>원</div>
					      	</td>
					   	</tr>
					</table>
					<table class="table">
					<c:if test="${ ! empty pcList[pc.index].cancelCate}">
						<tr height="50">
							<td width="100">취소 사유: ${ pcList[pc.index].cancelCate}</td>
							<td width="300">취소 이유: ${ pcList[pc.index].cancelReason}</td>
							<td width="120">
								<c:if test="${oc.status == '주문취소'}">
								예상 
								</c:if>
								환불 금액: 
								<c:if test="${oc.orderTotalPrice - oc.salePrice > 50000 }">
								<fmt:formatNumber value="${oc.salePrice }" pattern="#,###"/>원
								</c:if>
								<c:if test="${oc.orderTotalPrice - oc.salePrice < 50000 }">
								<fmt:formatNumber value="${oc.salePrice - 2500}" pattern="#,###"/>원
								</c:if>
							</td>
						</tr>
					</c:if>
					<c:if test="${ empty pcList[pc.index].cancelCate}">
						<tr height="50">
							<td width="100">취소 사유: 판매자 측 주문 취소</td>
							<td width="300">취소 이유: 자세한 내용은 고객센터를 이용해주세요.</td>
							<td width="120">
								<c:if test="${oc.status == '주문취소'}">
								예상 
								</c:if>
								환불 금액: 
								<c:if test="${oc.orderTotalPrice - oc.salePrice > 50000 }">
								<fmt:formatNumber value="${oc.salePrice }" pattern="#,###"/>원
								</c:if>
								<c:if test="${oc.orderTotalPrice - oc.salePrice < 50000 }">
								<fmt:formatNumber value="${oc.salePrice - 2500}" pattern="#,###"/>원
								</c:if>
							</td>
						</tr>
					</c:if>
					</table>
				</div><br><br>
			</c:forEach>
		</c:if>
		
		<c:if test="${ !empty ocList }">
			<nav aria-label="Standard pagination example">
				<ul class="pagination justify-content-center">
				  <c:if test="${ pi.currentPage > 1 }">
					<li class="page-item"><c:url var="goBack" value="${ loc }">
							<c:param name="page" value="${ pi.currentPage-1 }" />
							<c:param name="category" value="${ category }"/>
						</c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
					</a></li>
					</c:if>
					<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
						<c:url var="goNum" value="${ loc }">
							<c:param name="page" value="${ p }" />
							<c:param name="category" value="${ category }"/>
						</c:url>
						<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
					</c:forEach>
					 <c:if test="${ pi.currentPage < pi.maxPage }">
					<li class="page-item"><c:url var="goNext" value="${ loc }">
							<c:param name="page" value="${ pi.currentPage+1 }" />
							<c:param name="category" value="${ category }"/>
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
	
	<script>
	window.onload=()=>{
		var imgs = document.getElementsByClassName("img");
		for(img of imgs){
			img.addEventListener("click",function(){
				var boardNo = this.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[7].value;
				var productNo = this.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[9].value;
				
				location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo + '&page=' + ${pi.currentPage};
			})
		}
		
		
		
	}
	
	
	</script>
</body>
</html>