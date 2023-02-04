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
<script src="${ contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<style>
	section{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
	
	}
	
	#navReview{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
		font-size:30px;
		cursor:pointer;
	}
	table{
		word-break:break-all;
	}
	tr{font-size:20px;}
 	.reviewContent div{margin:auto; display:inline-block; width:355px; text-align:center; font-size:20px;}
 	img:hover{cursor:pointer;}
 	
 	.star {
	position: relative;
	font-size: 2rem;
	color: #ddd;
	}
	.star input {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	opacity: 0;
	cursor: pointer;
	}
	
	.star span {
	width: 0;
	position: absolute;
	left: 0;
	color: #008cd4;
	overflow: hidden;
	pointer-events: none;
	}
	
	.starView {
	position: relative;
	font-size: 2rem;
	color: #ddd;
	}
	
	.starView input {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	opacity: 0;
	cursor: pointer;
	}
	
	.starView span {
	width: 0;
	position: absolute;
	left: 0;
	color: #008cd4;
	overflow: hidden;
	pointer-events: none;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<nav class="navbar navbar-expand-lg" id="navReview">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
				<div class="navbar-nav">
					<span class="nav-link active" aria-current="page" style="color:#008cd4" onclick="location.href='${contextPath}/myReviewDoneList.me'">내가 작성한 리뷰</span> 
					<span class="nav-link" onclick="location.href='${contextPath}/myReviewNDoneList.me'">작성 가능한 리뷰</span>
				</div>
			</div>
		</div>
	</nav>
	<section>
		<c:if test="${ !empty orList }">
			<c:forEach items="${ orList }" var="o" varStatus="r">
				<form method="POST" class="reviewForm">
					<div class="orderCancelProduct done">
						주문번호 : <span>${fn:replace(o.orderDate, '-', '')}${o.orderNo }</span>&nbsp;&nbsp;&nbsp;
						주문일자 : <span>${ o.orderDate }</span>&nbsp;&nbsp;&nbsp;
						<input type="hidden" name="orderDetailNo" value="${ o.orderDetailNo }">
						<table class="table">
						    <tr>
						      <td scope="row" colspan="4"></td>
						    </tr>
						    <tr height="15">
						    	<td scope="row" width="250" rowspan="2" class="trReview">
						    		<img src="${ contextPath }/resources/uploadFiles/${o.imgRename}" width="160" class="img">
						    		<input type="hidden" name="productNo" value="${o.productNo}">
						    		<input type="hidden" name="boardNo" value="${o.boardNo}">
						    		<input type="hidden" name="reviewNo" value="${rList[r.index].reviewNo}">
						    		<input type="hidden" name="orderNo" value="${o.orderNo}">
						    	</td>
						     	<td width="400">상품</td>
						      	<td>옵션</td>
						      	<td>상품 금액</td>
						   	</tr>
						   	<tr>
						     	<td height='100'>
						      		<div>${o.boardTitle}</div>
						      	</td>
						      	<td>
									<div>${o.productOption}</div>		      
									<div>수량 : ${o.productQuantity}</div>   
						      	</td>
						      	<td>
						      		<div><fmt:formatNumber value="${o.salePrice}" pattern="#,###"/>원</div>
						      	</td>
						   	</tr>
						</table>
						<div class="reviewContent">
							<div>별점 : 
								<c:if test="${rList[r.index].reviewRating == 0}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="0"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 0.5}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="1"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 1}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="2"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 1.5}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="3"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 2}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="4"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 2.5}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="5"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 3}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="6"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 3.5}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="7"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 4}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="8"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 4.5}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="9"></span></c:if>
								<c:if test="${rList[r.index].reviewRating == 5}"><span class="starView">★★★★★<span>★★★★★</span><input class="starViewValue" type="range" value="10"></span></c:if>
							</div>
							<div style="width:200px">구매후기 :  <span>${rList[r.index].reviewContent}</span></div>
								<div class="what">
								<c:forEach items="${ attmList }" var="a">
									<c:if test="${ rList[r.index].reviewNo eq a.imgKey }">
										<c:if test="${ a.imgOriginalName != '' }">
						 			   		<img class="reviewImg" src="resources/uploadFiles/${ a.imgRename }" width="200" height="200">
						 			   		<input type="hidden" name="img" value="resources/uploadFiles/${ a.imgOriginalName }">
					 			    	</c:if>
									</c:if>
								</c:forEach>
				 			    </div>
			 			    <div style="width: 200px;">
			 			    	<button type="button" class="btn btn-light updateReview" style="background:#008cd4; color:white;" data-bs-toggle="modal" data-bs-target="#updateReviewModal">수정</button>
			 			    	<button type="button" class="btn btn-light" style="background:#008cd4; color:white;" data-bs-toggle="modal" data-bs-target="#deleteReviewModal">삭제</button>
			 			    </div>
						</div>
						<hr>
						<br><br><br><br>
					</div>
				</form>
			</c:forEach>
		</c:if>
		<c:if test="${ empty orList }">
			<div class="alert alert-secondary" role="alert">
  				작성하신 리뷰가 없습니다.
			</div>
		</c:if>
		<c:if test="${ !empty orList }">
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
				
		<!--  리뷰 수정 모달 -->	
		<div class="modal fade" id="updateReviewModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<form action="${ contextPath }/updateReview.me" method="post" enctype="multipart/form-data">
							<div class="modal-header">
								<h3 style="color:#008cd4">리뷰를 수정합니다.</h3>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div style="text-align: center;">
									<span class="star">
										★★★★★
										<span>★★★★★</span>
										<input id="reviewRating" type="range" oninput="drawStar(this)" value="1" step="1" min="0" max="10">
										<input type="hidden" name="reviewRating" id="starNum">
										<input type="hidden" name="orderDetailNo" id="orderDetailNo">
										<input type="hidden" name="orderNo" id="orderNo">
										<input type="hidden" name="productNo" id="productNo">
										<input type="hidden" name="boardNo" id="boardNo">
										<input type="hidden" name="reviewNo" id="reviewNo">
									</span>
								</div>
								<div class="mb-3">
  									<label for="formFile" class="form-label">제품의 사진을 올려주세요.</label>
  									<input class="form-control" type="file" id="file" name="file">
								</div>
								<div>
									<span id="oriImgName"></span>&nbsp;&nbsp;<button type="button" class="btn btn-outline-dark btn-sm" id="deleteAttm" style="display: none;">삭제 X</button>
									<input type="hidden" name="deleteAttm">
								</div>
								<div class="pt-2">
									<textarea class="form-control" placeholder="여러분의 리뷰를 작성해주세요." id="reviewContent" name="reviewContent" style="height: 300px; resize:none;"></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-light" data-bs-dismiss="modal">창 닫기</button>
								<button type="submit" class="btn btn-outline-light" style="background:#008cd4; color:white" id="reviewSubmit">리뷰 수정하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			
			
		<!-- 리뷰 삭제 모달창 -->
	<div class="modal" tabindex="-1" id="deleteReviewModal">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	     		 <div class="modal-header">
	       		 <h5 class="modal-title">리뷰 삭제</h5>
	       		 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	    	  </div>
	    	  <div class="modal-body">
	      		  <p>삭제된 게시물은 복구할 수 없습니다.</p>
	     	 </div>
			 <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
				<button type="button" class="btn btn-light deleteReview" style="background:#008cd4; color:white">리뷰 삭제</button>
	     	 </div>
	    </div>
	  </div>
	</div>		
	</section>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
		<script>
	window.onload = () =>{
		var imgs = document.getElementsByClassName("img");
		console.log(imgs);
		for(img of imgs){
			img.addEventListener('click',function(){
				const productNo= this.parentNode.childNodes[3].value;
				const boardNo = this.parentNode.childNodes[5].value;
				console.log(boardNo);
				
				location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo + '&page=' + ${pi.currentPage};
			})
		}
		
	}
	
	// 별점 뿌리기
//	console.log(document.querySelectorAll('.starViewValue').length);
	var starViewValueCount = document.querySelectorAll('.starViewValue').length;
//	console.log(starViewValueCount);
	
	var starViewValue = document.querySelectorAll('.starViewValue');
	var num = 0;
	for(const i of starViewValue){
//		console.log(i.value);
		document.querySelectorAll('.starView span')[num].style.width = i.value * 10 + '%';
		num += 1;
	}
	
	// 리뷰 수정
	$(document).on('click', ".updateReview", function(){
		// 원래 정보 화면에 뿌리기
		var reviewRating = this.parentNode.parentNode.querySelectorAll('input')[0].value;
		var reviewContent = this.parentNode.parentNode.querySelectorAll('span')[2].innerText;
		var orderDetailNo = this.parentNode.parentNode.parentNode.querySelector('input[type="hidden"]').value;
		var orderNo = this.parentNode.parentNode.parentNode.querySelectorAll('input[type="hidden"]')[4].value;
		var productNo = this.parentNode.parentNode.parentNode.querySelectorAll('input[type="hidden"]')[1].value;
		var boardNo = this.parentNode.parentNode.parentNode.querySelectorAll('input[type="hidden"]')[2].value;
		var reviewNo = this.parentNode.parentNode.parentNode.querySelectorAll('input[type="hidden"]')[3].value;
		
		if(this.parentNode.parentNode.querySelector('.reviewImg') != null){
			var oriImg = this.parentNode.parentNode.querySelectorAll('input[type="hidden"]')[0].value;
			var oriImgName = oriImg.split('/')[2];
			
			document.getElementById("oriImgName").innerText = "등록된 사진 : " + oriImgName;
			
			document.getElementById("deleteAttm").style.display = 'block';
		} else {
			document.getElementById("oriImgName").innerText = "";
			document.getElementById("deleteAttm").style.display = 'none';
		}
		
//		console.log("원래 별점 : " + reviewRating);
//		console.log("원래 내용 : " + reviewContent);
//		console.log("orderDetailNo : " + orderDetailNo);
//		console.log("orderNo : " + orderNo);
//		console.log("productNo : " + productNo);
//		console.log("boardNo : " + boardNo);
//		console.log("reviewNo : " + reviewNo);
//		console.log("oriImg : " + oriImg);
//		console.log("oriImgName : " + oriImgName);
		
		document.getElementById("reviewRating").value = reviewRating;
		document.getElementById("starNum").value = reviewRating/2;
		document.querySelector('.star span').style.width = document.querySelector('#reviewRating').value * 10 + '%';
		
		document.getElementById("reviewContent").innerText = reviewContent;
		
		document.getElementById("orderDetailNo").value = orderDetailNo;
		document.getElementById("orderNo").value = orderNo;
		document.getElementById("productNo").value = productNo;
		document.getElementById("boardNo").value = boardNo;
		document.getElementById("reviewNo").value = reviewNo;
		
//		console.log(document.getElementById("orderDetailNo").value);
//		console.log(document.getElementById("orderNo").value);
//		console.log(document.getElementById("productNo").value);
//		console.log(document.getElementById("boardNo").value);
//		console.log(document.getElementById("reviewNo").value);
		
		if(($('#deleteAttm').text() === "삭제 X") && ($('#deleteAttm').css('display') === 'none')){ // 원래 리뷰 사진이 없는 경우 -> 사진 첨부 가능
			document.getElementById("file").removeAttribute('disabled');
		} else if($('#deleteAttm').text() === "삭제 X") { // 원래 리뷰 사진이 존재 -> 사진 첨부 불가
			document.getElementById("file").setAttribute('disabled', true);
		}
		
//		console.log($('#deleteAttm').css('display') === 'none');
//		console.log($('#deleteAttm').text() === '삭제 X');
		
		document.getElementById("deleteAttm").addEventListener('click', function(){
			const nextHidden = this.nextElementSibling;
			if(nextHidden.value == ''){ // 삭제 버튼을 누르지 않은 상태(삭제 X)
				this.style.background = 'black';
				this.style.color = 'white';
				this.innerText = '삭제 O';
				nextHidden.value = 0;
				document.getElementById("file").removeAttribute('disabled');
			} else { // 삭제 버튼이 눌린 상태라면(삭제 O)
				this.style.background = 'none';
				this.style.color = 'black';
				this.innerText = '삭제 X';
				nextHidden.removeAttribute('value');
				document.getElementById("file").setAttribute('disabled', true);
			}
		});
	});
	
	const drawStar = (target) => {
		document.querySelector('.star span').style.width = target.value * 10 + '%';
	}
	
	document.getElementById("reviewRating").addEventListener('input', e=>{
		document.querySelector('#starNum').value = e.target.value/2;
//		console.log(document.querySelector('#starNum').value);
	});
	
	// 리뷰 삭제
	$(document).on('click', ".deleteReview", function(){
		var reviewForm = this.parentNode.parentNode.parentNode.parentNode.parentNode.querySelector('form');
//		console.log(reviewForm);
		
		reviewForm.action = '${contextPath}/deleteReview.me';
		reviewForm.submit();
	});
	</script>
</body>
</html>