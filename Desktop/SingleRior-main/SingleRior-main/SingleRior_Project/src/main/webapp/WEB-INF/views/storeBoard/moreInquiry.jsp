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
			<h1 class="title" style="color: #008cd4">상품 문의</h1>
		<div class="inquiry">
			<c:if test="${! empty iList }">
		 		<c:forEach items="${ iList }" var="i">
			 		<div style="border:black solid 1px; width:600px; padding:10px 10px; border-radius:10px;">
				        <p class="blog-post-meta">${i.inquiryTitle} | 
					        <c:if test="${ i.inquiryAnswer == null }">
					        	<span style="color:#008cd4;">답변대기</span>
					        </c:if>
					        <c:if test="${ i.inquiryAnswer != null }">
					        	<span style="color:#008cd4;">답변완료</span>
					        </c:if>
					        
	<!--  삭제하기 -->		   <span style="display: inline-block; margin: 0 5px;  float:right;">
					         	<c:if test="${ loginUser.memberId eq i.memberId }">
								<button type="button" class="inquiry_delete btn btn-primary">삭제</button>
									<input type="hidden" name="inquiryNo" value="${ i.inquiryNo }">
					        	</c:if>
				            </span>
					        </p>
						<p> ${i.memberId} | ${i.inquiryDate}</p>
						<p><img src="https://cdn-icons-png.flaticon.com/512/8371/8371275.png" width="20px" height="20px"> ${ i.inquiryContent }</p>
						<p><img src="https://cdn-icons-png.flaticon.com/512/25/25628.png" width="20px" height="20px"> ${ i.inquiryAnswer }</p>
			    	</div>
		    	<br>
		    	</c:forEach>
		    	<input type="hidden" name="productNo" id="productNo" value="${ iList[0].productNo }">
			</c:if>
		</div>
	</section>
	<br><br>
	
	
	<c:if test="${! empty iList }">
		<nav aria-label="Standard pagination example">
			<ul class="pagination justify-content-center">
			    <c:if test="${ pi.currentPage > 1 }">
				<li class="page-item"><c:url var="goBack" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage-1 }" />
						<c:param name="productNo" value="${ iList[0].productNo }" />
					</c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
				</a></li>
				</c:if>
				<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
					<c:url var="goNum" value="${ loc }">
						<c:param name="page" value="${ p }" />
						<c:param name="productNo" value="${ iList[0].productNo }" />
					</c:url>
					<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
				</c:forEach>
				<c:if test="${ pi.currentPage < pi.maxPage }">
				<li class="page-item"><c:url var="goNext" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage+1 }" />
						<c:param name="productNo" value="${ iList[0].productNo }" />
					</c:url> <a class="page-link" href="${ goNext }" aria-label="Next"> <span
						aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>
		</nav>
	</c:if>
	
	  <!-- 문의삭제 모달 -->
	<div class="modal" tabindex="-1" id="deleteModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">문의 내용을 삭제하시겠습니까?</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>삭제 후에는 복구가 불구합니다.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	      <form action="deleteInquiry.st">
	      	<input type="hidden" id="inquiryNo" name="inquiryNo">
	      	<input type="hidden" id="productNo" name="productNo" value="${ pList[0].productNo }">
	        <button type="button" class="btn btn-primary" id="confirm" >확인</button>
	      </form>
	      </div>
	    </div>
	  </div>
	</div>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
</body>
<script>
	
	window.onload = () => {
		var iqds = document.getElementsByClassName("inquiry_delete");
		
		for(iqd of iqds){
			iqd.addEventListener('click',function(){
				const no = this.nextElementSibling.value;
				document.getElementById("inquiryNo").value = no;
				$('#deleteModal').modal('show');
				console.log(no);
			})
		}
		
	}
    
    $('#confirm').on('click',function(){
    	
    	var inquiryNo = document.getElementById("inquiryNo").value;
    	const productNo = document.getElementById("productNo").value; 
    	console.log(inquiryNo);
    	console.log(productNo);
    	$.ajax({
              url: '${contextPath}/deleteInquiry.st',
              data: {inquiryNo:inquiryNo,productNo:productNo},
              success:(data)=>{
                 console.log(data);
                location.reload();
            
              },
              error: (data)=>{
               console.log(data);
            }
           });
    });
    

</script>
</html>