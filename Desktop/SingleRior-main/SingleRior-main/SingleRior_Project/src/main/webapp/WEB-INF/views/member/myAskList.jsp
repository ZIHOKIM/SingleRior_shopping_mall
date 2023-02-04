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
	#navAsk{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
		font-size:30px;
		cursor:pointer;
	}
	section{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
	}
 	.img{cursor:pointer;} 
	.inquiryDelete{float:right; color:gray; cursor:pointer}
	.inquiryDelete:hover{text-decoration:underline}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<nav class="navbar navbar-expand-lg" id="navAsk">
			<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
				<div class="navbar-nav">
					<a class="nav-link" aria-current="page" onclick="location.href='${contextPath}/myAskList.me'" style="color:#008cd4">답변 미완료 문의</a>
					<a class="nav-link" onclick="location.href='${contextPath}/myAskDoneList.me'">답변 완료 문의</a>
				</div>
			</div>
	</nav>
	<section>
		<h1 style="text-align:left">나의 문의</h1><br><br>
			<c:if test="${ ! empty piList }">
				<c:forEach items="${ piList }" var="pi" varStatus="a">
					<div class="myAskListDiv">
						<span>문의일자 : ${pi.inquiryDate}</span>&nbsp;&nbsp;&nbsp;
						<span class="badge" style="background:#008cd4; color:white; float:right">답변대기</span>
						<div style="display:none" class="productNo">${pList[a.index].productNo}</div>
						<div style="display:none" class="boardNo">${pList[a.index].boardNo}</div>
						<div style="display:none" class="inquiryNo">${pi.inquiryNo}</div>
						<table class="table">
						    <tr>
						      <td scope="row" colspan="4"></td>
						    </tr>
						    <tr height="15">
						    	<td scope="row" width="250" rowspan="3"><img src="${ contextPath }/resources/uploadFiles/${aList[a.index].imgRename}" width="160" class="img"></td>
						    	<td>
							    	<span>${pList[a.index].productName}</span><br><br><br>
							    	<div>
								    	<span>문의 유형 : ${pi.inquiryTitle}</span><br><br>
										<span>Q. &nbsp;&nbsp;${pi.inquiryContent}</span>
										<button type="button" class="inquiryDelete btn btn-light" data-bs-toggle="modal" data-bs-target="#deleteInquiryModal">
 											문의삭제
										</button>
									</div>
						    	</td>
						   	</tr>
						</table>
					</div><br><br>
				</c:forEach>
			</c:if>
			<c:if test="${ empty piList }">
			<div class="alert alert-secondary" role="alert">
  				문의가 없습니다.
			</div>
			</c:if>
		<c:if test="${ ! empty piList }">
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
	</section>
	
	<!-- 문의 삭제 모달 -->
	<div class="modal" tabindex="-1" id="deleteInquiryModal">
		<div class="modal-dialog modal-dialog-centered">
			<form action="${contextPath}/deleteInquiry.me" method="post">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">문의 삭제</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>작성하신 문의를 삭제하시겠습니까?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
						<button type="submit" class="btn btn-light" style="background:#008cd4; color:white" id="deleleInquiryBtn">문의 삭제</button>
					<input type="hidden" value="" name="inquiryNo"  id="inquiryNo">
					<input type="hidden" value="notdone" name="cate">
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
	window.onload = () =>{
		const imgs = document.getElementsByClassName('img');
		
		for(img of imgs){
			img.addEventListener('click',function(){
				const productNo = this.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[5].innerText;
				const boardNo = this.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[7].innerText;
				console.log(boardNo);

				location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo=' + boardNo + '&page=' + ${pi.currentPage};
			});
		}
		
		const inquiryDeletes = document.getElementsByClassName("inquiryDelete");
		for(inquiryDelete of inquiryDeletes){
			inquiryDelete.addEventListener("click",function(){
				const inquiryNo = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[9].innerText;
				
				var result = document.getElementById("inquiryNo");
				result.value = inquiryNo;
				console.log(result);
			})
		}
		
		var btn = document.getElementById("deleleInquiryBtn");
		console.log(btn);
		btn.addEventListener('click',function(){
			alert("문의가 삭제되었습니다.");
		})

	}
		
	</script>
</body>
</html>