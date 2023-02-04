<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<style>
	body {display: flex; align-items: center; padding-top: 40px; padding-bottom: 40px;}
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
<body class="bg-light">
	<div class="container">
		<main>
			<div class="py-5 text-center">
				<a href="${ contextPath }/home.do"><img class="d-block mx-auto mb-4" src="${ contextPath }/resources/image/SingleRior_logo.png" alt="" width="330"></a>
			</div>

			<div style="margin-left: 350px; margin-right: 350px;">
				<h3>회원가입</h3><br><br>
				<form class="needs-validation" action="${ contextPath }/insertMember.me" method="POST" onsubmit="return mySubmit()">
					<div class="row g-3">
						<div class="col-12">
							<label for="id" class="form-label">아이디</label>
							<input type="text" class="form-control" id="memberId" name="memberId" required>
							<span id="idCheckMsg"></span>
						</div>
						
						<div class="col-12">
							<label for="pwd" class="form-label">비밀번호</label>
							<input type="password" class="form-control" id="memberPwd" name="memberPwd" required>
							<span id="pwdCheckMsg"></span>
						</div>
						
						<div class="col-12">
							<label for="pwdConfirm" class="form-label">비밀번호 확인</label>
							<input type="password" class="form-control" id="pwdConfirm" required>
							<span id="pwdConfirmMsg"></span>
						</div>
						
						<div class="col-12">
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" id="memberName" name="memberName" required>
						</div>
						
						<div class="col-12">
							<label for="nickName" class="form-label">닉네임</label>
							<input type="text" class="form-control" id="nickName" name="nickName" required>
							<span id="nickNameCheckMsg"></span>
						</div>

							<label for="email" class="form-label">이메일</label>
						<div class="input-group mb-3">
 							 <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요." aria-label="Recipient's username" aria-describedby="button-addon2" required>
							 <button class="btn btn-outline-secondary" type="button" id="emailCheckBtn" disabled>인증</button>
						</div>
							 <span id="emailCheckConfirmMsg"></span>
							 
						<div class="mail-check-box">
							<input class="form-control mail-check-input" id="emailCheckInput" disabled="disabled" placeholder="인증번호 6자리를 입력해주세요!"  maxlength="6" required>
							<span id="emailCheckMsg"></span>
						</div>
						<div class="col-12">
							<label for="phone" class="form-label">핸드폰 번호 (-포함)</label>
							<input type="text" class="form-control" id="phone" name="phone" required>
						</div>
						<div class="col-12">
							<label for="address" class="form-label">주소</label>
							<input type="text" class="form-control" id="address_kakao" name="address" required>
						</div>
						
						<br><br><br><br><br>
						
						<input type='submit' id="enrollBtn" class="w-100 btn btn-light btn-lg" style="background:#008cd4; color:white" value="회원가입">
					</div>
				</form>
			</div>
			<br>
		</main>
	</div>
	
	<script>
	
	let idChecked = false;
	let nickNameChecked = false;
	let passwordChecked = false;
	let passwordConfirmChecked = false;
	let emailChecked = false;
	
	// 아이디 중복체크, 유효성 검사
	$(function(){
		$('#memberId').on('focus', function(e){
			$('#idCheckMsg').html('영문, 숫자를 포함한 6~20자 이상의 아이디를 입력해주세요.(특수문자 사용 불가)');
			$('#idCheckMsg').css('color','black');
		});
		
		$('#memberId').on('focusout',function(){
			let memberId = $('#memberId').val();
//	 		console.log(memberId);
			const idReg = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{5,20}$/g;
			if(!idReg.test(memberId)){
				$('#idCheckMsg').css('color','red');
				idChecked = false;
			}else{
				$.ajax({
					url : '${contextPath}/checkId.me',
					data : {memberId:memberId},
					success: (data) =>{
						console.log(data);
						if( data != 1 ) {
							$('#idCheckMsg').html('멋진 아이디네요!');
							$('#idCheckMsg').css('color','green');
							idChecked = true;
						} else {
							$('#idCheckMsg').html('이미 사용중이거나 탈퇴한 아이디입니다.');
							$('#idCheckMsg').css('color','red');
							idChecked = false;
						}
					},
					error : (data)=>{
						console.log(data);
					}
				});
			}
		});
	});
		
	// 비밀번호
	$(function(){
		$('#memberPwd').on('focus', function(e){
			$('#pwdCheckMsg').html('영문, 숫자, 특수기호를 포함한 6자 이상의 비밀번호를 입력해주세요.');
			$('#pwdCheckMsg').css('color','black');
		});
		$('#memberPwd').on('focusout',function(){
			let memberPwd = $('#memberPwd').val();
//	 		console.log(memberPwd);
			const pwdReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/;
			if(!pwdReg.test(memberPwd)){
				$('#pwdCheckMsg').css('color','red');
				passwordChecked = false;
			}else{
				$('#pwdCheckMsg').html('');
				passwordChecked = true;
			}
		});
		
		$('#pwdConfirm').keyup(function(e) {
			if($('#memberPwd').val() != $('#pwdConfirm').val()) {
				$('#pwdConfirmMsg').html('비밀번호 불일치');
				$('#pwdConfirmMsg').css('color','red');
				passwordConfirmChecked = false;
			} else {
				$('#pwdConfirmMsg').html('비밀번호 일치');
				$('#pwdConfirmMsg').css('color','green');
				passwordConfirmChecked = true;
			}
		});
	});
		
		// 닉네임 중복확인
	$(function(){
		$('#nickName').on('focusout', function(e){
			let nickName = $('#nickName').val();
//	 		console.log(nickName);
			$.ajax({
				url : '${contextPath}/checkNickName.me',
				data : {nickName:nickName},
				success: (data) =>{
					console.log(data);
					if( data == 0 ) {
						$('#nickNameCheckMsg').html('멋진 닉네임네요!');
						$('#nickNameCheckMsg').css('color','green');
						nickNameChecked = true;
					} else {
						$('#nickNameCheckMsg').html('이미 사용중인 닉네임입니다.');
						$('#nickNameCheckMsg').css('color','red');
						nickNameChecked =  false;
					}
				},
				error:(data)=>{
					console.log(data);
				}
			});
		});
	});
		// 이메일 중복확인
		$('#email').blur(function(e){
			const email = $('#email').val();
			console.log(email);
			$.ajax({
				type : 'post',
				url : '${contextPath}/checkEmailConfirm.me?email='+email,
				success: (data)=>{
					console.log(data);
					if(data == 'possible'){
						$('#emailCheckBtn').attr('disabled', false);
						$('#emailCheckConfirmMsg').html("사용가능한 이메일입니다. 인증번호를 입력해주세요.");
						$('#emailCheckConfirmMsg').css('color','green');
						emailChecked = true;
					}else if(data == 'impossible'){
						$('#emailCheckBtn').attr("disabled", true);
						$('#emailCheckConfirmMsg').html("이미 사용중인 이메일입니다.");
						$('#emailCheckConfirmMsg').css('color','red');
						emailChecked = false;
//							e.preventDefault();
					}else if(data == 'kakao'){
						alert("해당 이메일로 등록된 카카오 계정이 있습니다.");
						$('#emailCheckConfirmMsg').html("");
						$('#email').value("");
					}else if(data == 'naver'){
						alert("해당 이메일로 등록된 네이버 계정이 있습니다.");
						$('#emailCheckConfirmMsg').html("");
						$('#email').value("");
					}
				},
				error:(data)=>{
					console.log(data);
				}
			});
		});
		
		
		// 이메일 인증
		let code = '';
		$('#emailCheckBtn').click(function(){
			const email = $('#email').val();
			console.log(email);
			const emailCheckInput = $('#emailCheckInput');
			
			$.ajax({
				type : 'post',
				url : '${contextPath}/checkMail.me?email='+email,
				success: (data)=>{
					console.log(data);
					$('#emailCodeSend').Text = '인증번호 발송'
					emailCheckInput.attr('disabled',false);
					code = data;
				},
				error:(data)=>{
					console.log(data);
				}
			});
		});
			
		$('#emailCheckInput').blur(function(e){
			const inputCode = $(this).val();
			console.log(code);
			if(inputCode === code){
				$('#emailCheckMsg').html('인증번호가 일치합니다.');
				$('#emailCheckMsg').css('color','green');
				emailChecked = true;
			}else{
				$('#emailCheckMsg').html('인증번호가 일치하지 않습니다. 다시 확인해주세요');
				$('#emailCheckMsg').css('color','red');
				emailChecked = false;
			}
		});


	function mySubmit(){

		if(idChecked == false){
			$('#memberId').focus();
			$('#idCheckMsg').css('color','red');
			return false;
		}
		if(nickNameChecked == false){
			$('#nickName').focus();
			return false;
		}
		if(passwordChecked == false){
			
			$('#memberPwd').focus();
			return false;
		}
		if(passwordConfirmChecked == false){
			$('#pwdConfirm').focus();
			return false;
		}
		if(emailChecked == false){
			$('#emailCheckInput').focus();
			return false;
		}
		
	}
	
	</script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	window.onload = function(){
	    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
	        //카카오 지도 발생
	        new daum.Postcode({
	            oncomplete: function(data) { //선택시 입력값 세팅
	            	console.log(data);
	                document.getElementById("address_kakao").value = data.address; // 주소 넣기
	                self.close();
// 	                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
	            }
	        }).open();
	    });
	}
	</script>
</body>
</html>