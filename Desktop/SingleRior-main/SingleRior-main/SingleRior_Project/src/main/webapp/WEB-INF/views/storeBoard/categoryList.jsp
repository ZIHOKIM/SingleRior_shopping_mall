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
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<style>
	.front{margin: 10px 300px}
	.pagination{justify-content: center;}
	
</style>
<body>
	<header class="sticky-top">
		<div>
			<jsp:include page="../storeBoard/navbar.jsp"/>
		</div>
	</header>
	
	<!-- 대분류/소분류 구분 -->
    <%--   ${ sList }  --%>
	<%--  ${ aList }   --%> 
	
	<div class="front">
		<h5><b> 전체 >  ${ topCateName } <c:if test="${empty topCate}"> > ${ subCateName }  </c:if></b></h5>
			<h3><b><c:if test="${empty topCate}"> ${ subCateName } </c:if></b></h3>
		
		<div id="selectOption" dir="rtl">
			<select style="width:100px; height:30px;" name="category">
			  <option value="인기순"<c:if test="${category == '인기순'}">selected</c:if>>인기순</option>
			  <option value="신상품순" <c:if test="${category == '신상품순'}">selected</c:if>>신상품순</option>
			  <option value="낮은가격순" <c:if test="${category == '낮은가격순'}">selected</c:if>>낮은 가격순</option>
			  <option value="높은가격순" <c:if test="${category == '높은가격순'}">selected</c:if>>높은 가격순</option>
			</select>
		</div>
		<br>
	
	<!-- 상품카드 12개 -->
	<div class="album py-5 bg-light">
		<div class="container">		
		 <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
		 <c:if test="${!empty sList }">
			 <c:forEach items="${ sList }" var="s" varStatus="status">
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${s.price}" var="commaPrice" />
					<c:set var="discountPrice" value="${ s.price-(s.price*s.discount/100)}"/>
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${ s.price-(s.price*s.discount/100)}" var="totalPrice" />
				    <div class="col-3">
				      <div class="card" style="cursor:pointer">
						    <img src="resources/uploadFiles/${ aList[status.index].imgRename }" width="100%" height="255">
					     	   	<%-- <c:if test="${ s.boardNo ne a.imgKey }"> 
					        		<img src="resources/image/SingleRior_logo.png" width="100%" height="255"> 
						     	</c:if>  --%>
				         <div class="card-body">
				          <h6 class="card-title">${ s.brand } </h6>
				          <h5 class="card-text">${ s.boardTitle }</h5>
				          <span><s>${ commaPrice }</s>원</span><br>
				          <span style="width:20px">${ s.discount }%</span><span>　</span><span style="color:#008cd4; font-size: 25px;">${ totalPrice } 원</span><br>
				          <span>★${ s.reviewRating }&nbsp;&nbsp;&nbsp;♥${ s.wishListCount }</span>
				          <input type="hidden" value="${ s.productNo }" name="productNo">
				          <input type="hidden" value="${ s.boardNo }" name="boardNo">
				        </div>
				      </div>
				    </div>
				 </c:forEach>
			 </c:if>
			 <c:if test="${empty sList }">
			 <div>아직 등록된 상품이 없습니다.</div>
			 </c:if>
		</div>
	</div>
	<br><br>
	</div></div>
    
    <!-- 페이징 -->
     <c:if test="${!empty sList }">
	<nav aria-label="Standard pagination example" style="background:white" >
		<ul class="pagination">
		<c:if test="${ pi.currentPage > 1 }">
			<li class="page-item">
					<c:url var="goBack" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
						<c:if test="${ !empty subCate }">
						<c:param name="subCate" value="${ subCate }"></c:param>
						</c:if>
						<c:if test="${ !empty category }">
						<c:param name="category" value="${ category }"></c:param>
						</c:if>
						<c:if test="${ !empty topCate }">
						<c:param name="topCate" value="${ topCate }"></c:param>
						</c:if>
					</c:url>
					<a class="page-link" href="${ goBack }" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
	 				</a>
			</li>
			</c:if>
			<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
				<c:url var="goNum" value="${ loc }">
					<c:param name="page" value="${ p }"></c:param>
						<c:if test="${ !empty subCate }">
						<c:param name="subCate" value="${ subCate }"></c:param>
						</c:if>
						<c:if test="${ !empty category }">
						<c:param name="category" value="${ category }"></c:param>
						</c:if>
						<c:if test="${ !empty topCate }">
						<c:param name="topCate" value="${ topCate }"></c:param>
						</c:if>
				</c:url>
					<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
				</c:forEach>
				<c:if test="${ pi.currentPage < pi.maxPage }">
				<li class="page-item">
					<c:url var="goNext" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
						<c:if test="${ !empty subCate }">
						<c:param name="subCate" value="${ subCate }"></c:param>
						</c:if>
						<c:if test="${ !empty category }">
						<c:param name="category" value="${ category }"></c:param>
						</c:if>
						<c:if test="${ !empty topCate }">
						<c:param name="topCate" value="${ topCate }"></c:param>
						</c:if>
					</c:url>
					<a class="page-link" href="${ goNext }" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
     			</li>
     			</c:if>
 			</ul>
    	</nav>
	 	</c:if>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>  	

<script>
    window.onload=()=>{
    	const cards = document.getElementsByClassName('card');
    	//console.log(cards);
    	for(const div of cards){
    		div.addEventListener('click', function(){
    			const productNo = this.querySelectorAll('input')[0].value;
    			const boardNo = this.querySelectorAll('input')[1].value;
    			 console.log(productNo); 
    			 console.log(boardNo); 
    			 location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo;
    		});
    	}
    	
    }
    
		$(function(){
		
		$('select[name=category]').change(function(){
			
			category = $('select[name=category]').val();
			let subCate = '${ subCate }';
			let topCate = '${topCate}';
			console.log(subCate);
			let page = '${pi.currentPage}';
			if(subCate == ""){
			location.href='${contextPath}/categoryList.st?category=' + category + '&topCate=' + topCate + '&page=';
			}else{
				location.href='${contextPath}/categoryList.st?category=' + category + '&subCate=' + subCate + '&page=';
			}
			
		});
		
	});

</script>	
</body>
</html>