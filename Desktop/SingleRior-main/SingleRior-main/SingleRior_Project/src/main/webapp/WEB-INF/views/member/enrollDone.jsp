<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#enrollDone {
	margin: auto;
	margin-top: 100px;
	max-width: 900px;
	font-size: 25px;
	text-align: center;
}

.msgenroll {
	text-align: center;
}
</style>

</head>
<body>
	<header class="sticky-top">
			<jsp:include page="../common/top.jsp" />
	</header>

	<div id="enrollDone">
		<img src="https://cdn-icons-png.flaticon.com/512/4003/4003644.png"><br>

		<br>
		<h2 class="msgenroll">${msg }</h2>
		<h3 class="msgenroll">로그인을 해주세요.</h3>

		<button class="w-100 btn btn-lg btn-light" type="button"
			style="background: #008cd4; color: white" id="goLogin">로그인</button>
		<br>

	</div>
	<footer>
		<jsp:include page="../common/footer.jsp" />
	</footer>

	<script>
		window.onload = () => {
				document.getElementById("goLogin").addEventListener('click',function(){																						
						location.href='${contextPath}/loginView.me';
																																								});
		}
	
	</script>
</body>
</html>