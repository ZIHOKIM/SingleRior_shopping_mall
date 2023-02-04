<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
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
</style>
</head>
<body>
	<header class="sticky-top">
		<div>
			<jsp:include page="../common/top.jsp"/>
		</div>
	</header>
	
	<main>
		<div class="container">
			<div class="col-md-1" style="text-align: center; padding-top: 100px;">
				<div class="row g-0 border rounded overflow-hidden flex-md-row shadow-sm h-md-250 position-relative mt-2 mb-4">
					<div class="col py-2 d-flex flex-column position-static">
						<table>
							<tr>
								<td><a href="${ contextPath }/notiAllList.no" class="nav-link link-dark"><img src="${ contextPath }/resources/image/angle-left.png" width="15" height="15"> 목록 보기</a></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="col-12 border rounded overflow-hidden">
				<!-- 헤더 -->
				<div style="font-size: 20px; padding-top: 30px; padding-left: 50px;">
					<span>
						<c:if test="${ notiBoard.noticeCategory eq '전체' }">전체</c:if>
						<c:if test="${ notiBoard.noticeCategory eq '싱글벙글' }">싱글벙글</c:if>
						<c:if test="${ notiBoard.noticeCategory eq '씽씽마켓' }">씽씽마켓</c:if>
						<input type="hidden" value="${ notiBoard.boardNo }" name="boardNo">
						<input type="hidden" value="${ notiBoard.nickName }" name="writer">
						<input type="hidden" value="${ page }" name="page">
					</span>
				</div>
				<table>
					<tr>
						<td class="fs-3 px-5 py-3" width="1100">${ notiBoard.boardTitle }</td>
					</tr>
				</table>
				<table>
					<tr>
						<td class="px-5" width="150">관리자</td>
						<td width="180">${ notiBoard.createDate }</td>
					</tr>
				</table>
				
				<div style="border-bottom: 1px solid #DCDCDC; padding-top: 10px;"></div>
				
				<!-- 본문 -->
				<div class="p-5" style="font-size: 20px;">
					<textarea style="width: 100%; border: none; resize: none;" readonly>${ notiBoard.boardContent }</textarea>
				</div>
				
				<div style="border-bottom: 1px solid #DCDCDC; padding-top: 10px;"></div>
				
				<!-- 이동 -->
				<div class="row px-5 py-4 justify-content-center">
					<div class="col-md-1" style="text-align: center; width: 150px;">
						<button class="w-100 btn btn-outline-dark btn-lg" type="button" id="preForm" onclick="location.href='${contextPath}/selectNotiBoard.no?bNo=${ notiBoard.boardNo - 1 }&writer=${ notiBoard.nickName }'">이전글</button>
					</div>
					<div class="col-md-1" style="text-align: center; width: 150px;">
						<button class="w-100 btn btn-outline-dark btn-lg" type="button" id="nextForm" onclick="location.href='${contextPath}/selectNotiBoard.no?bNo=${ notiBoard.boardNo + 1 }&writer=${ notiBoard.nickName }'">다음글</button>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
		var txtArea = $('textarea');
	    if (txtArea) {
	        txtArea.each(function(){
	            $(this).height(this.scrollHeight);
	        });
	    }
	</script>
</body>
</html>