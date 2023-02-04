<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> 
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style>
	.front{margin: 10px 180px;}
	.topCateCard{cursor:pointer}
</style>
</head>
<body>
	<header class="sticky-top">
		<div>
			<jsp:include page="../storeBoard/navbar.jsp"/>
		</div>
	</header>

	<!-- 카드 카테고리 -->
	<div class="front">
		<div class="row justify-content-md-center">
		   <!--  <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 my-5"> -->
		      <div class="col">
		        <div class="topCateCard card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" style="background-image: url('https://image.ohou.se/i/bucketplace-v2-development/uploads/productions/164274787851855426.jpg?gif=1&w=640&h=640&c=c&webp=1');">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
		            <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">가구</h3>
		            <input type="hidden" value="1" name="topCate">
		          </div>
		        </div>
		      </div>
		
		      <div class="col">
		        <div class="topCateCard card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" style="background-image: url('https://image.ohou.se/i/bucketplace-v2-development/uploads/productions/166331034231700593.jpg?gif=1&w=640&h=640&c=c&webp=1');">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
		            <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">페브릭</h3>
		            <input type="hidden" value="2" name="topCate">
		            <ul class="d-flex list-unstyled mt-auto">
		            </ul>
		          </div>
		        </div>
		      </div>
		
		      <div class="col">
		        <div class="topCateCard card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" style="background-image: url('https://cdn.ggumim.co.kr/cache/furniture/600/20211130171519S0Fch44mwj.jpg');">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1">
		            <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">인테리어 소품</h3>
		            <input type="hidden" value="3" name="topCate">
		            <ul class="d-flex list-unstyled mt-auto">
		            </ul>
		          </div>
		        </div>
		      </div>
		    </div>

			<div class="row row-cols-1 row-cols-lg-3 align-items-stretch my-2">
           	 <div class="col">
		        <div class="topCateCard card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" style="background-image: url('https://image.ohou.se/i/bucketplace-v2-development/uploads/productions/162752789399376857.jpg?gif=1&w=640&h=640&c=c&webp=1');">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
		            <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">주방용품</h3>
		            <input type="hidden" value="4" name="topCate">
		            <ul class="d-flex list-unstyled mt-auto">
		            </ul>
		          </div>
		        </div>
		      </div>
		
		      <div class="col">
		        <div class="topCateCard card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" style="background-image: url('https://image.ohou.se/i/bucketplace-v2-development/uploads/productions/166928404484534220.jpg?gif=1&w=640&h=640&c=c&webp=1');">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
		            <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">가전제품</h3>
		            <input type="hidden" value="5" name="topCate">
		            <ul class="d-flex list-unstyled mt-auto">
		            </ul>
		          </div>
		        </div>
		      </div>
		
		      <div class="col">
		        <div class="topCateCard card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg" style="background-image: url('https://image.ohou.se/i/bucketplace-v2-development/uploads/productions/160697946906302636.jpg?gif=1&w=640&h=640&c=c&webp=1');">
		          <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1">
		            <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">소형가전</h3>
		            <input type="hidden" value="6" name="topCate">
		            <ul class="d-flex list-unstyled mt-auto">
		            </ul>
		          </div>
		        </div>
		      </div>
		    </div>
		   </div>
		 	   
                       
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	
	<script>
	 var tccs = document.getElementsByClassName("topCateCard");
// 	 console.log(tccs);
	 for (tcc of tccs){
		 tcc.addEventListener('click',function(){
			 var topCate = this.childNodes[1].childNodes[3].value;
			 
			 location.href="${ contextPath }/categoryList.st?topCate=" + topCate;
		 })
	 }
	</script>

</body>
</html>