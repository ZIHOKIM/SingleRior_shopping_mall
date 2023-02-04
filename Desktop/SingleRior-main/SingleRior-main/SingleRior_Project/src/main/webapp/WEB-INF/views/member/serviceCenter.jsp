<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#mainService{
	 	margin:auto; 
	 	margin-top:50px; 
	 	max-width:1000px;
	 	padding:40px;
		background-color:#F5F5F5;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
	}
	#mainService h2{
		float:right;
		color:#008cd4;
	}
	#mainService h4{
		color:gray;
	}
	.category{background:#F5F5F5;  border-radius: 30px; padding:10px; margin:10px; cursor:pointer}
	.accordion{margin:auto; max-width:1000px;}
	
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<section>
		<div id="mainService">
			<h1 style="display:inline">고객센터&nbsp;&nbsp;<span>09:00~18:00</span></h1>
			<br><br><br>
			<h4>평일: 전체 문의 상담 가능</h4>
			<h4>주일/공휴일: 상담불가</h4>
			<h2><i class="bi bi-telephone-fill"></i>1600-0000</h2>
			<br>
		</div>
		<br><br>
		<div>
			<ul class="nav justify-content-center">
			  <li class="nav-item">
			  	<div class="category">전체</div>
			  </li>
			  <li class="nav-item">
			 	 <div class="category">주문/결제</div>
			  </li>
			  <li class="nav-item">
			  	<div class="category">배송관련</div>
			  </li>
			  <li class="nav-item">
			  	<div class="category">취소/환불</div>
			  </li>
			  <li class="nav-item">
			  	<div class="category">반품/교환</div>
			  </li>
			  <li class="nav-item">
			  	<div class="category">증빙서류발급</div>
			  </li>
			  <li class="nav-item">
			  	<div class="category">로그인/회원정보</div>
			  </li>
			  <li class="nav-item">
			  	<div class="category">서비스/기타</div>
			  </li>
			</ul>
		</div><br><br>
		
		<div>
			<div class="accordion accordion-flush" id="accordionFlushExample">
				<c:if test="${ !empty bList }">
					<c:forEach items="${ bList }" var="b">
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingOne">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne${b.boardNo}" aria-expanded="false" aria-controls="flush-collapseOne">
									<span>Q.&nbsp;&nbsp;</span>${b.boardTitle }
								</button>
							</h2>
							<div id="flush-collapseOne${b.boardNo}" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
								<div class="accordion-body">${b.boardContent }</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
		
		window.onload = () =>{
			const categorys = document.getElementsByClassName("category");
			for(category of categorys){
				category.addEventListener('click',function(){
					const category = this.innerText;
// 					console.log(category);
					location.href='${contextPath}/serviceCenter.me?category=' + category;
					colorChange();
				})
			}
			
			console.log(categorys);
			for(category of categorys){
				const ct = category.innerText;
				if(ct == '${category}'){
					category.style.background = '#008cd4';
					category.style.color = 'white';
				}
			}
		}
		
				
		
		
		
	</script>
</body>
</html>