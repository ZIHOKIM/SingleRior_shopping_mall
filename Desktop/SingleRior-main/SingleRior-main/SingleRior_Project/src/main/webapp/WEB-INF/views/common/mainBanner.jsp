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
			<h1 style="text-align: center; padding-top: 100px;">기 획 전</h1>
			<div class="col-md-1" style="text-align: center; padding-top: 50px;"></div>
			<div class="col-12 border rounded overflow-hidden">
				<!-- 본문 -->
				<div class="p-5">
					<c:forEach items="${ bannerList }" var="b">
							<div class="container px-5 pt-5" style="width: 1000px;">
								<div class="row">
									<div>
										<img src="${ contextPath }/resources/uploadFiles/${ b.imgRename }" width="100%" height="1000">
									</div>
								</div>
							</div>
					</c:forEach>
				</div>
				
				<div style="border-bottom: 1px solid #DCDCDC; padding-top: 10px;"></div>
				
				<!-- 이동 -->
				<div class="row px-5 py-4 justify-content-center">
					<div class="col-md-1" style="text-align: center; width: 300px;">
						<button class="w-100 btn btn-outline-dark btn-lg" type="button" onclick="location.href='${contextPath}/home.do'">메인 페이지로 이동</button>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
</body>
</html>