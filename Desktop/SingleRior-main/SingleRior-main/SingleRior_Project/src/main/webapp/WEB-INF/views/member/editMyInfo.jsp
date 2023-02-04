<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h3{display:inline-block;}
	#deleteMember{color:gray; display:block;text-align:right; text-decoration:none;}
	#deleteMember:hover{color:gray; text-decoration:underline;}
	#upload{cursor:pointer; width:160px; height:160px;border-radius:70%; overflow: hidden;}
	#thumb{width:100%; height:100%;}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<div class="container">
		<main>
			<div style="margin-left: 350px; margin-right: 350px;">
				<br><br><br>
				<h3>회원정보 수정</h3><a href="#" id="deleteMember" data-bs-toggle="modal" data-bs-target="#deleteModal">회원탈퇴</a><br><br>
				<form class="needs-validation" action="${ contextPath }/updateMember.me" method="POST" onsubmit="return newSubmit()" enctype="multipart/form-data">
					<div class="row g-3">
						<div class="col-12">
							<h6 class="form-label">프로필사진</h6><br>
								<c:if test="${ a == null }">
									<div id="upload">
										<img src="${ contextPath }/resources/image/userProfile.png" id="thumb">
									</div>
								</c:if>
								<c:if test="${ a != null }">
									<c:if test="${ fn:containsIgnoreCase(a.imgRename, 'jpg') or fn:containsIgnoreCase(a.imgRename, 'png')}">
										<div id="upload">
											<img src="${ contextPath }/resources/uploadFiles/${a.imgRename }" id="thumb">
										</div>
									</c:if>
								</c:if>
							<input type="file" id="file" name="file" accept="image/*" multiple style="display: none;" onchange="readURL(this);">
							<button type="button" class="btn btn-secondary btn-sm" id="defaultProfile" style="float:right">기본사진으로 변경</button>
						</div>
						<div class="col-12">
							<label for="id" class="form-label">아이디</label>
							<c:if test="${ (loginUser.memberId).indexOf('kakao*') != -1 or (loginUser.memberId).indexOf('naver*') != -1}">
								<input type="text" class="form-control" id="subMemberId" name="subMemberId" readonly value="${fn:substring(loginUser.memberId,0,6) }">
								<input type="hidden" class="form-control" id="memberId" name="memberId" readonly value="${loginUser.memberId }">
							</c:if>
							<c:if test="${ (loginUser.memberId).indexOf('kakao*') == -1 and (loginUser.memberId).indexOf('naver*') == -1}">
								<input type="text" class="form-control" id="memberId" name="memberId" readonly value="${loginUser.memberId }">
							</c:if>
						</div>
						<c:if test="${ (loginUser.memberId).indexOf('kakao*') == -1 and (loginUser.memberId).indexOf('naver*') == -1}">
							<div class="col-12">
								<label for="pwd" class="form-label">현재 비밀번호</label>
								<input type="password" class="form-control" id="memberPwd" name="memberPwd" required>
								<span id="pwdCheckMsg"></span>
							</div>
							<div class="col-12">
								<label for="pwdConfirm" class="form-label">새로운 비밀번호(비밀번호를 변경 할 경우에만 입력해주세요.)</label>
								<input type="password" class="form-control" id="newPwd" name="newPwd">
								<span id="newPwdCheckMsg"></span>
							</div>
							<div class="col-12">
								<label for="pwdConfirm" class="form-label">새로운 비밀번호 확인</label>
								<input type="password" class="form-control" id="newPwdConrfirm">
								<span id="newPwdConfirmMsg"></span>
							</div>
						</c:if>
						<c:if test="${ (loginUser.memberId).indexOf('kakao*') != -1 or (loginUser.memberId).indexOf('naver*') != -1}">
								<input type="hidden" class="form-control" name="memberPwd">
								<input type="hidden" class="form-control" name="newPwd">
						</c:if>
						<div class="col-12">
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" id="memberName" name="memberName" readonly value="${loginUser.memberName }">
						</div>
						
						<div class="col-12">
							<label for="nickName" class="form-label">닉네임</label>
							<input type="text" class="form-control" id="nickName" name="nickName" value="${loginUser.nickName}" required>
							<span id="nickNameCheckMsg"></span>
						</div>

						<div>이메일</div>
						<div class="input-group mb-3">
 							 <input type="email" class="form-control" id="email" name="email" readonly value="${loginUser.email }" >
						</div>

						<div class="col-12">
							<label for="phone" class="form-label">핸드폰 번호 (-포함)</label>
							<c:if test="${loginUser.phone == null }">
								<input type="text" class="form-control" id="phone" name="phone">
							</c:if>
							<c:if test="${loginUser.phone != null }">
								<input type="text" class="form-control" id="phone" name="phone" value="${loginUser.phone}">
							</c:if>
						</div>
						
						<div class="col-12">
							<label for="address" class="form-label">주소</label>
							<input type="text" class="form-control" id="address_kakao" name="address" value="${loginUser.address}">
						</div>
						
						<br><br><br><br><br>
						
						<button class="w-100 btn btn-light btn-lg" style="background:#008cd4; color:white">회원정보 수정</button>
					</div>
				</form>
			</div>
		</main>
	</div>
	
	
	<!--  회원 탈퇴 모달창 -->
	<div class="modal" tabindex="-1" id="deleteModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">회원 탈퇴</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>정말로 탈퇴하시겠습니까?<br>탈퇴 후 계정은 복구할 수 없습니다.</p>
					<c:if test="${ (loginUser.memberId).indexOf('kakao*') == -1 and (loginUser.memberId).indexOf('naver*') == -1}">
						<div class="mb-3">
							  <label for="exampleFormControlInput1" class="form-label">비밀번호를 입력해주세요.</label>
							  <input type="password" class="form-control" id="deleteMemberPwd">
							  <span id="deletePwdCheckMsg"></span>
						</div>
					</c:if>
					<c:if test="${ (loginUser.memberId).indexOf('kakao*') != -1 and (loginUser.memberId).indexOf('naver*') != -1}">
						<div class="mb-3">
							  <input type="hidden" class="form-control" id="deleteMemberPwd" value="${loginUser.memberPwd}">
						</div>
					</c:if>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창 닫기</button>
					<button type="submit" class="btn btn-ligth" style="background:#008cd4; color:white" id="deleteMemberSubmit">회원 탈퇴</button>
				</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
	
	let nickNameChecked = true;
	let oldPwdCheck = true;
	let newPwdCheck = true;
	let newPwdCheckConfirm = true;
	
	// 닉네임 중복확인
	$(function(){
		$('#nickName').on('focusout', function(e){
			let nickName = $('#nickName').val();
			let memberNickName = '${loginUser.nickName}';
			if(nickName != memberNickName){
				$.ajax({
					url : '${contextPath}/checkNickName.me',
					data : {nickName:nickName},
					success: (data) =>{
						console.log(data);
						if( data == 0 ) {
							$('#nickNameCheckMsg').html('멋진 닉네임네요!');
							$('#nickNameCheckMsg').css('color','green');
							nickNameChecked = true;
						} else if(data == 1){
							$('#nickNameCheckMsg').html('이미 사용중인 닉네임입니다.');
							$('#nickNameCheckMsg').css('color','red');
							nickNameChecked =  false;
						}
					},
					error:(data)=>{
						console.log(data);
					}
				});
			} else{
				$('#nickNameCheckMsg').html('');
				nickNameChecked =  true;
			}
		});
	});
	
	// 비밀번호
	$(function(){
		$('#newPwd').on('focusout',function(){
			let newPwd = $('#newPwd').val();
				
			if(newPwd != ''){
				const pwdReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/;
				if(!pwdReg.test(newPwd)){
					$('#newPwdCheckMsg').html('영문, 숫자, 특수기호를 포함한 6자 이상의 비밀번호를 입력해주세요.');
					$('#newPwdCheckMsg').css('color','red');
					newPwdCheck = false;
				}else{
					$('#newPwdCheckMsg').html('');
					newPwdCheck = true;
				}
			}else{
				$('#newPwdCheckMsg').html('');
				$('#newPwd').val("");
				newPwdCheck = true;
				console.log("비번공백: " + newPwd);
			}
		});
			
		$('#newPwdConrfirm').focusout(function(e) {
			if($('#newPwd').val() != $('#newPwdConrfirm').val()) {
				$('#newPwdConfirmMsg').html('비밀번호 불일치');
				$('#newPwdConfirmMsg').css('color','red');
				newPwdCheckConfirm = false;
			} else {
				$('#newPwdConfirmMsg').html('비밀번호 일치');
				$('#newPwdConfirmMsg').css('color','green');
				newPwdCheckConfirm = true;
			}
			if($('#newPwd').val() == ''){
				$('#newPwdConfirmMsg').html('');
			}
		});
		
	});
	
	// 현재 비밀번호가 맞는지?
	$(function(){
		$('#memberPwd').focusout(function(){
			const memberPwd = $('#memberPwd').val();
			
			$.ajax({
				url : '${contextPath}/checkPwd.me',
				data : {memberPwd:memberPwd},
				success: (data) =>{
// 					console.log(data);
					if(data == 'true'){
						$('#pwdCheckMsg').html('');
						oldPwdCheck = true;
					}else if(data == 'false'){
						oldPwdCheck = false;
					}
				},
				error:(data)=>{
					console.log(data);
				}
			});
		})
	});
	
	// 프로필 사진 변경
	$(function(){
		$('#upload').on('click',function(){
			$('#file').click();
		});
	});
	
	
	//기본 프로필로 변경
	$(function(){
		$('#defaultProfile').on('click', function(){
			 const memberId = '${loginUser.memberId}';
			 console.log(memberId);
				$.ajax({
					url : '${contextPath}/deleteProfile.me',
					data : {memberId:memberId},
					success: (data) =>{
						console.log(data);
						document.getElementById('thumb').src ="${ contextPath }/resources/image/userProfile.png";
					},
					error:(data)=>{
						console.log(data);
					}
				});
		});
	});
	
	
	//프로필 사진 미리보기
	function readURL(input) {
		console.log(input.files);
		  if (input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function(e) {
		      document.getElementById('thumb').src = e.target.result;
		    };
		    reader.readAsDataURL(input.files[0]);
		  } else {
		    document.getElementById('thumb').src ="${ contextPath }/resources/image/userProfile.png";
		  }
		}
	
	function newSubmit(){
// 		console.log("oldPwdCheck : " + oldPwdCheck)
// 		console.log("nickNameChecked : " + nickNameChecked)
// 		console.log("newPwdCheck : " + newPwdCheck)
// 		console.log("newPwdCheckConfirm : " + newPwdCheckConfirm)
		
 		if (!oldPwdCheck){
 			$('#memberPwd').focus();
 			$('#pwdCheckMsg').html('현재 비밀번호 불일치');
 			$('#pwdCheckMsg').css('color','red');
 			return false;
 		}
 		
		if(!newPwdCheck){
			$('#newPwd').focus();
			return false;
		}
		
		if(!nickNameChecked){
			$('#nickName').focus();
			return false;
		}
		
		if (!newPwdCheckConfirm){
			$('#newPwdConrfirm').focus();
			return false;
		}
	}
	
	
	// 회원 탈퇴
	
	let deleteMemberChecked = true;
	$(function(){
		$('#deleteMemberPwd').keyup(function(){
			const memberPwd = $('#deleteMemberPwd').val();
// 			console.log(memberPwd);
			$.ajax({
				url : '${contextPath}/checkPwd.me',
				data : {memberPwd:memberPwd},
				success: (data) =>{
					console.log(data);
					if(data == 'true'){
						$('#deletePwdCheckMsg').html('');
						deleteMemberChecked = true;
					}else if(data == 'false'){
						$('#deletePwdCheckMsg').html('비밀번호를 다시 확인해주세요.');
						$('#deletePwdCheckMsg').css('color','red');
						deleteMemberChecked = false;
					}
				},
				error:(data)=>{
					console.log(data);
				}
			});
		})
	});
	
	$(function(){
		$('#deleteMemberSubmit').on('click',function(){
				if(deleteMemberChecked){
					const memberId = '${loginUser.memberId }';
					console.log(memberId);
					location.href='${contextPath}/deleteMember.me?memberId='+memberId;
					alert('싱글리어를 이용해 주셔서 감사합니다. 회원 탈퇴되었습니다.');
				}
		});
	})
	
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