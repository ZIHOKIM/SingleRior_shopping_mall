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
	.topCate{cursor:pointer}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
	<nav class="py-2 bg-light border-bottom">
		<div class="container d-flex flex-wrap fs-5">
			<a href="${ contextPath }/home.do" class="mx-auto text-dark text-decoration-none">
				<img class="bi" style="margin-left: 150px;" width="320" height="120" src="${ contextPath }/resources/image/SingleRior_logo.png">
			</a>
			<ul class="nav d-flex align-items-center">
				<c:if test = "${ empty loginUser }">
					<li class="nav-item"><a href="${contextPath}/loginView.me" class="nav-link link-dark px-2">Login</a></li>
					<li class="nav-item"><a href="${contextPath}/enrollView.me" class="nav-link link-dark px-2">Sign up</a></li>
				</c:if>
				<c:if test = "${ !empty loginUser && loginUser.memberAuthority=='N'}">
					<li class="nav-item  position-relative" ><i id="msgIcon" class="bi bi-envelope-fill" role="button" style="font-size:2rem; " onclick="location.href='${contextPath}/messageBox.cm'"><span style="font-size: 9px; display: none;" class="position-absolute top-50 start-100 translate-middle badge rounded-pill bg-danger" id="msgBox"></span></i></li>&nbsp;&nbsp;&nbsp;
					<li class="nav-item"><i class="bi bi-cart-fill nav-link link-dark px-2" role="button" style="font-size:2rem;" onclick="location.href='${contextPath}/myCart.me'"></i></li>&nbsp;&nbsp;&nbsp;
					<li class="nav-item dropdown-center">
						<i class="bi bi-person-circle" style="font-size:2rem;" role="button" data-bs-toggle="dropdown" aria-expanded="false"></i>
						<ul class = "dropdown-menu dropdown-menu" aria-labelledby="navbarDarkDropdownMenuLink">
							<li><a class="dropdown-item" href="${contextPath}/myPage.me">My Page</a></li>
							<li><a class="dropdown-item" href="${contextPath}/logout.me">Logout</a></li>
						</ul>
					</li>
				</c:if>
				<c:if test = "${ !empty loginUser && loginUser.memberAuthority=='Y' }">
				<li class="nav-item"><i class="bi bi-envelope-fill" role="button" style="font-size:2rem;" onclick="location.href='${contextPath}/messageBox.cm'"></i></li>&nbsp;&nbsp;&nbsp;
				<li class="nav-item"><i class="bi bi-cart-fill nav-link link-dark px-2" role="button" style="font-size:2rem;" onclick="location.href='${contextPath}/myCart.me'"></i></li>&nbsp;&nbsp;&nbsp;
				<li class="nav-item dropdown-center">
					<i class="bi bi-person-circle" style="font-size:2rem;" role="button" data-bs-toggle="dropdown" aria-expanded="false"></i>
					<ul class = "dropdown-menu dropdown-menu" aria-labelledby="navbarDarkDropdownMenuLink">
						<li><a class="dropdown-item" href="${contextPath}/myPage.me">My Page</a></li>
						<li><a class="dropdown-item" href="${contextPath}/index.adm">Admin</a></li>
						<li><a class="dropdown-item" href="${contextPath}/logout.me">Logout</a></li>
					</ul>
				</li>
				</c:if>
			</ul>
		</div>
	</nav>
	
	<header class="py-1 bg-white border-bottom">
		<div class="container d-flex flex-wrap justify-content-center fs-5">
			<ul class="nav me-auto">
				<li class="nav-item">
					<button class="navbar-toggler px-3" style="padding-top: 11px;" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
							<path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
						</svg>
	        			카테고리
					</button>
	        	</li>
	        	<li class="nav-item"><a href="${contextPath}/storeList.st" class="nav-link link-dark px-3">스토어</a></li>
	        	<li class="nav-item"><a href="${contextPath}/commuAllList.co" class="nav-link link-dark px-3">싱글벙글</a></li>
	        	<li class="nav-item"><a href="${contextPath}/marketBoardList.ma" class="nav-link link-dark px-3">씽씽마켓</a></li>
	        	<li class="nav-item"><a href="${contextPath}/notiAllList.no" class="nav-link link-dark px-3">공지사항</a></li>
	        </ul>
	        
	        <form class="col-12 col-lg-auto mb-3 mb-lg-0" role="search" action="${ contextPath }/mainSearch.main">
	        	<input type="search" class="form-control" placeholder="Search..." aria-label="Search" style="margin-top: 4px;" name="findKeyword">
	        </form>
		</div>
		
		<div class="collapse bg-white" id="navbarHeader">
			<div class="container" style="text-align: center;">
				<div class="row justify-content-center">
					<div class="topCate col-sm-2 py-4" onclick="location.href='${ contextPath }/categoryList.st?topCate=1'">
						<div>
							<img src="https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-category-store_hamburger_categories-165698405465057590.png/1280/none" style="width: 100px; height: 100px;">
						</div>
						<h6>가구</h6>
					</div>
					<div class="topCate col-sm-2 py-4" onclick="location.href='${ contextPath }/categoryList.st?topCate=2'">
						<div>
							<img src="https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-category-store_hamburger_categories-166010551527923872.png/1280/none" style="width: 100px; height: 100px;">
						</div>
						<h6>패브릭</h6>
					</div>
					<div class="topCate col-sm-2 py-4" onclick="location.href='${ contextPath }/categoryList.st?topCate=3'">
						<div>
							<img src="https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-category-store_hamburger_categories-166936363673607278.png/1280/none" style="width: 100px; height: 100px;">
						</div>
						<h6>인테리어 소품</h6>
					</div>
					<div class="topCate col-sm-2 py-4" onclick="location.href='${ contextPath }/categoryList.st?topCate=4'">
						<div>
							<img src="https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-category-store_hamburger_categories-165580420382620877.png/1280/none" style="width: 100px; height: 100px;">
						</div>
						<h6>주방용품</h6>
					</div>
					<div class="topCate col-sm-2 py-4" onclick="location.href='${ contextPath }/categoryList.st?topCate=5'">
						<div>
							<img src="https://image.ohou.se/image/resize/bucketplace-v2-development/uploads-category-store_hamburger_categories-166072987520626215.png/1280/none" style="width: 100px; height: 100px;">
						</div>
						<h6>가전제품</h6>
					</div>
					<div class="topCate col-sm-2 py-4" onclick="location.href='${ contextPath }/categoryList.st?topCate=6'">
						<div>
							<img src="https://image.ohou.se/i/bucketplace-v2-development/uploads/productions/165035964910967853.jpg?gif=1&w=850&h=850&c=c&webp=1" style="width: 100px; height: 100px;">
						</div>
						<h6>소형가전</h6>
					</div>
				</div>
			</div>
		</div>
	</header>
	
	<script>
      (function() {
         var w = window;
         if (w.ChannelIO) {
            return (window.console.error || window.console.log || function() {
            })('ChannelIO script included twice.');
         }
         var ch = function() {
            ch.c(arguments);
         };
         ch.q = [];
         ch.c = function(args) {
            ch.q.push(args);
         };
         w.ChannelIO = ch;
         function l() {
            if (w.ChannelIOInitialized) {
               return;
            }
            w.ChannelIOInitialized = true;
            var s = document.createElement('script');
            s.type = 'text/javascript';
            s.async = true;
            s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
            s.charset = 'UTF-8';
            var x = document.getElementsByTagName('script')[0];
            x.parentNode.insertBefore(s, x);
         }
         if (document.readyState === 'complete') {
            l();
         } else if (window.attachEvent) {
            window.attachEvent('onload', l);
         } else {
            window.addEventListener('DOMContentLoaded', l, false);
            window.addEventListener('load', l, false);
         }
      })();
      ChannelIO('boot', {
         "pluginKey" : "10a22f6a-22c4-4cd7-9a9f-d85a11e58ddb"
      });

      if(${ !empty loginUser }){
		setInterval(
				function alarm() {
					$.ajax({
						url: '${ contextPath }/msgAlarm.cm',
						success: (data) => {
							if(data>0){
								
								document.getElementById('msgBox').style.display = 'block';
								document.getElementById('msgBox').innerText = "+ " + data;
							}
						},
						error: (data) => {
							console.log(data);
						}
					});
			 	},1000);
		 }

   </script>
</body>
</html>