<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.marketNav li a:hover {
	font-size: 20px;
}

@font-face {
	font-family: 'BMJUA';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'BMJUA';
}

.marketNav li a:hover {
	font-size: 20px;
}
</style>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">

<body>
	<header class="sticky-top">
		<div>
			<jsp:include page="../common/top.jsp" />
		</div>
	</header>
	<div style="background: #008cd4">
		<ul class="marketNav nav justify-content-center">
			<li class="nav-item"><a style="color: white;" class="nav-link active" href="marketNotiBoardList.ma?marketType=3&marketArray=${marketArray}&searchType=${searchType}&marketSear">공지</a></li>
			<li class="nav-item"><a style="color: white;" class="nav-link active" aria-current="page" href="marketBoardList.ma?marketType=1&marketArray=${marketArray}&searchType=${searchType}&marketSearch=${marketSearch}">같이사요</a></li>
			<li class="nav-item"><a style="color: white;" class="nav-link active" href="marketBoardList.ma?marketType=2&marketArray=${marketArray}&searchType=${searchType}&marketSearch=${marketSearch}">팝니다</a></li>
			<li class="nav-item"><a style="color: white;" class="nav-link active" href="marketBoardList.ma?marketType=3&marketArray=${marketArray}&searchType=${searchType}&marketSearch=${marketSearch}">삽니다</a></li>
		</ul>
	</div>
	<div id="today_special_price" class="carousel carousel-dark slide"
		data-bs-ride="true">
		<div class="carousel-inner" >
			<div class="carousel-item active" data-bs-interval="10000">
				<div class="album py-5">
					<div class="container" >
						<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 p-5 px-5" >
							<c:forEach items="${ topBList }" var="tb" begin="0" end="2" step="1">
							<div class="col px-5 p-5 g-3" >
								<div class="carouselCardSec shadow-sm" style="cursor: pointer; height: 380px">
									<c:forEach items="${ mkAList }" var="mkA" >
										<c:if test="${ tb.boardNo eq mkA.imgKey }">
											<c:if test="${ mkA.imgOriginalName != '' }">
												<img src="resources/uploadFiles/${ mkA.imgRename }" class="card-img-top" height="225">
											</c:if>	
											<c:set var="topCheck" value="true"/>	
										</c:if>
									</c:forEach>
									<c:if test="${ topCheck != 'true' }">
										<img class="bd-placeholder-img card-img-top" width="100%" height="225"  src="https://ifh.cc/g/1Lygac.png">
									</c:if>
									<c:set var="topCheck" value="false"></c:set>
									<div class="card-body"  style="padding:10px;">
									<span style=" font-size: 13px; class="card-text">${ tb.nickName }</span>
										<p class="card-text">${tb.boardTitle }</p>
										<input  id="bNo" type="hidden" value="${ tb.boardNo }">
										<input  id="writer" type="hidden" value="${ tb.writer}">
										<input id="productNo" type="hidden" value="${ tb.productNo}">
										<input type="hidden" value="${ tb.boardNo }">
										<div class="d-flex justify-content-between align-items-center">
											
											<p class="card-text" style="width: 280px;"><fmt:formatNumber value="${tb.marketPrice}" pattern="#,###"/>원</p>
											<div class="btn-group">
												<img src="https://cdn-icons-png.flaticon.com/512/2589/2589197.png"style="width: 30px; height: 30px;">${tb.likeCount }<img src="https://cdn-icons-png.flaticon.com/512/2589/2589054.png" style="width: 30px; height: 30px; display: none;">
										  &nbsp;<img src="https://cdn-icons-png.flaticon.com/512/7789/7789458.png" style="width: 30px; height: 30px;">${tb.replyCount }
											</div>
											<small class="text-muted"></small>
										</div>
									</div>
								</div>
							</div>
							</c:forEach>
							
						</div>
					</div>
				</div>
			</div>
			
<!-- 첫번째 슬라이드  끝-->

			<div class="carousel-item">
				<div class="album py-5">
					<div class="container">
						<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 p-5 px-5">
							<c:forEach items="${ topBList }" var="tb" begin="3" end="5" step="1">
							<div class="col p-5 px-5 g-3">
								<div class="carouselCardSec shadow-sm" style="cursor: pointer; height: 380px">
									<c:forEach items="${ mkAList }" var="mkA" >
									<c:if test="${ tb.boardNo eq mkA.imgKey }">
										<c:if test="${ mkA.imgOriginalName != '' }">
											<img src="resources/uploadFiles/${ mkA.imgRename }" class="card-img-top" height="225">
										</c:if>
										<c:set var="imgCheck" value="true"/>
									</c:if>
									</c:forEach>
									<c:if test="${ imgCheck != 'true' }">
										<img class="bd-placeholder-img card-img-top" width="100%" height="225"  src="https://ifh.cc/g/1Lygac.png">
									</c:if>
									<c:set var="imgCheck" value="false"></c:set>
									<div class="card-body"  style="padding:15px;">
									<span style=" font-size: 13px;" class="card-text">${ tb.nickName }</span>
										<p class="card-text">${tb.boardTitle }</p>
										<input id="bNo" type="hidden" value="${ tb.boardNo }">
										<input id="writer" type="hidden" value="${ tb.writer}">
										<input id="productNo" type="hidden" value="${ tb.productNo}">
										<input type="hidden" value="${ tb.boardNo }">
										<div class="d-flex justify-content-between align-items-center">
											<p class="card-text" style="width: 280px;"><fmt:formatNumber value="${tb.marketPrice}" pattern="#,###"/>원</p>
											<div class="btn-group">
												<img src="https://cdn-icons-png.flaticon.com/512/2589/2589197.png"style="width: 30px; height: 30px;">${tb.likeCount }<img src="https://cdn-icons-png.flaticon.com/512/2589/2589054.png" style="width: 30px; height: 30px; display: none;">
										  &nbsp;<img src="https://cdn-icons-png.flaticon.com/512/7789/7789458.png" style="width: 30px; height: 30px;">${tb.replyCount }
											</div>
											<small class="text-muted"></small>
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
		
<!-- 슬라이드 버튼 -->
		<button class="carousel-control-prev" type="button" data-bs-target="#today_special_price" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#today_special_price" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="visually-hidden">Next</span>
		</button>
	</div>
	
<!-- 두번쨰 슬라이드 끝-->
	<br>
	<br>
	
	<!-- 정렬 -->
  		<div class="row row-cols-1 row-cols-md-5 g-4" style="margin-left: 350px; margin-right: 300px;">
  			<div class="row px-1">
			  	<div class="col-md-2" style="width: 680px;">
			  		<div class="row border rounded overflow-hidden flex-md-row shadow-sm  position-relative mt-2 mb-5">
			  			<div class="col py-2 d-flex flex-column position-static px-3">
			  				<table>
			  					<tr style="text-align: center; height: 35px;">
			  						<td id="list1" >
			  							<a class="nav-link active" href="marketBoardList.ma?marketArray=0&marketType=${marketType}&searchType=${searchType}&marketSearch=${marketSearch}">
				  							<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-lg me-1" viewBox="0 0 16 16">
				  								<path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
				  							</svg>최신순
			  							</a>
			  						</td>
			  						<td id="list2" >
			  							<a class="nav-link active" href="marketBoardList.ma?marketArray=1&marketType=${marketType}&searchType=${searchType}&marketSearch=${marketSearch}">
				  							<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-lg me-1" viewBox="0 0 16 16">
				  								<path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
				  							</svg>좋아요순
			  							</a>
			  						</td>
			  						<td id="list3">
			  							<a class="nav-link active" href="marketBoardList.ma?marketArray=2&marketType=${marketType}&searchType=${searchType}&marketSearch=${marketSearch}">
				  							<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-lg me-1" viewBox="0 0 16 16">
				  								<path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
				  							</svg>댓글순
			  							</a>
			  						</td>
			  					</tr>
			  				</table>
			  				
			  			</div>
			  		</div>
			  		<c:if test="${ !empty loginUser }">
						<button type="button" class="btn btn-outline-secondary" style="width: 100px;" onclick="location.href='${contextPath}/marketBoardWrite.ma'">글쓰기</button>
			  		</c:if>
			  	</div>
			</div>
  		</div>
  		
<br>
<br>
<br>
<!-- 글 리스트 -->	
	<div class="row row-cols-1 row-cols-md-4 g-4" style="margin-left: 350px; margin-right: 350px;">
		<c:forEach items="${ mkBList }" var="mkB">
		<div class="col px-4">
			<div class="cards shadow-sm" style="cursor: pointer; height: 380px;">
			<c:forEach items="${ mkAList }" var="mkA">
			<c:if test="${ mkB.boardNo eq mkA.imgKey }">
				<c:if test="${ a.originalName != '' }">
					<img src="resources/uploadFiles/${ mkA.imgRename }" class="card-img-top" height="225">
				</c:if>
				<c:set var="listCheck" value="true"/>
			</c:if>
			</c:forEach>
			<c:if test="${ listCheck !='true' }">
				<img class="bd-placeholder-img card-img-top" width="100%" height="225"  src="https://ifh.cc/g/1Lygac.png">
			</c:if>
			<c:set var="listCheck" value="false"></c:set>
				<div class="card-body" style="padding:15px;">
				<span style="font-size: 13px;" class="card-text">${ mkB.nickName }</span>
					<p class="card-text" style="font-size: 18px;">${ mkB.boardTitle }</p>
					<input id="bNo" type="hidden" value="${ mkB.boardNo }">
					<input id="writer" type="hidden" value="${ mkB.writer}">
					<input id="productNo" type="hidden" value="${ mkB.productNo}">
					<div class="d-flex justify-content-between align-items-center">
						<p class="card-text" style="width: 280px;"><fmt:formatNumber value="${mkB.marketPrice}" pattern="#,###"/>원</p>
						<div class="btn-group">
							<img src="https://cdn-icons-png.flaticon.com/512/2589/2589197.png" style="width: 30px; height: 30px;">${mkB.likeCount}&nbsp;&nbsp;
							<img src="https://cdn-icons-png.flaticon.com/512/7789/7789458.png" style="width: 30px; height: 30px;">${mkB.replyCount}
						</div>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
		<br>
		<br>
	</div>
	   <div style="padding-top: 100px;">
	    <ul class="pagination" style="justify-content: center;">
		<c:if test="${ pi.currentPage > 1 }">
			<li class="page-item"><c:url var="goBack" value="${ loc }">
				<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
				</c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span></a>
			</li>
		</c:if>
		<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
		<c:url var="goNum" value="${ loc }">
		<c:param name="page" value="${ p }"></c:param>
		</c:url>
		<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
		</c:forEach>
		<c:if test="${ pi.currentPage < pi.maxPage }">
			<li class="page-item"><c:url var="goNext" value="${ loc }">
				<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
				</c:url> <a class="page-link" href="${ goNext }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
			</li>
		</c:if>
		</ul>
		</div>		        	
				        	
	        
	 <div class="py-4">
	 			<form role="search" action="${ contextPath }/marketBoardList.ma">
	        	<table class="mx-auto">
		        	<tr>
		        		<td>
				        	<select name="searchType" class="form-select form-select-sm" aria-label=".form-select-sm example" style="width: 120px; text-align: center;">
				        		<option value="0">전체</option>
				        		<option value="1">제목</option>
				        		<option value="2">내용</option>
				        		<option value="3">작성자</option>
				        	</select>
		        		</td>
		        		<td >
				        	<div class="d-flex">
				        		<input class="form-control me-2" style="width: 300px;" type="search" placeholder="Search" name="marketSearch" aria-label="Search">
				        		<input type="hidden" name="page" value="${ pi.currentPage }">
	        					<input type="hidden" name="marketType" value="${mkBoard.marketType }">
	        					<input type="hidden" name="marketArray" value="${mkBoard.marketArray}">
				        		<button class="btn btn-outline-primary" type="submit">검색</button>
				        	</div>
				        </td>
				    </tr>
		        </table>
		        </form>
	    </div>
	
	<footer>
		<jsp:include page="../common/footer.jsp" />
	</footer>
</body>
<script>

	window.onload = () => {
		
		//공지글 상세페이지
		const trs1 = document.querySelectorAll('.notiList');
		for(const tr of trs1){
			tr.addEventListener('click', function(){
				const bNo = this.querySelectorAll('input')[0].value;
				const writer = this.querySelectorAll('input')[1].value;
				location.href='${contextPath}/selectNotiBoard.no?bNo=' + bNo + '&writer=' + writer;
			});
		}
		
		
		
		//첫번째 슬라이드 상세페이지
		const fiRcards = document.getElementsByClassName('carouselCardFir');
		
		for(const card of fiRcards){
			const wish = this.querySelector('span')
				wish.addEventListener('click', function() {
				location.href='${contextPath}/marketBoardLike.ma?bNo=' + bNo;
			});
			card.addEventListener('click', function() {
				const bNo = this.querySelector('#bNo').value;
				const boardWriter = this.querySelector('#writer').value;
				const productNo = this.querySelector('#productNo').value;
				location.href='${contextPath}/marketBoardDetail.ma?bNo=' + bNo +'&boardWriter=' + boardWriter  +'&productNo=' + productNo;
			});
		}
		
		//두번째 슬라이드 상세페이지
		const secCards = document.getElementsByClassName('carouselCardSec');
		for(const card of secCards){
			card.addEventListener('click', function() {
				const bNo = this.querySelector('#bNo').value;
				const boardWriter = this.querySelector('#writer').value;
				const productNo = this.querySelector('#productNo').value;
				location.href='${contextPath}/marketBoardDetail.ma?bNo=' + bNo  +'&boardWriter=' + boardWriter +'&productNo=' + productNo;
			});
		}
		
		//게시글 상세페이지
		const cards = document.getElementsByClassName('cards');
		for(const card of cards){
			card.addEventListener('click', function() {
				const bNo = this.querySelector('#bNo').value;
				const boardWriter = this.querySelector('#writer').value;
				const productNo = this.querySelector('#productNo').value;
				location.href='${contextPath}/marketBoardDetail.ma?bNo=' + bNo +'&boardWriter=' + boardWriter +'&productNo=' + productNo;
			});
		}
	}

</script>
</html>