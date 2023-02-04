<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<style>
	@font-face {
	    font-family: 'BMJUA';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	* {
		font-family: 'BMJUA';
	}
	.css-title{
		overflow: hidden;
		display: inline-block;
		color: rgb(47, 52, 56);
		letter-spacing: -0.3px;
		white-space: nowrap;
		text-overflow: ellipsis;
		font-size: 30px;
		line-height: 28px;
	}
	td:hover{cursor: pointer;}
</style>
</head>
<body>
	<header class="sticky-top">
		<div>
			<jsp:include page="../common/top.jsp"/>
		</div>
	</header>
	
	<main>
  		<div class="container d-flex flex-wrap css-title my-5" style="padding-left: 60px;">
  			<h1>공지사항</h1>
  		</div>
  		
  		<div class="container px-5 bd-example-snippet bd-code-snippet" style="padding-bottom: 20px; text-align: center;">
  			<div class="bd-example">
				<table class="table table-hover">
					<thead>
						<tr class="fs-5">
							<th width="100px">카테고리</th>
							<th>글 제목</th>
							<th width="130px">작성일</th>
		          		</tr>
		          	</thead>
	         		<tbody class="tbody">
	         			<c:forEach items="${ list }" var="b">
	         				<tr>
								<td>
									<c:if test="${ b.noticeCategory eq '전체' }">전체</c:if>
									<c:if test="${ b.noticeCategory eq '싱글벙글' }">싱글벙글</c:if>
									<c:if test="${ b.noticeCategory eq '씽씽마켓' }">씽씽마켓</c:if>
									<input type="hidden" value="${ b.boardNo }">
									<input type="hidden" value="${ b.nickName }">
								</td>
								<td>${ b.boardTitle }</td>
								<td>${ b.createDate }</td>
		          			</tr>
	         			</c:forEach>
	          		</tbody>
	        	</table>
	       	</div>
	       	
	       	<!-- 페이징 -->
	       	<nav aria-label="Standard pagination example">
	        	<ul class="pagination justify-content-center">
	        		<c:if test="${ pi.currentPage > 1 }">
			            <li class="page-item">
			            	<c:url var="goBack" value="${ loc }">
								<c:param name="page" value="${ pi.currentPage-1 }"/>
							</c:url>
			            	<a class="page-link" href="${ goBack }" aria-label="Previous">
			            		<span aria-hidden="true">&laquo;</span>
			              	</a>
			            </li>
		            </c:if>
		            <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
		            	<c:url var="goNum" value="${ loc }">
							<c:param name="page" value="${ p }"/>
						</c:url>
						<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
		            </c:forEach>
		            <c:if test="${ pi.currentPage < pi.maxPage }">
			            <li class="page-item">
			            	<c:url var="goNext" value="${ loc }">
								<c:param name="page" value="${ pi.currentPage + 1 }"/>
							</c:url>
							<a class="page-link" href="${ goNext }" aria-label="Next">
			            		<span aria-hidden="true">&raquo;</span>
			            	</a>
			            </li>
		            </c:if>
		    	</ul>
	        </nav>
		</div>
	</main>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
		window.onload = () => {
			const tbody = document.querySelector('.tbody');
			console.log(tbody);
			const trs = tbody.querySelectorAll('tr');
			for(const tr of trs){
				tr.addEventListener('click', function(){
					const bNo = this.querySelectorAll('input')[0].value;
					const writer = this.querySelectorAll('input')[1].value;
					location.href='${contextPath}/selectNotiBoard.no?bNo=' + bNo + '&writer=' + writer;
				});
			}
		}
	</script>
</body>
</html>