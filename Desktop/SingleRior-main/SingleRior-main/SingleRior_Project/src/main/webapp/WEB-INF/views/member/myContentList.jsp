<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	#navMyContent{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
		font-size:30px;
		cursor:pointer;
	}
	.dropdown{float:right;}
	#category{width:100px; float:right;}
	.card:hover{cursor:pointer}
	.pFloat{float:right; display:inline-block; margin:auto;}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<nav class="navbar navbar-expand-lg" id="navMyContent">
		<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
			<div class="navbar-nav">
				<a class="nav-link active" aria-current="page" style="color: #008cd4" onclick="location.href='${contextPath}/myContentList.me'">나의 게시글</a>
				<a class="nav-link" onclick="location.href='${contextPath}/myReplyList.me'">나의 댓글</a>
			</div>
		</div>
	</nav>
	<section>
		<div class="col mb-3" id="categoryDiv">
			<select class="form-select form-select-sm" name="category" id="category">
				<option <c:if test="${category != '싱글벙글' && category != '씽씽마켓'}">selected</c:if>>전체</option> 
				<option <c:if test="${category == '싱글벙글'}">selected</c:if>>싱글벙글</option>
				<option <c:if test="${category == '씽씽마켓'}">selected</c:if>>씽씽마켓</option>
			</select>
		</div>
		<br><br><br>
		<div  class="divAppendClone">
			<div class="bd-example cList">
			<c:if test="${ !empty bList }">
			<c:forEach items="${ bList }" var="b">
			<div class="card">
				<div class="card-header">
					<c:if test="${ b.boardType == 2 }">
						<span class="category">[싱글벙글]</span>
					</c:if>
					<c:if test="${ b.boardType == 3 }">
						<span class="category">[씽씽마켓]</span>
						<input type="hidden" value="${ b.productNo}">
					</c:if>
				<span>&nbsp;&nbsp;&nbsp;${ b.boardTitle}</span>
				</div>
				<div class="card-body">
					<p>${ b.boardContent}</p>
					<p class="pFloat">작성일 : ${ b.modifyDate} &nbsp;&nbsp;</p>
					<p class="pFloat">좋아요<i class="bi bi-suit-heart-fill"></i> : ${ b.likeCount} &nbsp;&nbsp;</p>
					<p class="pFloat">댓글 <i class="bi bi-pencil-fill"></i> : ${ b.replyCount} &nbsp;&nbsp;</p>
					<div style="display:none">${ b.boardNo }</div>
				</div>
			</div>
			<br><br>
			</c:forEach>
			</c:if>
				<c:if test="${ empty bList }">
					<div class="alert alert-secondary" role="alert">아직 작성하신 게시글이 없습니다.</div>
				</c:if>
			</div>
			<br> <br>
			<!-- 페이징 -->
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
		</div>
	</section>
	
							
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
	window.onload = () =>{
		
		const cardDivs = document.getElementsByClassName("card");
		for(cardDiv of cardDivs){
			cardDiv.addEventListener('click', function(){
				const cate = this.childNodes[1].childNodes[1].innerText;
				
				const boardNo = this.childNodes[3].childNodes[9].innerText;
				const productNo = this.childNodes[1].childNodes[3].value;
				
				console.log(boardNo);
				const writer = '${loginUser.nickName}';
				if(cate == "[싱글벙글]"){
					location.href='${contextPath}/selectCommuBoard.co?bNo=' + boardNo + '&writer=' + writer + '&page=' + ${pi.currentPage};
				}else if(cate == "[씽씽마켓]"){
					location.href='${contextPath}/marketBoardDetail.ma?bNo=' + boardNo  +'&boardWriter=' + writer + '&page=' + ${pi.currentPage}+'&productNo=' + productNo;
				}
			});
			
		}
	}
	
	let category;
	const page = '${pi.currentPage}';
	$(function(){
		
		$('select[name=category]').change(function(){
			
			category = $('select[name=category]').val();
// 			console.log(category);
// 		 	page = '${pi.currentPage}';
			console.log(page);
// 			let category = '${ category }';
			location.href='${contextPath}/selectContentCategory.me?category=' + category;
			
		});
		
	});
	</script>
</body>
</html>