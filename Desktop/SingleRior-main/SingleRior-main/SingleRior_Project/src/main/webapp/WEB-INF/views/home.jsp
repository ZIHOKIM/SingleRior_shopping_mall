<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		display: inline-block;
		color: rgb(47, 52, 56);
		letter-spacing: -0.3px;
		white-space: nowrap;
		text-overflow: ellipsis;
		font-size: 30px;
		line-height: 28px;
		margin-top: 20px;
	}
	.today-special-price-headerBrand{display: block; font-size: 15px; color: #828c94;}
	.today-special-price-headerName{
		margin-top: 5px;
		font-size: 20px;
		font-weight: 400;
		line-height: 17px;
		max-height: 34px;
	}
	.today-special-price-itemPrice{
		display: flex;
		align-items: center;
		flex-wrap: wrap;
		font-size: 20px;
		line-height: 23px;
		font-weight: 700;
	}
	.item-star-review{margin-right: 2px; color: #424242; font-weight: 700;}
	.item-review-count{margin-top: 5px; font-size: 13px; color: #9e9e9e; line-height: 16px; font-weight: 700;}
	.ssingssing-itemPrice{
		display: flex;
		align-items: center;
		flex-wrap: wrap;
		font-size: 17px;
		line-height: 23px;
		font-weight: 700;
	}
	.css-small-title{margin: 10px; font-size: 20px;}
	p.boardContent{
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 5; 
		-webkit-box-orient: vertical;
	}
	.boardTitle{
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 300px;
	}
	.section *:hover{cursor: pointer;}
</style>
</head>
<body>
	<header class="sticky-top">
		<div>
			<jsp:include page="common/top.jsp"/>
		</div>
	</header>
	
	<main>
		<!-- 배너 -->
		<div id="myCarousel" class="carousel carousel-dark slide" data-bs-ride="carousel">
			<div class="container carousel-inner">
				<div class="carousel-item active">
					<c:forEach items="${ bnAttmList }" begin="0" end="0" var="bn">
						<c:if test="${ bn.imgOriginalName != '' }">
							<a href="${ contextPath }/mainBanner.main?imgKey=${bn.imgKey}"><img src="resources/uploadFiles/${ bn.imgRename }" style="width: 100%; height: 300px;"></a>
						</c:if>
					</c:forEach>
				</div>
				<c:forEach items="${ bnAttmList }" begin="1" end="2" var="bn">
					<c:if test="${ bn.imgOriginalName != '' }">
						<div class="carousel-item">
							<a href="${ contextPath }/mainBanner.main?imgKey=${bn.imgKey}"><img src="resources/uploadFiles/${ bn.imgRename }" style="width: 100%; height: 300px;"></a>
						</div>
					</c:if>
				</c:forEach>
			</div>
			
			<button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
  		
  		<br><br>
  		
  		<!-- 인기 상품 -->
  		<div class="container d-flex flex-wrap css-title">
  			<div>
  				<p class="px-4">인기 상품
  			</div>
  		</div>
  		
  		<div id="today_special_price" class="carousel carousel-dark slide" data-bs-ride="true">
			<div class="carousel-inner">
				<div class="carousel-item active" data-bs-interval="10000">
					<div class="album py-3">
			  			<div class="container">
			  				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3 p-2 px-4">
			  					<c:forEach items="${ pdList }" begin="0" end="3" var="p">
			  						<div class="col section1 section">
				  						<div class="card shadow-sm">
				  							<c:forEach items="${ pdAttmList }" var="pa">
												<c:if test="${ p.boardNo eq pa.imgKey }">
													<c:if test="${ pa.imgOriginalName != '' }">
														<img src="resources/uploadFiles/${ pa.imgRename }" style="width: 100%; height: 225px;">
													</c:if>
												</c:if>
											</c:forEach>
					  						<div class="card-body boardTitle">
					  							<span class="today-special-price-headerBrand">${ p.brand }</span>
					  							<span class="today-special-price-headerName">${ p.boardTitle }</span>
					  							<span class="today-special-price-itemPrice">
					  								<span class="item-sale">${ p.discount }</span>
					  								<span class="percentage">% &nbsp;</span>
					  								<fmt:formatNumber type="number" maxFractionDigits="3" value="${p.price}" var="commaPrice"/>
					  								<c:set var="discountPrice" value="${ p.price-(p.price*p.discount/100)}"/>
													<fmt:formatNumber type="number" maxFractionDigits="3" value="${ p.price-(p.price*p.discount/100)}" var="totalPrice" />
					  								<span class="item-price" style="color: #008cd4;">${ totalPrice } 원</span>
					  								<input type="hidden" class="PNo" value="${ p.productNo }">
					  								<input type="hidden" class="BNo" value="${ p.boardNo }">
					  							</span>
					  							<div class="today-special-price-review">
					  								<svg xmlns="http://www.w3.org/2000/svg" style="color: #008cd4;" width="13" height="13" style="margin-bottom: 3px;" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
					  									<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
													</svg>
					  								<span class="item-star-review">${ p.reviewRating }</span>
					  								<span class="item-review-count">리뷰 ${ p.reviewCount }</span>
					  							</div>
					  						</div>
				  						</div>
				  					</div>
			  					</c:forEach>
			  				</div>
			  			</div>
			  		</div>
				</div>
				
				<div class="carousel-item">
					<div class="album py-3">
			  			<div class="container">
			  				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3 p-2 px-4">
			  					<c:forEach items="${ pdList }" begin="4" end="7" var="p">
			  						<div class="col section section2">
				  						<div class="card shadow-sm">
				  							<c:forEach items="${ pdAttmList }" var="pa">
												<c:if test="${ p.boardNo eq pa.imgKey }">
													<c:if test="${ pa.imgOriginalName != '' }">
														<img src="resources/uploadFiles/${ pa.imgRename }" style="width: 100%; height: 225px;">
													</c:if>
												</c:if>
											</c:forEach>
					  						<div class="card-body">
					  							<span class="today-special-price-headerBrand">${ p.brand }</span>
					  							<span class="today-special-price-headerName">${ p.boardTitle }</span>
					  							<span class="today-special-price-itemPrice">
					  								<span class="item-sale">${ p.discount }</span>
					  								<span class="percentage">% &nbsp;</span>
					  								<fmt:formatNumber type="number" maxFractionDigits="3" value="${p.price}" var="commaPrice"/>
					  								<c:set var="discountPrice" value="${ p.price-(p.price*p.discount/100)}"/>
													<fmt:formatNumber type="number" maxFractionDigits="3" value="${ p.price-(p.price*p.discount/100)}" var="totalPrice" />
					  								<span class="item-price" style="color: #008cd4;">${ totalPrice } 원</span>
					  								<input type="hidden" class="PNo" value="${ p.productNo }">
					  								<input type="hidden" class="BNo" value="${ p.boardNo }">
					  							</span>
					  							<div class="today-special-price-review">
					  								<svg xmlns="http://www.w3.org/2000/svg" style="color: #008cd4;" width="13" height="13" style="margin-bottom: 3px;" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
					  									<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
													</svg>
					  								<span class="item-star-review">${ p.reviewRating }</span>
					  								<span class="item-review-count">리뷰 ${ p.reviewCount }</span>
					  							</div>
					  						</div>
				  						</div>
				  					</div>
			  					</c:forEach>
			  				</div>
			  			</div>
			  		</div>
				</div>
			</div>
			
			<button class="carousel-control-prev" type="button" data-bs-target="#today_special_price" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#today_special_price" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		
		<br><br>
  		
  		<!-- 씽씽마켓 -->
  		<div class="container d-flex flex-wrap css-title">
  			<div>
  				<p class="px-4">씽씽마켓
  			</div>
  		</div>
  		
  		<div id="ssingssing" class="carousel carousel-dark slide" data-bs-ride="true">
			<div class="carousel-inner">
				<div class="carousel-item active" data-bs-interval="10000">
					<div class="album">
			  			<div class="container mt-4 mb-4">
			  				<div class="row px-4">
			  					<c:forEach items="${ marketList }" begin="0" end="1" var="m">
			  						<div class="col-md-6 section section3">
				  						<div class="row g-0 border rounded overflow-hidden flex-md-row shadow-sm h-md-250 position-relative">
				  							<div class="col p-4 d-flex flex-column position-static" style="height: 250px;">
				  								<h3 class="mb-0 boardTitle">${ m.boardTitle }</h3>
				  								<div class="mt-2 mb-2">
				  									<span class="ssingssing-itemPrice">${ m.marketPrice } 원</span>
				  								</div>
				  								<p class="card-text mb-auto boardContent" style="overflow: hidden;">${ m.boardContent }</p>
				  								<input type="hidden" class="marketBNo" value="${ m.boardNo }">
				  								<input type="hidden" class="marketWriter" value="${ m.nickName }">
				  							</div>
				  							<c:forEach items="${ marketAttmList }" var="ma">
				  								<c:if test="${ m.boardNo eq ma.imgKey }">
													<c:if test="${ ma.imgOriginalName != '' }">
														<img src="resources/uploadFiles/${ ma.imgRename }" style="width: 250px; height: 250px;">
													</c:if>
												</c:if>
				  							</c:forEach>
				  						</div>
				  					</div>
			  					</c:forEach>
			  				</div>
			  			</div>
			  		</div>
				</div>
				
				<div class="carousel-item">
					<div class="album">
			  			<div class="container mt-4 mb-4">
			  				<div class="row px-4">
			  					<c:forEach items="${ marketList }" begin="2" end="3" var="m">
			  						<div class="col-md-6 section section4">
				  						<div class="row g-0 border rounded overflow-hidden flex-md-row shadow-sm h-md-250 position-relative">
				  							<div class="col p-4 d-flex flex-column position-static" style="height: 250px;">
				  								<h3 class="mb-0 boardTitle">${ m.boardTitle }</h3>
				  								<div class="mt-2 mb-2">
				  									<span class="ssingssing-itemPrice">${ m.marketPrice } 원</span>
				  								</div>
				  								<p class="card-text mb-auto boardContent" style="overflow: hidden;">${ m.boardContent }</p>
				  								<input type="hidden" class="marketBNo" value="${ m.boardNo }">
				  								<input type="hidden" class="marketWriter" value="${ m.nickName }">
				  							</div>
				  							<c:forEach items="${ marketAttmList }" var="ma">
				  								<c:if test="${ m.boardNo eq ma.imgKey }">
													<c:if test="${ ma.imgOriginalName != '' }">
														<img src="resources/uploadFiles/${ ma.imgRename }" style="width: 250px; height: 250px;">
													</c:if>
												</c:if>
				  							</c:forEach>
				  						</div>
				  					</div>
			  					</c:forEach>
			  				</div>
			  			</div>
			  		</div>
				</div>
			</div>
			
			<button class="carousel-control-prev" type="button" data-bs-target="#ssingssing" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#ssingssing" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		
		<br><br>
		
		<!-- 싱글벙글 -->
  		<div class="container d-flex flex-wrap css-title">
  			<div>
  				<p class="px-4">싱글벙글
  			</div>
  		</div>
  		
  		<div class="container">
  			<div class="row px-4 mt-4">
  				<c:forEach items="${ commuList }" begin="0" end="1" var="c">
  					<div class="col-md-6 section5 section">
				  		<div class="row g-0 border rounded overflow-hidden flex-md-row shadow-sm h-md-250 position-relative mt-2 mb-4">
				  			<c:forEach items="${ commuAttmList }" var="ca">
								<c:if test="${ c.boardNo eq ca.imgKey }">
									<c:if test="${ ca.imgOriginalName != '' }">
										<img src="resources/uploadFiles/${ ca.imgRename }" style="width: 250px; height: 250px;">
									</c:if>
								</c:if>
							</c:forEach>
				  			<div class="col p-4 d-flex flex-column position-static" style="height: 250px;">
				  				<h4 class="mb-1 boardTitle">${ c.boardTitle }</h4>
				  				<div class="mb-1 text-muted">${ c.createDate }</div>
				  				<input type="hidden" class="commuBNo" id="commuBNo" value="${ c.boardNo }">
				  				<input type="hidden" class="commuWriter" value="${ c.nickName }">
				  				<p class="card-text mb-auto boardContent" style="overflow: hidden;">${ c.boardContent }</p>
				  			</div>
				  		</div>
				  	</div>
  				</c:forEach>
			</div>
  		</div>
	</main>
	
	<footer>
		<jsp:include page="common/footer.jsp"/>
	</footer>
	
	<script>
		window.onload = () => {
			const st1 = document.getElementsByClassName('section1');
			for(const div of st1){
				div.addEventListener('click', function(){
					const productNo = this.querySelector('.PNo').value;
					const boardNo = this.querySelector('.BNo').value;
					location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo;
				});
			}
			
			const st2 = document.getElementsByClassName('section2');
			for(const div of st2){
				div.addEventListener('click', function(){
					const productNo = this.querySelector('.PNo').value;
					const boardNo = this.querySelector('.BNo').value;
					location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo;
				});
			}
			
			const st3 = document.getElementsByClassName('section3');
			for(const div of st3){
				div.addEventListener('click', function(){
					const boardNo = this.querySelector('.marketBNo').value;
					const writer = this.querySelector('.marketWriter').value;
					location.href='${contextPath}/marketBoardDetail.ma?bNo=' + boardNo + '&boardWriter=' + writer;
				});
			}
			
			const st4 = document.getElementsByClassName('section4');
			for(const div of st4){
				div.addEventListener('click', function(){
					const boardNo = this.querySelector('.marketBNo').value;
					const writer = this.querySelector('.marketWriter').value;
					location.href='${contextPath}/marketBoardDetail.ma?bNo=' + boardNo + '&boardWriter=' + writer;
				});
			}
			
			const st5 = document.getElementsByClassName('section5');
			for(const div of st5){
				div.addEventListener('click', function(){
					const boardNo = this.querySelector('.commuBNo').value;
					const writer = this.querySelector('.commuWriter').value;
					location.href='${contextPath}/selectCommuBoard.co?bNo=' + boardNo + '&writer=' + writer;
				});
			}
			
			
			var result = "${result}";
			console.log(result);
			if(result >0) {
				alert("회원가입이 완료되었습니다. 로그인 해주세요");
			}
		}
		
	</script>
</body>
</html>