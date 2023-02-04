<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
	.form-findId {margin:auto; margin-top:100px; max-width: 500px; padding:50px;}
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
	<main class="form-findId">
<%-- 		<form action="${ contextPath }/findLoginId.me" method="post"> --%>
			<div>
				<div><h3>아이디 찾기</h3></div><br>
				<label for="memberName" class="form-label">이름</label>
				<input type="text" class="form-control" name="memberName" id="memberName" placeholder="김싱글" style="height:50px;"><br>
				<label for="email" class="form-label">이메일</label>
				<input type="email" class="form-control" name="email" id="email" placeholder="singlerior@singlerior.com" style="height:50px;">
			</div>
			<br>
			<button class="w-100 btn btn-lg btn-light" type="submit" style="background:#008cd4; color:white" id="findIdBtn">아이디 찾기</button><br><br>
<!-- 		</form> -->
		<h6 style="text-align:center;" id="findIdMsg"></h6>
		<br><br><br>
	</main>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
	
	$(function(){
		
		$('#findIdBtn').on('click',function(){
			
			const memberName = $('#memberName').val();
			const email = $('#email').val();
// 			console.log(email);
			$.ajax({
				type : 'post',
				url : '${contextPath}/findId.me',
				data : {memberName:memberName, email:email },
				success: (data) =>{
					console.log(data);
				},
				error:(data)=>{
// 					console.log(data);
					$('#findIdMsg').html("이름 또는 이메일을 잘못 입력하셨습니다. 다시 입력해주세요.");
				}
			});
			$('#findIdMsg').html("입력하신 이메일로 아이디를 보내드렸습니다.");
		});
	});
	
	</script>
</body>
</html>