<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</style>
</head>
<body>
	<div class="container">
		<footer class="row row-cols-1 row-cols-sm-2 row-cols-md-3 py-5 my-5 border-top">
		    <div class="col mb-3" style="width: 600px;">
		    	<a href="${ contextPath }/home.do" class="d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
					<img class="bi" width="320" height="120" src="${ contextPath }/resources/image/SingleRior_logo.png">
				</a>
		    	<p class="text-muted d-flex align-items-center justify-content-center">&copy; 2022 Company, Inc</p>
		    </div>
		
			<div class="col mb-3" style="width: 150px;">
		    	<ul class="nav flex-column" style="font-weight: bold; font-size: 15px;">
		    		<li class="nav-item mb-2">상호명</li>
		    		<li class="nav-item mb-2">대표자</li>
		    		<li class="nav-item mb-2">개인정보보호책임자</li>
		    		<li class="nav-item mb-2">사업자등록번호</li>
		    		<li class="nav-item mb-2">대표번호</li>
		    		<li class="nav-item mb-2">통신판매업신고번호</li>
		    		<li class="nav-item mb-2">주소</li>
		    		<li class="nav-item mb-2">문의</li>
		    		<li class="nav-item mb-2">서비스 이용약관</li>
		    		<li class="nav-item mb-2">개인정보 처리방침</li>
		    	</ul>
			</div>
			
			<div class="col mb-3">
		    	<ul class="nav flex-column" style="font-size: 15px;">
		    		<li class="nav-item mb-2">SingleRior</li>
		    		<li class="nav-item mb-2">E1I4</li>
		    		<li class="nav-item mb-2">E1I4</li>
		    		<li class="nav-item mb-2">111-22-33333</li>
		    		<li class="nav-item mb-2">1668-1234</li>
		    		<li class="nav-item mb-2">제2022-서울종로-11111호</li>
		    		<li class="nav-item mb-2">서울특별시 중구 남대문로 120, 그레이츠 청계 3층</li>
		    		<li class="nav-item mb-2">singlerior@singlerior.com</li>
		    	</ul>
			</div>
		</footer>
	</div>
</body>
</html>