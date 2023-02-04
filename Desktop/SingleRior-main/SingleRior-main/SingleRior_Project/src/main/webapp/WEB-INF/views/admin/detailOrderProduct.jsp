<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
    	<style>
    	
    		section{
				margin:auto;
				max-width:1500px;
				}
			
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
			tr td{
		 		text-align:center;
		
			}
</style>
    </head>
    <body>
     
	<jsp:include page="../common/adminTop.jsp"/>
	<jsp:include page="../common/adminLeft.jsp"/>
	
<!-------------------------------------------------------- 내용 ----------------------------------------------------------------------- -->            
            <div id="layoutSidenav_content">
                <main>
                    <div id="logo">
                    <img src="${ pageContext.servletContext.contextPath }/resources/image/SingleRior_logo.png" style="width:250px; height:100px;">
                    <br>
                    <h1>상세 주문 목록</h1>
                    </div>
                    
          
                    <div id="pInsert">
                    <section >
						<h1 style="text-align:left"></h1><br><br>
						<div id="orderProduct">
							<span><button type="button" class="btn btn-danger" onclick="cancelTotalProduct('${list[0].merId}','${list[0].impUid}',${list[0].orderNo })" >전체 취소</button></span>
							<br>
							<span>주문번호 : ${list[0].orderNo}</span>&nbsp;&nbsp;&nbsp;
							<span>주문일자 : ${list[0].orderDate}</span>
							<span style="float:right;">총 주문 금액 : <fmt:formatNumber value="${list[0].orderTotalPrice}" pattern="#,###"/>원</span>
							
							<table class="table">
							    <c:forEach items="${list}" var="l">
							    
							    <tr>
							      <td scope="row" colspan="7"></td>
							    </tr>
							    <tr height="15">
							    	<td scope="row" width="250" rowspan="2"><img src="resources/uploadFiles/${l.imgServerName}" width="160"></td>
							     	<td><h4>상품 번호</h4>
							      	</td>
							     	<td><h4>상품 이름</h4>
							      	</td>
							      	<td><h4>옵션</h4>	      
							      	</td>
							      	<td><h4>개수</h4>
							      	</td>
							      	<td><h4>상품 금액</h4>
							      	</td>
							      	<td><h4>상태</h4></td>
							      	<td><h4>결제취소</h4></td>
							   	</tr>
							   	<tr>
							   		<td class="orderDetailNo">${l.orderDetailNo}</td>
							     	<td>
							      		${l.productName}
							      	</td>
							      	<td>
										${l.productOption}		      
							      	</td>
							      	<td>
							      		${l.productQuantity} 개
							      	</td>
							      	<td>
							      		<fmt:formatNumber value="${l.productPrice}" pattern="#,###"/>원
							      	</td>
							      	<td>${l.status }<br>
							      	<c:if test="${l.status ne '주문취소'  }">
							      	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop${l.orderDetailNo }">
							      	상태 변경
							      	</button>
							      	</c:if>
							      	</td>
							      	<c:if test="${l.status ne '주문취소'  }">
							      	<td><br>
							      	
							      	<button type="button" class="btn btn-danger" onclick="cancelProduct('${l.merId}','${l.impUid}','${l.orderDetailNo}','${l.orderNo }');">결제취소</button>
							      	
							      	</td>
									</c:if>
								   	</tr>

								<div class="modal fade" id="staticBackdrop${l.orderDetailNo }"
									data-bs-backdrop="static" data-bs-keyboard="false"
									tabindex="-1" aria-labelledby="staticBackdropLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h1 class="modal-title fs-5" id="staticBackdropLabel">
													상태값 변경</h1>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<form action="${contextPath}/changeDeli.adm" method="post">
											<div class="modal-body">
												<input type="hidden" name="orderDetailNo" value="${l.orderDetailNo}">
												<select id="changeDeli" class="form-select form-select-lg mb-3" name="changeDeli" aria-label=".form-select-lg example">
												  <option name="changeDeli" value="결제완료" selected>결제완료</option>
												  <option name="changeDeli" value="배송준비">배송준비</option>
												  <option name="changeDeli" value="배송중">배송중</option>
												  <option name="changeDeli" value="배송완료">배송완료</option>
												</select>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">닫기</button>
												<button type="submit" class="btn btn-primary" id="changeState">변경</button>
											</div>
											</form>
										</div>
									</div>
								</div>
							</c:forEach>
							   	<tr>
							      <td scope="row" colspan="7"></td>
							    </tr>
							</table>
						</div><br><br>
						<div class="orderInfo address">
							<h3>배송지 정보</h3>
							<hr>
							<h5>받는 사람</h5>
							<p>${op.recipient }</p>
							<br>
							<h5>연락처</h5>
							<p>${op.reciPhone }</p>
							<br>
							<h5>주소</h5>
							<p>${op.reciAddress }</p>
							<br>
							<h5>배송 메모</h5>
							<p>${op.deliveryMsg }</p>
						</div>
						<br><br>
						<div class="orderInfo pay">
							<h3>결제 정보</h3>
							<hr>
							<h5>상품 금액</h5><p>12,500원</p><br>
							<h5>배송비</h5><p>2,500원</p><br>
							<h5>결제금액</h5><p><fmt:formatNumber value="${list[0].orderTotalPrice}" pattern="#,###"/>원</p><br>
							<h5>결제방법</h5><p>카드결제</p><br>
							<h5>주문자</h5><p>${op.memberName }</p><br>
							<h5>연락처</h5><p>${op.phone}</p><br>
							<h5>이메일</h5><p>${op.email }</p><br>
						</div>
						<br><br>
						<div class="orderInfo Account">
							<h3>가상계좌정보(무통장입금)</h3>
							<hr>
							<h5>은행명</h5><p>국민은행</p><br>
							<h5>계좌번호</h5><p>123-456789-153</p><br>
							<h5>예금주</h5><p>주식회사 씽씽마켓</p><br>
							<h5>입금금액</h5><p>12,500원</p><br>
							<h5>기간</h5><p>2022-11-08 23:59까지</p><br>
						</div>
					</section>

                    </div>
                    
                    
                    
                    
                
<!-------------------------------------------------------- 내용 ----------------------------------------------------------------------- -->                
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; SingleRior 2022</div>
                        </div>
                    </div>
                </footer>
            <!-- 주문 취소 모달창 -->
	<div class="modal" tabindex="-1" id="orderCancelModal">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	     		 <div class="modal-header">
	       		 <h5 class="modal-title">주문을 취소하시겠습니까?</h5>
	       		 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	    	  </div>
	    	  <div class="modal-body">
	      		  <p>배송중이거나 구매확정일 경우 관리자에 주문취소가 철회될 수 있습니다.</p>
	      		  <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
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
								rows="3" placeholder="기타를 선택하신 경우 입력해주세요." style="resize:none;"></textarea>
						</div>
	     	 </div>
			 <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
				<button type="button" class="btn btn-light" style="background:#008cd4; color:white">주문취소</button>
	     	 </div>
	    </div>
	  </div>
	</div>
	
	<!-- 배송지 변경 모달창 -->
	<div class="modal" tabindex="-1" id="orderAddressModal">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
	     		 <div class="modal-header">
	       		 <h5 class="modal-title">배송지 변경</h5>
	       		 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	    	  </div>
	    	  <div class="modal-body">
	      		  <div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">받는 사람</label>
 				 		<input type="text" class="form-control" id="exampleFormControlInput1">
				  </div>
	      		   <div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">연락처</label>
 				 		<input type="text" class="form-control" id="exampleFormControlInput1">
				  </div>
	      		  <div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">주소</label>
 				 		<input type="text" class="form-control" id="exampleFormControlInput1">
				  </div>
	      		  <div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">배송메모</label>
 				 		<input type="text" class="form-control" id="exampleFormControlInput1">
				  </div>
	     	 </div>
			 <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">창닫기</button>
				<button type="button" class="btn btn-light" style="background:#008cd4; color:white">배송지변경</button>
	     	 </div>
	     	 
	    </div>
	  </div>
	</div>
		

</main>
	</div>
   
        <script>
        
        	const cancelProduct = (merId,impUid,orderDetailNo,orderNo) =>{
	
        		const yn=confirm('결제 취소하시겠습니까?')
        		
        		
        		if(yn){
        			
        		$.ajax({
        			type: "POST",  
        			url: "${contextPath}/cancelProduct.adm", 
        			data: JSON.stringify({
        		        merId: merId,
        		        impUid: impUid,
        		        orderDetailNo:orderDetailNo,
        		        orderNo:orderNo
        		      }),
        		   contentType: "application/json",
        		   success:(data)=>{
        			   if(data==0){
        				   alert("결제 취소가 성공 하였습니다.");
        				   location.href="${contextPath}/detailOrderProduct.adm?orderNo="+orderNo;
        			   }else{
        				   alert("결제 취소가 실패 하였습니다.")
        			   }
        		   }
        		   
        		    }); 
        		}else{
        			alert("결제취소를 취소합니다람쥐")
        		}
        		}
        	
			const cancelTotalProduct=(merId,impUid,orderNo)=>{
							
			const yn=confirm('전체 결제 취소하시겠습니까?')
        		
        		
        		if(yn){
        			
        		$.ajax({
        			type: "POST",  
        			url: "${contextPath}/cancelTotalProduct.adm", 
        			data: JSON.stringify({
        		        merId: merId,
        		        impUid: impUid,
        		        orderNo:orderNo
        		      }),
        		   contentType: "application/json",
        		    success:(data)=>{
        			   if(data==0){
        				   alert("전체 결제 취소가 성공 하였습니다.");
        				   location.href="${contextPath}/detailOrderProduct.adm?orderNo="+orderNo;
        			   }else{
        				   alert("결제 취소가 실패 하였습니다.")
        			   } 
        		   }
        		   
        		    }); 
        		}else{
        			alert("결제취소를 취소합니다람쥐")
        		}
								
			}
        	</script>
        
        
<!--         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
<%--         <script src='${ pageContext.servletContext.contextPath }/resources/js/scripts.js'></script> --%>
<!--         <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script> -->
<%--         <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-area-demo.js"></script> --%>
<%--         <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-bar-demo.js"></script> --%>
<!--         <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script> -->
<%--         <script src="${ pageContext.servletContext.contextPath }/resources/js/datatables-simple-demo.js"></script> --%>
    </body>
</html>

