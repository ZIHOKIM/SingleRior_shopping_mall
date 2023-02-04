<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.form-findPwd {margin:auto; margin-top:100px; max-width: 500px; padding:50px;}
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
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<main class="form-findPwd">
		<div><h3>비밀번호 임시 발급</h3></div><br>
<%-- 		<form action="${ contextPath }/login.me" method="post"> --%>
			<div>
				<div>아이디을 입력해주세요.</div><br>
				<input type="text" class="form-control" name="memberId" id="memberId" placeholder="singlerior" style="height:50px;">
			</div>
			<br>
			<div>
				<div>이메일을 입력해주세요.</div><br>
				<input type="email" class="form-control" name="email" id="email" placeholder="singlerior@singlerior.com" style="height:50px;">
			</div>
			<br>
			<button class="w-100 btn btn-lg btn-light" type="submit" style="background:#008cd4; color:white" id="findIdBtn">비밀번호 찾기</button><br><br>
<!-- 		</form> -->
		<h6 style="text-align:center;" id="findPwdMsg"></h6>
		<br><br><br>
	</main>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
	
$(function(){
		
		$('#findIdBtn').on('click',function(){
			
			const memberId = $('#memberId').val();
			const email = $('#email').val();
// 			console.log(email);
			$.ajax({
				type : 'post',
				url : '${contextPath}/findPwd.me',
				data : {memberId:memberId, email:email },
				success: (data) =>{
					console.log(data);
					
				},
				error:(data)=>{
// 					console.log(data);
					$('#findPwdMsg').html("아이디 또는 이메일을 잘못 입력하셨습니다. 다시 입력해주세요.");
				}
			});
			$('#findPwdMsg').html("입력하신 이메일로 새로운 비밀번호를 보내드렸습니다.");
		});
	});
	
	
	
	
	</script>
</body>
</html>