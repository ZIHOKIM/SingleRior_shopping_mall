<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
	}
	#orderProduct{
		margin:auto; 
 		margin-top:50px; 
 		max-width:1500px;
 		padding:30px;
		background-color:#F5F5F5;
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
		border-bottom-left-radius: 10px;
		border-bottom-right-radius: 10px;
	}
	.orderInfo h3,h5,h6{display:inline-block; padding:10px;}
	.orderInfo h3{color:#008cd4;}
	.orderInfo h5{color:gray; margin-top:3px;}
	.orderInfo p{float:right;}
	img:hover{cursor:pointer}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<section>
		<h1 style="text-align:left">주문상세</h1><br><br>
		<div id="orderProduct">
			<c:if test="${ !empty oList }">
				<span>주문번호 : ${fn:replace(oList[0].orderDate, '-', '')}${oList[0].orderNo }</span>&nbsp;&nbsp;&nbsp;
				<span>주문일자 : ${oList[0].orderDate }</span>
				<c:forEach items="${oList }" var="ol">
					<table class="table">
					    <tr>
					      <td scope="row" colspan="5"></td>
					    </tr>
					    <tr height="15">
					    	<td scope="row" width="250" rowspan="2">
					    		<img src="${ contextPath }/resources/uploadFiles/${ ol.imgRename }" width="160" class="img">
					    		<input type="hidden" value="${ ol.productNo }" class="productNo">
					    	</td>
					     	<td width="300">상품</td>
					      	<td width="300">옵션</td>
					      	<td width="300">상품 금액</td>
					      	<td width="300">주문상태</td>
					   	</tr>
					   	<tr>
					     	<td>
					      		<div>${ ol.boardTitle }</div>
					      	</td>
					      	<td>
								<div>${ ol.productOption }</div>		      
					      	</td>
					      	<td>
					      		<div><fmt:formatNumber value="${ol.salePrice }" pattern="#,###"/>원</div>
					      	</td>
					      	<td>${ ol.status }</td>
					   	</tr>
					</table>
				</c:forEach>
			</c:if>
		</div><br><br>
		<div class="orderInfo address">
			<h3>배송지 정보</h3>
			<p><button type="button" class="btn btn-light" style="background:#008cd4; color:white;" data-bs-toggle="modal" data-bs-target="#orderAddressModal">배송지변경</button></p>
			<hr>
			<h5>받는 사람</h5>
			<p id="returnRecipient">${oList[0].recipient }</p>
			<br>
			<h5>연락처</h5>
			<p id="returnReciPhone">${oList[0].reciPhone }</p>
			<br>
			<h5>주소</h5>
			<p id="returnReciAddress">${oList[0].reciAddress }</p>
			<br>
			<h5>배송 메모</h5>
			<p id="returnDeliveryMsg">${oList[0].deliveryMsg }</p>
		</div>
		<br><br>
		<div class="orderInfo pay">
			<h3>결제 정보</h3>
			<hr>
			<c:if test="${!empty pay }">
			<h5>결제 방법</h5><p>카드결제</p><br>
			<h5>결제 날짜</h5><p>${ pay.payDate }</p><br>
			<h5>결제금액</h5><p><fmt:formatNumber value="${ pay.payAmount }" pattern="#,###"/>원</p><br>
			<h5>주문자</h5><p>${loginUser.memberName }</p><br>
			<h5>연락처</h5><p>${loginUser.phone }</p><br>
			<h5>이메일</h5><p>${loginUser.email }</p><br>
			</c:if>
		</div>
		<br><br>
	</section>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	
	<!-- 주문 취소 모달창 -->
	<div class="modal" tabindex="-1" id="orderCancelModal">
		<div class="modal-dialog modal-dialog-centered">
			<form action="${contextPath}/orderCancel.me" method="post">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">주문을 취소하시겠습니까?</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>배송중이거나 구매확정일 경우 관리자에 주문취소가 철회될 수 있습니다.</p>
						<select class="form-select form-select-lg mb-3"
							aria-label=".form-select-lg example" name="cancelCate">
							<option selected>취소 이유 선택</option>
							<option value="단순변심">단순변심</option>
							<option value="배송지연">배송지연</option>
							<option value="품절">품절</option>
							<option value="재주문">재주문</option>
							<option value="주문실수">주문실수</option>
							<option value="서비스불만족">서비스 불만족</option>
							<option value="기타">기타</option>
						</select>
						<div class="mb-3">
							<textarea class="form-control" id="exampleFormControlTextarea1"
								rows="3" placeholder="기타를 선택하신 경우 입력해주세요." style="resize: none;" name="cancelReason"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">창닫기</button>
						<button type="submit" class="btn btn-light"
							style="background: #008cd4; color: white">주문취소</button>
								<input type="hidden" value="" name="orderNo" id="orderCancelNo">
								<input type="hidden" value="" name="orderDetailNo" id="orderCancelDetailNo">
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<!-- 배송지 변경 모달창 -->
	<div class="modal" tabindex="-1" id="orderAddressModal">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	     		 <div class="modal-header">
	       		 <h5 class="modal-title" style="color:#008cd4">배송지 변경</h5>
	       		 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	    	  </div>
	    	  <div class="modal-body">
	    	  	 <p>이미 배송중인 상품이 있을 경우, 배송지 변경이 불가 할 수 있습니다.</p>
<!-- 	    	  	 <form> -->
		      		  <div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">받는 사람</label>
	 				 		<input type="text" class="form-control" name="recipient" id="changeRecipient">
					  </div>
		      		   <div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">연락처</label>
	 				 		<input type="text" class="form-control" name="reciPhone" id="changeReciPhone">
					  </div>
		      		  <div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">주소</label>
	 				 		<input type="text" class="form-control" name="address_kakao" id="address_kakao" readonly>
					  </div>
					<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">상세주소</label>
	 				 		<input type="text" class="form-control" name="reciDetailAddress" id="changeReciDetailAddress">
					  </div>
		      		  <div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">배송메모</label>
					        <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" name="deliveryMsg" id="changeDeliveryMsg">
						        <option>배송시 요청사항을 선택해주세요</option>
					        	<option>배송전에 미리 연락주세요</option>
					        	<option>부재시 문앞에 놓아주세요</option>
					        	<option>부재시 경비실에 맡겨주세요</option>
					        	<option>부재시 전화나 문자 부탁드려요</option>
							</select>
					  </div>
<!-- 	    	  	 </form> -->
	     	 </div>
			 <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
				<button type="submit" class="btn btn-light" style="background:#008cd4; color:white" id="changeDelivery">배송지변경</button>
	     	 </div>
	    </div>
	  </div>
	</div>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	
	$(function(){
		 	document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면 카카오 주소 발생
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                document.getElementById("address_kakao").value = data.address; // 주소 넣기
		                document.querySelector("input[name=reciDetailAddress]").focus(); // 상세입력 포커싱
		            }
		        }).open();
		    });
		
		
		
		$('#changeDelivery').on('click', function(e){
			let recipient = $('#changeRecipient').val();
			if(recipient == ""){
				$('#changeRecipient').focus();
				return false;
			}
			let reciPhone = $('#changeReciPhone').val();
			if(reciPhone == ""){
				$('#changeReciPhone').focus();
				return false;
			}
			let addressKakao = $('#address_kakao').val();
			if(addressKakao == ""){
				$('#address_kakao').focus();
				return false;
			}
			let reciDetailAddress = $('#changeReciDetailAddress').val();
			if(reciDetailAddress == ""){
				$('#changeReciDetailAddress').focus();
				self.close();
				return false;
			}
			let reciAddress = addressKakao+" "+reciDetailAddress;
			
			let deliveryMsg = $('#changeDeliveryMsg').val();
			if(deliveryMsg == "배송시 요청사항을 선택해주세요"){
				$('#changeDeliveryMsg').focus();
				return false;
			}
			let orderNo = '${oList[0].orderNo}';

			console.log(deliveryMsg);
			console.log(recipient);
			
			
			$('#orderAddressModal').modal('hide');
			$.ajax({
				url : '${contextPath}/changeDeliveryAddress.me',
				data : {recipient:recipient,
						reciPhone:reciPhone,
						reciAddress:reciAddress,
						deliveryMsg:deliveryMsg,
						orderNo:orderNo	
				},
				type : "post",
				success: (data) =>{
					console.log(data);
					$("#returnRecipient").text(data.recipient);
					
					$("#returnReciPhone").text(data.reciPhone);
					
					$("#returnReciAddress").text(data.reciAddress);
					
					$("#returnDeliveryMsg").text(data.deliveryMsg);
				},
				error:(data)=>{
					console.log(data);
					alert("배송지 변경 실패");
				}
			});
		});
	});
	
	
	window.onload = function(){
		var imgs = document.getElementsByClassName("img");
		for(img of imgs){
			img.addEventListener("click",function(){
				var productNo = this.parentNode.childNodes[3].value;
				location.href='${contextPath}/productDetail.st?productNo=' + productNo;
			})
		}
	} 
	
	
	
	
	
	</script>
</body>
</html>