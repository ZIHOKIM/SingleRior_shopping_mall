<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style>

   
    .front{margin: 30px 230px;} 
    .ordersheet{width:250px;}
	.space{width:100px;}
	.Price{text-align: right;} 
	.method{margin-left:auto; margin-right:auto;}
	#totalPrice{font-family: #008cd4 bold;} 
    .ordersheet{width:250px;}
	.space{width:100px;}
	.order_btn{background-color:#008cd4;
	  		   border-radius: 10px;
	  		   width: 300px; 	 
	  }
	.btn_span{ color: white; font-size: 25px;}
 
	  
      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
      
</style>
 </head>
 	<header class="sticky-top">
		<div>
			<jsp:include page="../common/top.jsp"/>
		</div>
	</header>
	    
	 <div class="front">
	  <div class="row g-5">
	    <div class="col-md-8">
	       <nav class="navbar navbar-expand-lg "></nav>
		     <h2 class="blog-post-title mb-1 #008cd4"><img src="https://cdn-icons-png.flaticon.com/512/2021/2021464.png" width="50px"> ?????????</h2>
		     <br>
		     <div class="blog-post">
		        <h5 class="blog-post-title mb-1">???????????? ??????</h5>
		        <hr>
		        <form>
		          <table>
				       	<tr>
				       		<td>?????????</td>
				       		<td><input type="text" class="ordersheet" name="recipient" placeholder="???????????? ??? ????????? ??????????????????" required ></td>			       		
				       	</tr>
				       	<tr>
				       		<td>????????????</td>
				       		<td><input type="text" class="ordersheet" name="recipient_phone" placeholder="???????????? ??? ??????????????? ??????????????????" required></td>
				       	</tr>
				       	<tr>
				       		<td>??????</td>
				       		<td><input type="text" class="ordersheet" name="address" placeholder="???????????? ??????????????????" name="address" id="address_kakao" readonly></td>
				       	</tr>
				       	<tr>
				       		<td>????????????</td>
				       		<td><input type="text" class="ordersheet" name="address_detail" placeholder="????????? ??????????????? ??????????????????" id="address_kakao" required></td>
				       	</tr>
		        	</table>
		        </form>
			    <br>
		        <select name="deliveryMsg" style="width:500px; height:25px;" >
		        	<option>??? ????????? ??????????????? ??????????????????</option>
		        	<option>???????????? ?????? ???????????????</option>
		        	<option>????????? ????????? ???????????????</option>
		        	<option>????????? ???????????? ???????????????</option>
		        	<option>????????? ????????? ?????? ???????????????</option>
		        </select>
		       </div>
		 
		       <br><br>
		       <h5 class="blog-post-title mb-1">???????????? ??????</h5>
		       <hr>
		       <form>
			       <table>
			       	<tr>
			       		<td>??????</td>
			       		<td><input type="text" id="b_name" name="memberName" value="${ member.memberName }"></td>			       		
			       	</tr>
			       	<tr>
			       		<td>?????????</td>
			       		<td><input type="email" id="b_email" name="email" value="${ member.email }"></td>
			       	</tr>
			       	<tr>
			       		<td>????????????</td>
			       		<td><input type="text" id="b_phone" name="buyer_phone" value="${ member.phone }"></td>
			       	</tr>
			       </table>
		       </form>
		       <br><br>
			    <%-- ${ member } --%>	
				<%--  ${ orderItem }   --%>
	        
			   <h5 class="blog-post-title mb-1">????????? ??????</h5>
			   <hr>
			   <c:set var ="sum" value="0"/>  
			   <c:forEach items="${ orderItem }" var="o" varStatus="status">
			 
 <!-- ???????????? ????????? -->				      
		  	 <input type="hidden" name="productNo" value="${ o.productNo }">
		  	 <input type="hidden" name="cartNo[]" value="${ o.cartNo }">
		  	 <input type="hidden" name="cartNo" value="${ o.cartNo }">
		  	 <input type="hidden" name="productQty" value="${ o.productQty }">
		  	 <input type="hidden" name="productPrice" value="${ o.productPrice }">
		  	 <input type="hidden" name="discount" value="${ o.discount }">
		  	 <input type="hidden" name="productOption" value="${ o.productOption }">
		 
	         <table class="table">   
		     <tr height="15px">
		    	<td scope="row" width="250" rowspan="2" class="bottomNone"><img src="${ contextPath }/resources/uploadFiles/${o.imgRename }" width="100"></td>
		     	<td width="350">??????</td>
		      	<td width="350">??????/??????</td>
		      	<td width="250">??? ?????? ??????</td>
		      	<td style="display:none" class="productNo"></td>
		     </tr>
		   	 <tr>
		     	<td class="bottomNone">
		      		<div id="product_name">${ o.boardTitle }</div>
		      	</td>
		      	<td class="bottomNone">
					<div>?????? : ${ o.productOption } </div>
					<div>?????? : ${ o.productQty }</div>		      
		      	</td>
		      	<td class="bottomNone">
		     
				  <c:set var="discountPrice" value="${ o.productPrice-(o.productPrice*o.discount/100)}"/> 	
		        	 <div style="color:red;">
		        	   	<span>
		        	   		<fmt:formatNumber type="number" maxFractionDigits="3" value="${ discountPrice * o.productQty }" var="commaPrice" />
		        	 		${ commaPrice}
		        	 	</span>??? 	
		      	    </div>
		      	  <c:set var="total" value="${ total + (discountPrice * o.productQty)}"/>
		      	  <input type="hidden" name="prices[]" value="${ discountPrice * o.productQty }">
		      	</td>
		   	 </tr>
		    </table>
	       </c:forEach>
          </div>
	     
	    <!-- ?????????  -->
	    <div class="col-md-4">
	      <div class="position-sticky" style="top: 15rem;">
	       <div class="p-4">
	         <div style="height: auto; width: 330px; border:1px solid gray; background-color:#DCDCDC; padding:7px 7px;">
	         	<form>
	         		<h3>????????????</h3>
	         		 <table>
				   		<tr>
					   		<td width="200px">??? ?????? ??????</td>
	    <!--  ?????? ??????  -->	<td class="Price" id="changedPrice"> 
					           <%--  <c:out value="${ total }"/>  --%>
					            <fmt:formatNumber type="number" maxFractionDigits="3" value="${ total }" var="commatotal" />
					            ${ commatotal }???
					   		</td> 
					   	</tr>
					   	<tr>
					   		<td width="200px" >?????????</td>
					   		<td class="Price" id="deliveryPrice">0 <span>???</span></td>
					   	</tr>
					   </table>
		         	</form>
		         <hr>
		         <h4>?????? ?????? ?????????<span style="color:#008cd4;" id="finalPrice" ></span></h4>
		         <hr>
		         <form>
			         <input type="checkbox" required> ?????? ????????? ?????? ???????????????.(??????)<br>
			         <input type="checkbox" required> ???????????? ?????? ?????? ??? ??? 3??? ?????? ?????? (??????)
			         <br>
			         <button type="button" class="order_btn" id="order_btn"><span class="btn_span">????????????</span></button>
		         </form>		         
		        </div>
		       </div>
			  </div>	
	    	</div>
	   	   </div>
	   	  </div>
      
	    <footer>
			<jsp:include page="../common/footer.jsp"/>
		</footer>
	
<script>
    // ?????? ?????? ????????? API
	window.onload = function(){
	    document.getElementById("address_kakao").addEventListener("click", function(){ //?????????????????? ???????????? ????????? ?????? ??????
	        new daum.Postcode({
	            oncomplete: function(data) { //????????? ????????? ??????
	                document.getElementById("address_kakao").value = data.address; // ?????? ??????
	                document.querySelector("input[name=address_detail]").focus(); // ???????????? ?????????
	            }
	        }).open();
	    });   
	    
    // ????????? & ?????? ?????? ????????????
    const price1 = $("#changedPrice").text();
    const price2 = price1.replace(/,/g, '');
    const totalPrice = parseInt(price2); 
    //console.log(typeof totalPrice);
    
    if(totalPrice > 50000){
    	var deliveryFee = 0;	 
    	 $('#deliveryPrice').text(deliveryFee.toLocaleString()+"???");
    } else { 
    	var deliveryFee = 2500;
    	 $('#deliveryPrice').text(deliveryFee.toLocaleString()+"???");
    }
	  finalPrice = deliveryFee + totalPrice
      $('#finalPrice').text(finalPrice.toLocaleString()+"???");
    }
    
	// ????????????
     document.getElementById("order_btn").addEventListener("click", function(){
    	   
    	  var IMP = window.IMP;   // ?????? ?????????
    	  IMP.init("imp24668238"); // ???: imp00000000 
    	  
    	  // ????????? ????????????
     	  var recipient = $('input[name=recipient]').val();
    	  var recipient_phone = $('input[name=recipient_phone]').val();
    	  var address = $('input[name=address]').val();
    	  var address_detail = $('input[name=address_detail]').val();
     	  var deliveryMsg = $('select[name=deliveryMsg] option:selected').text();
     	  
     	 // ????????? ????????????
    	  var memberName = $('#b_name').val();
    	  var email = $('#b_email').val();
    	  var buyer_phone = $('#b_phone').val();    	  

    	 // view??? ????????????
    	 var productNo = $('input[name=productNo]').val()
    	 var productQty = $('input[name=productQty]').val()
    	 var productPrice = $('input[name=productPrice]').val()
    	 var discount = $('input[name=discount]').val()
    	 var productOption = $('input[name=productOption]').val()
    	 var cartNo = $('input[name=cartNo]').val()
   		  
   		  // ???????????? ?????????
   		 var cartArr=[];
   		  $.each($("input[name='cartNo[]']"),function(k,v){
   			cartArr[cartArr.length] = $(v).val();
   			});   		  
   		  console.log(cartArr);
   		
    	 var amount = finalPrice;
    	 
    	 // ??????????????? ???????????? 
   	      IMP.request_pay({ 
   	          pg: "html5_inicis",
   	          pay_method: "card",
   	          merchant_uid: new Date().getTime(),   // ????????????(DB ?????? ??????)
   	          name: "SingleRior_?????????",
   	          amount: 500, // ?????? ????????? ?????? amount ?????? 
   	       	  buyer_email: email,
 	          buyer_name: memberName,
 	          buyer_tel: buyer_phone,

   	      }, function (rsp) { // callback
   	          if (rsp.success) {
	   	         console.log(rsp);	   	       
   	                    $.ajax({
			            	  url: "${contextPath}/orderResult.st", 
			            	  type: "post",
			            	  data: {memberName:memberName,
			    			         email:email,
			    			         buyer_phone:buyer_phone,
			    			         recipient:recipient,
			    			         recipient_phone:recipient_phone,
			    			         address:address,
			    			         address_detail:address_detail,
			    			         deliveryMsg:deliveryMsg,
			    			         finalPrice:finalPrice,
			    			         cartArr:cartArr,
			            		     productNo:productNo,
			   			             productQty:productQty,
			   			             productPrice:productPrice,
			   			             discount:discount,
			   			             productOption:productOption,
				   			         imp_uid: rsp.imp_uid,
				   	                 merchant_uid: rsp.merchant_uid},
							  success: function(data){
								  console.log(data);
			                	  location.href='${contextPath}/finalOrder.st;'

			  		   	    }
		              })
   	              alert("????????????");     
   	          } else {
   	        	 alert("????????? ?????????????????????. ?????? ??????????????????");
   	          }
   	      }); 
     });
</script>
</body>
</html>	
