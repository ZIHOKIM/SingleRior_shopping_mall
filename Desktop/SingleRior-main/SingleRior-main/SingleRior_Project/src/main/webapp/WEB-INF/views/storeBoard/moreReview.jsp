<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	.inquiry{
		margin-top:70px; 
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.title{margin:auto;
		margin-top:70px;
		max-width:1000px;}
		
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<section>
			<h1 class="title" style="color: #008cd4">나의 게시글</h1>
		<div class="inquiry">
			<c:forEach items="${prList}" var="pr">
						  <table class="reviewTable">
						 <tr>
						 	<td>
						 	<img src="${ contextPath }/resources/uploadFiles/${pr.imgServerName}" width="160" class="img">
						 	</td>
						 	<td>
						 	<span><b>${pr.nickName }</b>의 리뷰</span><br><br>
						 	<span>${pr.reviewContent}</span><br><br>
						 	<span>${pr.productOption}&nbsp;&nbsp;&nbsp;</span><br>
						 	<span>작성일 : ${pr.reviewDate }&nbsp;&nbsp;&nbsp;</span>
						 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						 	<span class="reviewRatingTable badge badge rounded-pill text-bg-danger" style="font-size: 1rem; float: right;">★${ pr.reviewRating }</span>
						 	</td>
						 </tr>
						 </table>
						</c:forEach>
		</div>
	</section>
	<br><br>
	<c:if test="${! empty prList }">
		<nav aria-label="Standard pagination example">
			<ul class="pagination justify-content-center">
				<li class="page-item"><c:url var="goBack" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage-1 }" />
						<c:param name="productNo" value="${ prList[0].productNo }" />
					</c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
				</a></li>
				<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
					<c:url var="goNum" value="${ loc }">
						<c:param name="page" value="${ p }" />
						<c:param name="productNo" value="${ prList[0].productNo }" />
					</c:url>
					<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
				</c:forEach>
				<li class="page-item"><c:url var="goNext" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage+1 }" />
						<c:param name="productNo" value="${ prList[0].productNo }" />
					</c:url> <a class="page-link" href="${ goNext }" aria-label="Next"> <span
						aria-hidden="true">&raquo;</span>
				</a></li>
			</ul>
		</nav>
	</c:if>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
</body>
</html>