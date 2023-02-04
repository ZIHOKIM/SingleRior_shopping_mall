<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
    	 <style>
    	 
    	 #logo {
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
			}
			
			
			@font-face {
				font-family: 'BMJUA';
				src:
					url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff')
					format('woff');
				font-weight: normal;
				font-style: normal;
			}
			
			* {
				font-family: 'BMJUA';
			}
			
			#pInsert{
			
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
				margin-top:30px;	
			}
		
			tr td{
				margin-right:50px;
				margin-left:50px;
				
			}
			.btn{
			
				display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				
			
			}
    	 
    	 
    	 
    	 </style>
    	 
    	 
    </head>
    <body>
    
	<jsp:include page="../common/adminTop.jsp"/>
	<jsp:include page="../common/adminLeft.jsp"/>
	
            
            <div class="container">
		<main>
			<div class="py-5 text-center">
			<img class="d-block mx-auto mb-4" src="${ contextPath }/resources/image/SingleRior_logo.png" alt="" width="330">
			</div>

			<div style="margin-left: 350px; margin-right: 350px;">
				<div style="text-align:center;"><h3>관리자 정보 수정</h3></div><br><br>
				<form class="needs-validation" action="${ contextPath }/editAdmin.adm" method="POST" onsubmit="return newSubmit()">
					<div class="row g-3">
						<div class="col-12">
							<label for="id" class="form-label">아이디</label>
							<input type="text" class="form-control" id="memberId" value="${m.memberId}" name="memberId" readonly>
							<span id="idCheckMsg"></span>
						</div>
						
						<div class="col-12">
							<label for="pwd" class="form-label">새로운 비밀번호</label>
							<input type="password" class="form-control" id="memberPwd" name="memberPwd" >
							<span id="pwdCheckMsg"></span>
						</div>
						
						<div class="col-12">
							<label for="pwdConfirm" class="form-label">새로운 비밀번호 확인</label>
							<input type="password" class="form-control" id="pwdConfirm" >
							<span id="pwdConfirmMsg"></span>
						</div>
						
						<div class="col-12">
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" id="memberName" name="memberName" value="${m.memberName}" required>
						</div>
						
						<div class="col-12">
							<label for="nickName" class="form-label">닉네임</label>
							<input type="text" class="form-control" id="nickName" name="nickName" value="${m.nickName }" readonly>
							<span id="nickNameCheckMsg"></span>
						</div>

							<label for="email" class="form-label">이메일</label>
						<div class="input-group mb-3">
 							 <input type="email" class="form-control" id="email" name="email" value=${m.email } aria-label="Recipient's username" aria-describedby="button-addon2" required>
						</div>
							 
						<div class="col-12">
							<label for="phone" class="form-label">핸드폰 번호 (-포함)</label>
							<input type="text" class="form-control" id="phone" name="phone" value="${m.phone }"required>
						</div>
						<div class="col-12">
							<label for="address" class="form-label">주소</label>
							<input type="text" class="form-control" id="address_kakao" name="address" value="${m.address}" required>
						</div>
						
						<br><br><br><br><br>
						
<!-- 					<input type='submit' id="enrollBtn" class="w-100 btn btn-light btn-lg" style="background:#008cd4; color:white" value="회원 정보수정">
						<input type='button' id="enrollBtn" class="w-100 btn btn-light btn-lg" style="background:#008cd4; color:white" value="탈퇴하기">
 -->			 
 						<button type="submit" class="btn btn-primary" id="enrollBtn">관리자 정보 수정</button>
 
 				</div>
				</form>
			</div>
			<br>
		</main>
	
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; SingleRior 2022</div>
                        </div>
                    </div>
                </footer>
            </div>
        <script>
	        let nickNameChecked = true;
	    	let passwordChecked = true;
	    	let passwordConfirmChecked = true;
	    	let emailChecked = true;
       
	    //닉네임 중복 확인	
	    $(function(){
        	$('#nickName').on('focusout',function(e){//마우스의 포커스가 밖으로 나갔을때
        		let nickName=$('#nickName').val();//닉네임의 값을 객체에 담음
        		let memberNickName='${m.nickName}'//디비에 있는 닉네임;
        		if(nickName.equals("")){
        			$('#nickNameCheckMsg').html('값을 입력해주세요.');
					$('#nickNameCheckMsg').css('color','red');
					nickNameChecked=false;
        			
        		}else if(nickName!=memberNickName){
        			$.ajax({// ajax이용!!!
        				url:'${contextPath}/checkNickName.me',// 이현씨가 작성한 메소드로 이동 
        				data:{nickName:nickName},
        				success:(data)=>{//데이터 성공시 값 
//        					console.log(data);
        					if(data==0){//0일때는 db에 닉네임이 없다.
        						$('#nickNameCheckMsg').html('멋진 닉네임이에요!');
        						$('#nickNameCheckMsg').css('color','green');
        						nickNameChecked=true;
        					}else if(data==1){
        						$('#nickNameCheckMsg').html('이미 사용중인 닉네임입니다.');
        						$('#nickNameCheckMsg').css('color','red');
        						nickNameChecked=false;
        					}
        				},
        				error:(data)=>{
        					console.log(data);
        				}
        			});
        		}else{
        			$('#nickNameCheckMsg').html('');
        			nickNameChecked=true;
        		}
        	});
        });
        //비밀번호
	    $(function(){
	    	$('#memberPwd').on('focusout',function(){//새로운 비밀번호 입력 후 focusout가 되면 실행
	    		let memberPwd=$('#memberPwd').val();// 사용자가 입력한 값을 변수에 담는다
	    		if(memberPwd!=''){//비밀번호 적는 란이 빈공간이 아니라면 정규표현식 검사 하고 다를때랑 같을 때 확인
	    			const pwdReg=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/;
	    				if(!pwdReg.test(memberPwd)){
	    					$('#pwdCheckMsg').html('영문,숫자,특수기호를 포함한 6자 이상의 비밀번호를 입력해주세요.');
	    					$('#pwdCheckMsg').css('color','red');
	    					passwordChecked=false;
	    				}else{
	    					$('#pwdCheckMsg').html('정규표현식 맞음');
	    					passwordChecked=true;
	    				}
	    		}else{//비밀번호 적는란이 빈공간이면
					$('#pwdCheckMsg').html('');//메세지 적는 란 html을 빈공간으로 넣고 
					$('#memberPwd').val('');//input태그도 빈공간으로 놓는다.
					passwordChecked=true;
	    		}		
	    	});
	   	// 비밀번호 작성과 비밀번호확인란이 같은지 확인하기!!
	    	$('#pwdConfirm').focusout(function(e){
	    		if($('#memberPwd').val()!=$('#pwdConfirm').val()){
	    			$('#pwdConfirmMsg').html('비밀번호 불일치');
	    			$('#pwdConfirmMsg').css('color','red');
	    			passwordConfirmChecked=false;
	    		}else{
	    			$('#pwdConfirmMsg').html('비밀번호 일치');
	    			$('#pwdConfirmMsg').css('color','green');
	    			passwordConfirmChecked=true;
	    		}
	    		if($('#pwdConfirm').val()==''){
	    			$('#pwdConfirmMsg').html('');
	    		}
	    	});
	    });
	    
        function newSubmit(){
        	
        	if(!passwordChecked){
        		$('#memberPwd').focus();
        		$('#pwdCheckMsg').html('현재 비밀번호 불일치');
        		$('#pwdCheckMsg').css('color','red');
        		return false;
        	}
        	if(!nickNameChecked){
        		$('#nickName').focus();
        		return false;
        	}
        	if(!passwordConfirmChecked){
        		$('#pwdConfirm').focus();
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
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='${ pageContext.servletContext.contextPath }/resources/js/scripts.js'></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-area-demo.js"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/js/datatables-simple-demo.js"></script>
    </body>
</html>
