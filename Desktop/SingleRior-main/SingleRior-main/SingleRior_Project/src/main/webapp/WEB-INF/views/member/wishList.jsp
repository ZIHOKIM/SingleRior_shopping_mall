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

 .nav-link:hover {font-weight : bold; color:#008cd4;} 

	#navReview{
		margin:auto;
		max-width:400px;
		font-size:30px;
		cursor:pointer;
	}
	
	section,.not{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
	
	}
	.cardDiv{display:inline}
 	.wishListDivs{cursor:pointer;}; 
</style>
</head>
<body>
	<jsp:include page="../common/top.jsp"/>
	<br><br><br>
	<nav class="navbar navbar-expand-lg" id="navReview">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
				<div class="navbar-nav categoryDiv">
					<span class="categorys nav-link" id="store" <c:if test="${category == '스토어' }">style="color:#008cd4" </c:if>>스토어</span>
					<span class="categorys nav-link" id="market" <c:if test="${category == '씽씽마켓' }">style="color:#008cd4" </c:if>>씽씽마켓</span>
					<span class="categorys nav-link" id="community" <c:if test="${category == '싱글벙글' }">style="color:#008cd4" </c:if>>싱글벙글</span>
				</div>
			</div>
		</div>
	</nav>
	<section>
	<c:if test="${ !empty wlList}">
		<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-top: 60px;  padding-bottom60px; padding-right: 150px;">
	  		<button id="deleteBtn" class="btn btn-primary me-md-2" type="button">선택</button>
	  		<button id="deleteCancel" class="btn-close" type="button" style="display:none"></button>
		</div><br><br>
	</c:if>
		
		<div class="wishListDiv row row-cols-1 row-cols-md-4 g-4" style="margin-left: 150px; margin-right: 150px; ">
			<c:if test="${ !empty wlList}">
				<c:forEach items="${ wlList }" var="wl">
						<div class="col">
							<input type="checkbox" style="display:none" class="checkbox" value="${ wl.boardNo }" name="checkbox">
							<div class="wishListDivs card shadow-sm" <c:if test="${ wl.boardType == 1 || wl.boardType == 3}">style="height:23rem;"</c:if><c:if test="${ wl.boardType == 2}">style="height:10rem;"</c:if>>
							<c:if test="${ wl.boardType == 1 || wl.boardType == 3}">
								<c:if test="${ empty wl.imgRename }">
									<img class="bd-placeholder-img card-img-top" width="100%" height="225" src="${ contextPath }/resources/image/noimg.jpg">
								</c:if>
								<c:if test="${ !empty wl.imgRename }">
									<img class="bd-placeholder-img card-img-top" width="100%" height="225" src="${ contextPath }/resources/uploadFiles/${wl.imgRename }">
								</c:if>
							</c:if>
							<c:if test="${ wl.boardType == 2}">
								<c:if test="${ empty wl.imgRename }">
									<img class="bd-placeholder-img card-img-top" width="100%" height="225" src="${ contextPath }/resources/image/noimg.jpg" style="display:none">
								</c:if>
								<c:if test="${ !empty wl.imgRename }">
									<img class="bd-placeholder-img card-img-top" width="100%" height="225" src="${ contextPath }/resources/uploadFiles/${wl.imgRename }" style="display:none">
								</c:if>
							</c:if>
								<div class="card-body">
									<p class="card-text">
										<c:if test="${ wl.boardType == 1}">
											<p class="category">스토어</p>
										</c:if>
										<c:if test="${ wl.boardType == 2}">
											<p class="category">싱글벙글</p>
										</c:if>
										<c:if test="${ wl.boardType == 3}">
											<p class="category">씽씽마켓</p>
										</c:if>									
									</p>
									<div class="d-flex justify-content-between align-items-center">
										<p class="card-text">${ wl.boardTitle }</p>
										<input type="hidden" value="${ wl.boardType }" class="cate">
										<input type="hidden" value="${ wl.boardNo }" class="boardNo">
										<input type="hidden" value="${ wl.productNo }" class="productNo">
										<c:if test="${ wl.boardType == 1}">
											<p class="text-muted">${ wl.productPrice }원</p>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					<br><br>
				</c:forEach>
			</c:if>
		</div>
			<c:if test="${ empty wlList}">
				<div class="not">
					<div class="alert alert-secondary" role="alert">아직 공감하신 게시글이 없습니다.</div>
				</div>
			</c:if>
		<br><br><br>
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
	</section>
	<footer>
		<jsp:include page="../common/footer.jsp" />
	</footer>
	
	<script>

	window.onload = () => {
		const categorys = document.getElementsByClassName('categorys');
// 		console.log(categorys);
		
		for(cate of categorys){
		 	cate.addEventListener('click',function(){
// 		 		console.log(this.innerText);
		 		const category = this.innerText;
		 		location.href='${contextPath}/wishList.me?category=' + category;
		 	})
		}
		
		
		
		const divs = document.getElementsByClassName("wishListDivs");
// 		console.log(divs);
		
		for (div of divs){
			div.addEventListener('click', function(){
				const writer = '${loginUser.nickName}';
				const boardNo = this.childNodes[3].childNodes[6].childNodes[5].value;
				const category = this.childNodes[3].childNodes[6].childNodes[3].value;
				const productNo = this.childNodes[3].childNodes[6].childNodes[7].value;
// 				console.log(productNo);

				if(category == 1){
					location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo + '&page=' + ${pi.currentPage};
				}else if(category == 2){
					location.href='${contextPath}/selectCommuBoard.co?bNo=' + boardNo + '&writer=' + writer + '&page=' + ${pi.currentPage};
				}else{
					location.href='${contextPath}/marketBoardDetail.ma?bNo=' + boardNo  +'&boardWriter=' + writer + '&page=' + ${pi.currentPage}+'&productNo=' + productNo;
				}
			})
		}
	}
	

	$(function(){
		$('#deleteBtn').on('click',function(){
			$('.checkbox').css('display', 'block');
			$("#deleteCancel").css('display','block');
			$('#deleteBtn').text("삭제");
			$('#deleteBtn').attr("id","deleteSubmit");
			
			$('.checkbox').change(function(){
				if($(this).is(":checked")){
					const div = this.parentNode.childNodes[3];
					console.log(div);
					div.style.backgroundColor='#C0C0C0';
					div.style.opacity = '0.8';
				}else{
					const div = this.parentNode.childNodes[3];
// 					console.log(div);
					div.style.backgroundColor="";
					div.style.opacity="1";
				}
			})
			
			$('#deleteCancel').on('click',function(){
				$("#deleteCancel").css('display','none');
				$('.checkbox').css('display', 'none');
				$('#deleteSubmit').text("선택");
				$('#deleteSubmit').attr("id","deleteBtn");
				$(".checkbox").prop('checked',false);
				$('.wishListDivs').css("background","");
			});
			
			
			$('#deleteSubmit').on('click',function(){
				const checkBoxs = $('.checkbox');
				for(var i=0; i<checkBoxs.length; i++){
					if(checkBoxs[i].checked ==true){
						const boardNo = checkBoxs[i].value;
						console.log(boardNo);
						const category = '${category}';
						location.href='${contextPath}/deleteWishList.me?boardNo=' + boardNo + '&category=' + category;
					}
				} 
			});
			
		})
	})
	
	
	</script>
	
</body>
</html>