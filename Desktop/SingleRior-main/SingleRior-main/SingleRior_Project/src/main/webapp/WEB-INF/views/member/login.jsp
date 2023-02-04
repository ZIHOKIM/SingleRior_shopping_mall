<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<style>
	html, body {height: 100%;}
	body {display: flex; align-items: center; padding-top: 40px; padding-bottom: 40px; background-color: #f5f5f5;}
	.form-signin {max-width: 380px; padding: 15px;}
	.form-signin .form-floating:focus-within {z-index: 2;}
	.form-signin input[type="email"] {margin-bottom: -1px; border-bottom-right-radius: 0; border-bottom-left-radius: 0;}
	.form-signin input[type="password"] {margin-bottom: 10px; border-top-left-radius: 0; border-top-right-radius: 0;}
	.form-signin a>label{color: black;}
	.form-signin a>label:hover{text-decoration: underline;}
/* 	ul{list-style:none;} */
/* 	li{ */
/* 		text-align:center; */
/* 		float: right; */
/* 	} */
	a{color:gray;}
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
<body class="text-center">
	<main class="form-signin w-100 m-auto">
		<form action="${ contextPath }/login.me" method="post">
			<a href="${ contextPath }/home.do"><img class="mb-4" src="${ contextPath }/resources/image/SingleRior_logo.png" width="320"></a>
			<div class="form-floating">
				<input type="text" class="form-control" id="memberId" name="memberId" placeholder="input your id">
				<label for="floatingInput">ID</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="memberPwd" name="memberPwd" placeholder="Password">
				<label for="floatingPassword">Password</label>
			</div>

			<button class="w-100 btn btn-lg btn-light" type="submit" style="background:#008cd4; color:white">로그인</button><br><br>
		</form>
			<div class="mb-4">
				<a href="${ contextPath }/enrollView.me">회원가입</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="${ contextPath }/findIdView.me">아이디 찾기</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="${ contextPath }/findPwdView.me">비밀번호 찾기</a>
			</div>
			<br>
			<span>SNS계정으로 간편 로그인</span>
			<hr>
			<div>
				<a href='https://kauth.kakao.com/oauth/authorize?client_id=id&redirect_uri=http://localhost:8088/SingleRior/kakaoLogin.me&response_type=code'>
					<img src="${ contextPath }/resources/image/kakao_login_large_wide.png" alt="카카오계정 로그인" style="width:300px;  height:50px;">
				</a>
			</div><br>
			<div>
				<a id="naverIdLogin_loginButton"
				 href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=id&state=singlerior&redirect_uri=http://localhost:8088/SingleRior/naverLogin.me" >
				<img src="${ contextPath }/resources/image/naver_login.png" alt="네이버계정 로그인" style="width:300px; height:50px;"></a>
			</div>
	</main>
	
	
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
	<script>
		window.Kakao.init('f6d3ec046c3e92308e683b2ee8e4cee7');
		
// 		//카카오로그인
		function kakaoLogin() {
		
		    Kakao.Auth.login({
		      scope:'profile_nickname, account_email, birthday',
		      success : function(autoObj){
		    	  console.log(autoObj);
		    	  window.Kakao.API.request({
		    		  url : '/v2/user/me',
		    		  success: (res) => {
		    			  console.log(res);
		    			  const kakao_account = res;
		    		  }
		    	  });
		  		}
		    })
		  }
		  
		  window.onload = () => {
			  var login = '${msg}';
			  
			  if(login == "로그인실패"){
				  alert("로그인에 실패하셨습니다. 아이디 또는 비밀번호를 다시 확인해주세요.");
			  }
		  }
	</script>
</html>