<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{margin:auto;margin-top:70px;max-width:1500px;}
	.table{
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
	#cartDetail{margin:auto;margin-top:30px;max-width:1400px;}
	#deleteSubmit{float:right;}
	table tr:nth-child(n+2){text-align:center;}
	table tr:nth-child(n+3){margin-top:20px;}
	#cart div{margin:0 auto;}
	#pay{padding:50px;text-align:center;font-size:30px;}
	#pay table{display: flex;flex-direction: row;justify-content: center;align-items: center;}
	.bottomNone{border-bottom: none;}
	img{cursor:pointer;}
	img:hover{opacity: 0.8;}

</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<section>
		<h1 style="text-align:left">장바구니</h1><br><br>
			<c:if test="${ !empty cartList  }">
				<input type='checkbox' id='selectAll' value='selectall'/>&nbsp;&nbsp;<h4 style="display:inline-block" onclick="">전체선택</h4>
				<button id= "deleteSubmit" type="button" class="btn btn-light btn-sm" style="background:#008cd4; color:white">삭제</button>
			</c:if>
			<c:if test="${ !empty cartList  }">
				<form action="${ contextPath }/payment.st" id="submitCartOrder" method="post">
					<c:forEach items="${cartList }" var="cr">
						<div id="cart">
							<table class="table">
							    <tr>
							      <td scope="row" colspan="4"><input class="checkbox form-check-input" type="checkbox" value="${cr.cartNo }"></td>
							    </tr>
							    <tr height="15">
							    	<td scope="row" width="250" rowspan="2" class="bottomNone"><img class="img" src="${ contextPath }/resources/uploadFiles/${cr.imgRename }" width="160"></td>
							     	<td width="350">상품</td>
							      	<td width="350">옵션/수량</td>
							      	<td width="250">상품 금액</td>
							      	<td style="display:none" class="productNo">${cr.productNo }</td>
							      	<td style="display:none" class="boardNo">${cr.boardNo }</td>
							   	</tr>
							   	<tr>
							     	<td class="bottomNone">
							      		<div>${cr.boardTitle }</div>
							      	</td>
							      	<td class="bottomNone">
										<div>옵션 : ${cr.productOption }</div>
										<div>수량 : ${cr.quantity }개</div>		      
							      	</td>
							      	<td class="bottomNone">
							      		<div><span class="price"><fmt:formatNumber value="${cr.lastPrice }" pattern="#,###"/></span>원</div>
							      	</td>
							   	</tr>
							</table>
							<input type="hidden" value="-1" name="cartNo" class="cartNo">
						</div>
					</c:forEach>
				</form>
			</c:if>
			<c:if test="${ empty cartList  }">
				<div class="alert alert-secondary" role="alert" style="margin:30px;">
 					장바구니에 담긴 상품이 없습니다!
				</div>
			</c:if>
			<c:if test="${ !empty cartList  }">
				<div id="pay">
					<table>
						<tr>
							<td width="300px;" >선택상품금액<br>
								<div id="sItems">0원</div>
							</td>
							<td width="200px;">+
							</td>
							<td width="300px;">배송비
								<div id="delivery">0원</div>
							</td>
							<td width="300px;">총 주문금액</td>
							<td style="font-size:40px; color:#008cd4" id="allItemPrice">0원</td>
						</tr>
					</table>
				</div>
				<div class="d-grid gap-2">
					  <button class="order_btn btn" type="button" style="background:#008cd4; color:white" id="order_btn">구매하기</button>
				</div>
			</c:if>
	</section>
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
	
	window.onload = () =>{
		var imgs = document.getElementsByClassName("img");
// 		console.log(imgs);
		for(img of imgs){
			img.addEventListener('click',function(){
// 				console.log(this);
				const productNo= this.parentNode.parentNode.childNodes[9].innerText;
				const boardNo= this.parentNode.parentNode.childNodes[11].innerText;
				location.href='${contextPath}/productDetail.st?productNo=' + productNo + '&boardNo='+ boardNo +'&page=' + ${pi.currentPage};
			})
		}
		
		
		var orderBtn = document.getElementById("order_btn");
// 		console.log(orderBtn);
		var OrderItems;
		orderBtn.addEventListener('click',function(){
			var checkboxs = document.getElementsByClassName("checkbox");
// 			console.log(checkboxs);
			for(var i=0; i<checkboxs.length; i++){
			var forms;
				
				if(checkboxs[i].checked == true){
					var cartNoInput = checkboxs[i].value;
					var cartNo = checkboxs[i].parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[3];
					cartNo.value = cartNoInput;
				}else{
					var cartNo = checkboxs[i].parentNode.parentNode.parentNode.parentNode.parentNode.childNodes[3];
					console.log(cartNo.value);
				}
				
			}
			var form = document.getElementById("submitCartOrder");
				form.submit();
		});
		
		
	}	
	
	$(function(){
		
		// 금액 입력
		let totalPrice = 0;
		let finalTotalPrice = 0;
		let price = 0;
		let prices = 0;
		let iPrice = 0;
		let delivery = 0;
		let allPrice = 0;

		$(".table").each(function(index,element){
			var checkbox = $(element).find('.checkbox');
			var price = $(element).find('.price');
// 			console.log(price);
			checkbox.click(function(){
// 				var d = $(this).find('.price');
				if(checkbox.prop("checked")){
					price = $(this).parent().parent().parent().find('.price').text();
					prices = price.replace(/\,/g,'');
					iPrice = parseInt(prices);
					totalPrice += iPrice;
					
					console.log(totalPrice);
				}else{
					price = $(this).parent().parent().parent().find('.price').text();
					prices = price.replace(/\,/g,'');
					iPrice = parseInt(prices);
					totalPrice -= iPrice;
					console.log(totalPrice);
				}
				$('#sItems').text(totalPrice.toLocaleString()+"원");
				if(totalPrice>50000 || totalPrice ==0){
					delivery = 0;
					$('#delivery').text(delivery.toLocaleString()+"원");
				}else{
					delivery = 2500;
					$('#delivery').text(delivery.toLocaleString()+"원");
				}
				
				allPrice = delivery + totalPrice
				$("#allItemPrice").text(allPrice.toLocaleString()+"원");
				
			})
			
		});
		
		$('#selectAll').change(function(){
			totalPrice = 0;
			if($("#selectAll").prop("checked")){
				$('.checkbox').prop("checked",true);
				
				$('.price').each(function(index,element){
					price = $(element).text();
					prices = price.replace(/\,/g,'');
					iPrice = parseInt(prices);
					totalPrice += iPrice;
				});
					console.log(totalPrice);
				
// 					console.log("+ : "+ totalPrice);
					$('#sItems').text(totalPrice.toLocaleString()+"원");
					if(totalPrice>50000 || totalPrice ==0){
						delivery = 0;
						$('#delivery').text(delivery.toLocaleString()+"원");
					}else{
						delivery = 2500;
						$('#delivery').text(delivery.toLocaleString()+"원");
					}
					allPrice = delivery + totalPrice
					$("#allItemPrice").text(allPrice.toLocaleString()+"원");
				
			}else {
				$('.checkbox').prop("checked",false);
				$('.price').each(function(index,element){
					price = $(element).text();
					prices = price.replace(/\,/g,'');
					iPrice = parseInt(prices);
					totalPrice = 0
				});
// 				console.log("- : "+totalPrice);
				$('#sItems').text(totalPrice.toLocaleString()+"원");
				if(totalPrice>50000 || totalPrice ==0){
					delivery = 0;
					$('#delivery').text(delivery.toLocaleString()+"원");
				}else{
					delivery = 2500;
					$('#delivery').text(delivery.toLocaleString()+"원");
				}
				allPrice = delivery + totalPrice
				$("#allItemPrice").text(allPrice.toLocaleString()+"원");
			}
		})
		
		
		$('.checkbox').change(function(){
			var total = $('.checkbox').length;
			var checked = $('.checkbox:checked').length;
			
			if(!$(this).prop("checked")){
				$('#selectAll').prop("checked",false);
			}
			if(total == checked){
				$('#selectAll').prop("checked",true);
			}
		});
		
		
		$('#deleteSubmit').on('click',function(){
			const checkBoxs = $('.checkbox');
// 			console.log(checkBoxs);
			for(var i=0; i<checkBoxs.length; i++){
				if(checkBoxs[i].checked ==true){
					const cartNo = checkBoxs[i].value;
					console.log(cartNo);
					location.href='${contextPath}/deleteCart.me?cartNo=' + cartNo;
				}
			} 
		});
	})
	
	</script>
</body>
</html>