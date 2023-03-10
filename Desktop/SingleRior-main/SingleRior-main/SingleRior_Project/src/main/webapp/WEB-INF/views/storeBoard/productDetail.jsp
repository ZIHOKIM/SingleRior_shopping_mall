<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <style>
   .category{padding:20px 200px 20px 200px;}
   .wishlist {color: #008cd4;}
   .payment_1{background-color:#008cd4; color:white; }
   .payment_2{background-color:#008cd4; color:white; }
   .inquiry{font-size:30px}
   #inquiryBtn{size: 100px; background-color:#008cd4;}
   .star{text-align:center; display:table; width:300px; height:100px; margin:0 auto;}
   .wishList {float:right;}
   .opsResultDiv {display:none;}
   .button_qty {
     line-height: 50px;
     text-align: center;
     background: white;
     border-radius: 12px;
   }
      .outer-div {
     width : 300px;
     height : 300px;
     background-color : blue;
   }
   
   .opsResultDiv {
     width : 330px;
     height : 50px;
     margin: auto;

   }
      
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
      #moreInquiry{float:right; cursor:pointer}
      #moreInquiry:hover{text-decoration:underline;}
      #moreReview{float:right; cursor:pointer}
      #moreReview:hover{text-decoration:underline;}
      
      
      .reviewTable td{padding:20px;}
      
         .starView {
      position: relative;
      font-size: 2rem;
      color: #ddd;
      }
      
      .starView input {
      width: 100%;
      height: 100%;
      position: absolute;
      left: 0;
      opacity: 0;
      cursor: pointer;
      }
      
      .starView span {
      width: 0;
      position: absolute;
      left: 0;
      color: #008cd4;
      overflow: hidden;
      pointer-events: none;
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900&amp;display=swap" rel="stylesheet">
    <!-- Custom styles for this template -->
  </head>
  <body>
  
      <header class="sticky-top">
         <div>
            <jsp:include page="../storeBoard/navbar.jsp"/>
         </div>
      </header>
      <div class="category">
         <h5><b> ?????? > ${ pList[0].topCateName } > ${ pList[0].subCateName }</b></h5>
         <h2><b> ${ pList[0].subCateName } </b></h2> 
         <br>
      </div>
<%--        ${ pList }   --%>
       <%--  ${ pList[0] }<br><br> --%>
        <%--     ${ pList[1] }
       ${ pList[2] }  --%>
   <main class="container">
      <div class="row mx-md-n5">
        <div class="col px-md-5"><div class="p-3 border bg-light">
              <img src="resources/uploadFiles/${ pList[0].imgServerName }" width="100%" height="100%">
        </div>
       </div> 
   
   <fmt:formatNumber type="number" maxFractionDigits="3" value="${ pList[0].price }" var="commaPrice" />
   <c:set var="discountPrice" value="${ pList[0].price-(pList[0].price*pList[0].discount/100)}"/>
   <fmt:formatNumber type="number" maxFractionDigits="3" value="${ pList[0].price-(pList[0].price*pList[0].discount/100)}" var="totalPrice" />
     <div class="col px-md-5">
        <div class="p-3 border bg-light">
           <table>
              <tr>
                 <td style="font-size:22px;">${ pList[0].brand }</td>
                 <td width="180px"></td>
                 <td style="padding-right: 5px;">
                     <c:if test="${ empty loginUser }">
                     <button type="button" class="btn btn-outline-danger wishListBtn" onclick="location.href='${contextPath}/loginView.me'">????????????
                  </button>
                  </c:if>
                  <c:if test="${ !empty loginUser and count == 0}">
                     <button type="button" class="btn btn-outline-danger wishListBtn" id="wishListOn">????????????</button>
                  </c:if>
                  <c:if test="${ !empty loginUser and count == 1}">
                     <button type="button" class="btn btn-outline-danger active wishListBtn" id="wishListOff">????????????</button>
                  </c:if>
                 </td>
                 <td style="padding-right: 5px;" >
                 <a href="#" id="sns_urlCoby" class="btn_share_sns" onclick="shareURL(); return false;">
                    <button type="button" class="btn btn-outline-primary" id="shareURL">????????????</button>
                 </a>
                 </td>
                 <td>
                   <c:if test="${ empty loginUser }">
                    <button type="button" class="btn btn-outline-warning" onclick="location.href='${contextPath}/loginView.me'" >????????????</button>
                   </c:if>
                     <c:if test="${ !empty loginUser }">
                    <button type="button" class="btn btn-outline-warning" onclick="$('#writeTogether').modal('show')" >????????????</button>
                    </c:if>
                 </td>
              </tr>
           </table>???????????????????????????
        <h2>${ pList[0].boardTitle }</h2>
        <p><s>${ commaPrice } ???</s></p>
        <h1><span>${ pList[0].discount }%</span>???<span style="color:#008cd4;">${ totalPrice } ???</span></h1>
        <br><br>
        <p>???????????? (${trList[0].reviewCount }) ???</p>
        <p>????????? 2,500???</p>
        <hr>
        
        
  <!--  ?????? ?????????  -->      
          <label for ="options">????????????</label>
                  <select id="changeOpiton" class="form-select" onChange="selectChange(this.value);" aria-label="Default select example">
               <option class="opsBasic" selected >?????? ????????? ??????????????????</option>
                <c:forEach items="${ fn:split( pList[0].option, ',') }" var="p">
                 <option value="${ p }" class="option">${ p }</option>
               </c:forEach>
             </select>
             <br>   
             <div class="opsResultDiv">
             <table>
                <tr>
                   <td><input type="text" id="inputOption"></td>
                   <td width="10px"></td>
                   <td>
                       <span class="count-wrap _count">
                         <button type="button" class="minus_btn" >-</button>
                            <input type="text" class="quantity_input" value="1" id="qty" readonly style="width:50px;"/>
                         <button type="button" class="plus_btn" >+</button>
                     </span>
                   </td>
                </tr>
             </table>
                <fmt:parseNumber var="i" type="number" value="${ totalPrice }"/>   
                </div>
         
           <br>
           <h2>??? <span id="changedQty">1</span>??????<span id="finalPrice2">${ totalPrice }</span>???</h2>
           <div class="btn-group">
              <c:if test="${ empty loginUser }">
              <button type="button" class="cart" style="width:200px;height:50px;font-size:20px;" onclick="location.href='${contextPath}/loginView.me'"> ???????????? </button>
            </c:if>
            <c:if test="${ !empty loginUser }">
              <button type="button" class="cart" style="width:200px;height:50px;font-size:20px;"> ???????????? </button>
            </c:if>
            <c:if test="${ empty loginUser }">   
              <button type="button" class="payment_1"  style="width:200px;height:50px;font-size:20px;" onclick="location.href='${contextPath}/loginView.me'">????????????</button>
             </c:if> 
             <c:if test="${ !empty loginUser }">   
              <button type="button" class="payment_2"  style="width:200px;height:50px;font-size:20px;" onclick="location.href='${ contextPath }/payment.st'">????????????</button>
             </c:if>
           </div>
           </div>
        </div>
        
   <!-- ???????????? ????????? ?????? ?????????-->
   <form action="${ contextPath }/payment.st" method="post" class="order_form">
		<input type="hidden" name="productNo" value="${ pList[0].productNo }">
		<input type="hidden" name="productQty" value="">
		<input type="hidden" name="productPrice" value="${ pList[0].price}">
		<input type="hidden" name="productPrice" value="${ pList[0].price}">
		<input type="hidden" name="discount" value="${ pList[0].discount }">
		<input type="hidden" name="boardTitle" value="${ pList[0].boardTitle }">
		<input type="hidden" name="productOption" value="${ p }">
		<input type="hidden" name="imgRename" value="${ pList[0].imgServerName }">
	</form> 
        
   <!--???????????? ????????? -->
    <div class="row mb-1">
    </div>
     <div class="row g-5">
       <div class="col-md-8">
         <h3 class="pb-4 mb-4 border-bottom">
           <nav class="navbar navbar-expand-lg bg-light">
           <div class="container-fluid">
             <a class="navbar-brand" href="#productInfo">????????????</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
             
             <a class="navbar-brand" href="#review">??????( ${trList[0].reviewCount } )???</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
             
               <a class="navbar-brand" href="#inquiry">????????????</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
             
               <a class="navbar-brand" href="#delivery">??????/??????</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
              </div>
             </nav>
            </h3>
   
      <!-- ?????? ?????? ????????? -->
         <article class="blog-post" id="productInfo">
           <h2 class="blog-post-title mb-1">????????????</h2>
           <p class="blog-post-meta"></p>                    
            <img src="resources/uploadFiles/${ pList[1].imgServerName }" width="100%" height="100%">
            <img src="resources/uploadFiles/${ pList[2].imgServerName }" width="100%" height="100%">           
          </article>
          
       <!-- ???????????? -->   
          <c:if test="${!empty prList }">
          <div> 
         	<hr>
        	 <article class="blog-post" id="review">
        	 
           	  <h2 class="blog-post-title mb-1" >?????? ${trList[0].reviewCount }???</h2>
              <br><br>
                 <div class="reviewContent">
                     <h2><span id="avgRating" style="color:#008cd4;"></span></h2>
              </div> 
              <br><br>
                    <c:if test="${fn:length(prList)<6}">
                   <c:forEach items="${prList}" var="pr">
                    <table class="reviewTable">
                   <tr>
                      <td>
                      <img src="${ contextPath }/resources/uploadFiles/${pr.imgServerName}" width="160" class="img">
                      </td>
                      <td>
                      <span><b>${pr.nickName }</b>??? ??????</span><br><br>
                      <span>${pr.reviewContent}</span><br><br>
                      <span>${pr.productOption}&nbsp;&nbsp;&nbsp;</span><br>
                      <span>????????? : ${pr.reviewDate }&nbsp;&nbsp;&nbsp;</span>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <span class="reviewRatingTable badge badge rounded-pill text-bg-danger" style="font-size: 1rem; float: right;">???${ pr.reviewRating }</span>
                      </td>
                   </tr>
                   </table>
                  </c:forEach>
                   </c:if>
                   <c:if test="${fn:length(prList)>5}">
                   <c:forEach items="${prList}" var="pr" begin="0" end="4">
                   <table class="reviewTable">
                   <tr>
                      <td>
                      <img src="${ contextPath }/resources/uploadFiles/${pr.imgServerName}" width="160" class="img">
                      </td>
                      <td>
                      <span><b>${pr.nickName }</b>??? ??????</span>
                      
                      <br><br>
                      <span>${pr.reviewContent}</span><br><br>
                      <span>${pr.productOption}&nbsp;&nbsp;&nbsp;</span><br>
                      <span>????????? : ${pr.reviewDate }&nbsp;&nbsp;&nbsp;</span>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <span class="reviewRatingTable badge badge rounded-pill text-bg-danger" style="font-size: 1rem; float: right;">???${ pr.reviewRating }</span>
                      </td>
                   </tr>
                   </table>
                  </c:forEach>
                  <div id="moreReview">?????????</div><br>
               </c:if>
         	 </article>
          </div>
        
         </c:if>
         <c:if test="${empty prList}">
         <hr>
         	<h2 class="blog-post-title mb-1" >?????? ${trList[0].reviewCount }???</h2>
  		     <div style="text-align:center;"><h2>????????? ?????? ????????? ?????? ???????????? ???.???</h2><br><img src="${contextPath}/resources/image/reviewZero.jpg" width="200" ></div>
         </c:if>
          <hr>
          
      <!-- ???????????? -->
           <article class="blog-post" id="inquiry">
	        <div class="blog-post-title mb-1">
	        	<form>
		        	<table>
		        		<tr>
		        			<td class="inquiry">??????</td>
		        			<td colspan="3" width="650px"></td>
		        			<c:if test="${ empty loginUser  }">
							  	<td><button type="button" class="btn btn-primary" id="inquiryBtn1" onclick="location.href='${contextPath}/loginView.me'" >????????????</button></td>
						  	</c:if>
						  	<c:if test="${ !empty loginUser }">
							  	<td><button type="button" class="btn btn-primary" id="inquiryBtn2" data-bs-toggle="modal" data-bs-target="#inquiryModal">????????????</button></td>
						  	</c:if> 
		        		</tr>
		        	</table>
	        	</form>
	 		</div>
          <%--  ${ iList }  --%>
      		<c:if test="${fn:length(iList)<6}">
		 		<c:forEach items="${ iList }" var="i">
		 		<div style="border:black solid 1px; width:600px; padding:10px 10px; border-radius:10px;">
			        <p class="blog-post-meta">${i.inquiryTitle} | 
				        <c:if test="${ i.inquiryAnswer == null }">
				        	<span style="color:#008cd4;">????????????</span>
				        </c:if>
				        <c:if test="${ i.inquiryAnswer != null }">
				        	<span style="color:#008cd4;">????????????</span>
				        </c:if>
	
				         <span style="display: inline-block; margin: 0 5px;  float:right;">
					         <c:if test="${ loginUser.memberId eq i.memberId }">
	<!--  ???????????? -->				<button type="button" class="inquiry_delete btn btn-primary">??????</button>
								<input type="hidden" name="inquiryNo" value="${ i.inquiryNo }">
					        </c:if>
				        </span>
				       </p>    
					<p> ${i.memberId} | <span id="updateDate">${i.inquiryDate}</span></p>
					<P><img src="https://cdn-icons-png.flaticon.com/512/8371/8371275.png" width="20px" height="20px">
					${ i.inquiryContent }
					</p>
					<p><img src="https://cdn-icons-png.flaticon.com/512/25/25628.png" width="20px" height="20px"> ${ i.inquiryAnswer }</p>
		    	</div>
		    	<br>
		    	</c:forEach>
		    </c:if>	    
		    	 <c:if test="${fn:length(iList)>5}">
		    	 <c:forEach items="${ iList }" var="i"  begin="0" end="4">
		 		<div style="border:black solid 1px; width:600px; padding:10px 10px; border-radius:10px;" class="inquiryDiv">
			        <p class="blog-post-meta">${i.inquiryTitle} | 
				        <c:if test="${ i.inquiryAnswer == null }">
				        	<span style="color:#008cd4;">????????????</span>
				        </c:if>
				        <c:if test="${ i.inquiryAnswer != null }">
				        	<span style="color:#008cd4;">????????????</span>
				        </c:if>
	
				         <span style="display: inline-block; margin: 0 5px;  float:right;">
					         <c:if test="${ loginUser.memberId eq i.memberId }">
	<!--  ???????????? -->				<button type="button" class="inquiry_delete btn btn-primary">??????</button>
								<input type="hidden" name="inquiryNo" value="${ i.inquiryNo }">
					        </c:if>
				        </span>
				       </p>    
					<p> ${i.memberId} | <span id="updateDate">${i.inquiryDate}</span></p>
					<P><img src="https://cdn-icons-png.flaticon.com/512/8371/8371275.png" width="20px" height="20px">
					${ i.inquiryContent }
					</p>
					<p><img src="https://cdn-icons-png.flaticon.com/512/25/25628.png" width="20px" height="20px"> ${ i.inquiryAnswer }</p>
		    	</div>
		    	<br>
		    	</c:forEach>
		    	<div id="moreInquiry">?????????</div><br>
		    	</c:if>
		    <c:if test="${ empty iList }">
		     <div style="text-align:center;"><h2>????????? ?????? ????????? ?????? ???????????? ???.???</h2><br><img src="${contextPath}/resources/image/reviewZero.jpg" width="200" ></div>
		    </c:if>
          </article>
          <hr>
          
      <!-- ??????/?????? -->
          <article class="blog-post" >
           <h2 class="blog-post-title mb-1" id="delivery">??????/??????</h2>
           <br>
           <p class="blog-post-meta">?????????</p>
         <table>
            <tr>
               <td width="150px">????????????</td>
               <td>????????????</td>
            </tr>
            <tr>
               <td>?????????</td>
               <td>2,500???</td>
            </tr>
            <tr>
               <td></td>
               <td>50,000??? ?????? ????????? ????????????</td>
            </tr>
            <tr>
               <td>?????? ?????? ??????</td>
               <td>???????????? ?????? / ?????????</td>
            </tr>
         </table>
         <br><br>
         <p class="blog-post-meta">?????????/??????</p>
         <table>
            <tr>
               <td width="150px">???????????????</td>
               <td>50,000???</td>
            </tr>
            <tr>
               <td>???????????????</td>
               <td>100,000???</td>
            </tr>
            <tr>
               <td>????????? ???</td>
               <td>??????????????? ?????? ???????????? 120 ???????????? ??????(??? ????????????) 2F, 3F</td>
            </tr>
         </table>
          </article>
       </div>
        
       <!-- ????????? ????????? -->
       <div class="col-md-4">
         <div class="position-sticky" style="top: 15rem;">
           <div class="p-4">
             <label for ="options">????????????</label>
                  <select id="changeOpiton1" class="form-select" onChange="selectChange(this.value);" aria-label="Default select example">
               <option class="opsBasic" selected >?????? ????????? ??????????????????</option>
                <c:forEach items="${fn:split( pList[0].option, ',')}" var="p">
                 <option value="${ p }" class="option">${ p }</option>
               </c:forEach>
             </select>
             <br>
            <!--  <div class="opsResultDiv1" style="border:1px solid black; width:450px; height:100px;"> -->
            <!--      <input type="text" id="inputOption"><br> -->
                 <span class="count-wrap _count">
                      <button type="button" class="minus_btn" style="height:35px;">-</button>
                         <input type="text" class="quantity_input" value="1" style="width:70px;height:30px" id="qty"/>
                      <button type="button" class="plus_btn" style="height:35px;">+</button>
               </span>
                <fmt:parseNumber var="i" type="number" value="${ totalPrice }"/>
               
                <!-- <span id="finalPrice"></span>??? -->
                </div>
           <br><br>
         
           <br>
           <h2>??? <span id="changedQty1">1</span>??????<span id="finalPrice3">${ totalPrice }</span>???</h2>
              <div class="btn-group">
              <c:if test="${ empty loginUser }">
              <button type="button" class="cart" style="width:200px;height:50px;font-size:20px;" onclick="location.href='${contextPath}/loginView.me'"> ???????????? </button>
            </c:if>
            <c:if test="${ !empty loginUser }">
              <button type="button" class="cart" style="width:200px;height:50px;font-size:20px;"> ???????????? </button>
            </c:if>
             <c:if test="${ empty loginUser }">   
              <button type="button" class="payment_1" style="width:200px;height:50px;font-size:20px;" onclick="location.href='${contextPath}/loginView.me'">????????????</button>
             </c:if> 
             <c:if test="${ !empty loginUser }">   
              <button type="button" class="payment_2" style="width:200px;height:50px;font-size:20px;" onclick="location.href='${contextPath}/payment.st'">????????????</button>
             </c:if>
              </div>
           </div>
         </div>
       </div>
     </div>
      
   <!--???????????? ????????? -->
   <div class="modal" tabindex="-1" id="inquiryModal">
     <div class="modal-dialog">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title">????????????</h5>
           <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>
         <form action="${ contextPath }/productInquiry.st" method="post">
          <input type="hidden" name="productNo" value="${ pList[0].productNo }">
          <input type="hidden" name="boardNo" value="${ pList[0].boardNo }">
            <div class="modal-body">
              <p>????????????</p>
                 <select class="form-select" aria-label="Default select example" name="inquiryTitle" id="inquiry_ops">
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
               </select>
                <br>
            <p>???????????? <span id="counter">0</span>/300</p>
            <textarea cols="50" rows="3" id="textarea" name="inquiryContent"></textarea>
            </div>
            <div style="color:#008cd4;">
            ????????? ????????? ???My Page> ?????? ??????' ?????? ????????? ???????????????????????? ?????? ???????????????.<br>
            </div>
           <div class="modal-footer">
              <button type="submit" class="btn btn-primary" id="inquiry_modal" >??????</button>
           </div>
         </form>
         </div>
        </div>
   </div>
   
   
   <!-- ???????????? ????????? -->   
   <div class="modal fade" tabindex="-1" role="dialog" id="cartModal">
      <div class="modal-dialog" role="document">
          <div class="modal-content rounded-3 shadow">
               <div class="modal-body p-4 text-center">
                 <h3 class="mb-0">??????????????? ????????? ?????????????????????. </h3>
                 <p class="mb-0"></p>
               </div>
               <div class="modal-footer flex-nowrap p-0">
                  <button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0 border-end" data-bs-dismiss="modal">?????? ????????????</button>
                 <button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0" id="yes" onclick="location.href='${ contextPath }/myCart.me'">
                    <strong>????????????</strong>
                 </button>
               </div>
          </div>
        </div>
   </div>
   
   <!-- ???????????? ?????? -->
	<div class="modal" tabindex="-1" id="deleteModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">?????? ????????? ?????????????????????????</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>?????? ????????? ????????? ???????????????.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
	      <form action="deleteInquiry.st">
	      	<input type="hidden" id="inquiryNo" name="inquiryNo">
	      	<input type="hidden" id="productNo" name="productNo" value="${ pList[0].productNo }">
	        <button type="button" class="btn btn-primary" id="confirm" >??????</button>
	      </form>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- ????????????  ??????????????? -->
	<div class="modal" tabindex="-1" id="writeTogether">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title"><img alt="" src="https://cdn-icons-png.flaticon.com/512/595/595752.png" style="width: 30px; height: 30px;">&nbsp;??????????????? ?????? ?????????????????????????</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>???????????? ???????????? ????????? ???????????? ???????????????!</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">??????</button>
	      <form action="marketBoardWrite.ma">
	      	<input type="hidden" value="${ pList[0].imgServerName }" name="imgServerName">
	      	<input type="hidden" value="${ pList[0].boardTitle }" name="boardTitle">
	      	<input type="hidden" value="${ pList[0].price }" name="price">
	      	<input type="hidden" value="${ pList[0].discount }" name="discount">
	      	<input type="hidden" value="${ pList[0].boardNo }" name="boardNo">
	      	<input type="hidden" value="${ pList[0].productNo}" name="productNo">
	        <button class="btn btn-primary">??????</button>
	      </form>
	      </div>
	    </div>
	  </div>
	</div>

</main>

    <footer>
      <jsp:include page="../common/footer.jsp"/>
   </footer>

</body>
<script>    
    // select ?????? ????????? div?????? + ?????? ????????????
     $(document).ready(function(){
       $('#changeOpiton').change(function(){
          var state = $('.option:selected').val();
          var state1 = $('#changeOpiton1').val();
           //console.log(state);
          if (state != null ){
             $('.opsResultDiv').show();
          } else {
             $('.opsResultDiv').hide();
          } 
       });
    }); 
    
     $(document).ready(function(){
        $('#changeOpiton1').change(function(){
           var state = $('.option:selected').val();
           if (state != null ){
              $('.opsResultDiv').show();
           } else {
              $('.opsResultDiv').hide();
           } 
        });
     });
     const selectChange = function(value){
         $('#inputOption').val(value);   
         
   }
   
    // ?????? ?????? & ?????? ?????? ??????
     let quantity = $('.quantity_input').val();
     $('.plus_btn').on('click', function(){
        $('.quantity_input').val(++quantity);
           var qtyPlus = $('.quantity_input').val();
           $('#changedQty').text(qtyPlus);
           $('#changedQty1').text(qtyPlus);
            //console.log(qtyPlus);
           var finalPrice = (qtyPlus * ${ i }).toLocaleString();
           $('#finalPrice').text(finalPrice);
           $('#finalPrice2').text(finalPrice);
           $('#finalPrice3').text(finalPrice);
     });
     $('.minus_btn').on('click',function(){
        if(quantity > 1){
           $('.quantity_input').val(--quantity);
                const qtyMius = $('.quantity_input').val();
                $('#changedQty').text(qtyMius);
                $('#changedQty1').text(qtyMius);
                //console.log(qtyMius);
                var finalPrice = (qtyMius * ${i}).toLocaleString();;            
               $('#finalPrice').text(finalPrice);
               $('#finalPrice2').text(finalPrice);
               $('#finalPrice3').text(finalPrice);
        }
      });

   // ???????????? ??????
    $('.cart').on('click', function(e){
       const quantity = $('.quantity_input').val();
       const productOption = $('#inputOption').val();
       //console.log(productOption);
       $.ajax({
          url: '${ contextPath }/cart.st',
          type : 'post',
          data : {memberId:'${loginUser.memberId}',
                 productNo:'${ pList[0].productNo}', 
                 quantity:quantity,
                 productOption:productOption},
          success : function(result){
                  alert('???????????? ?????? ??????');
          },
          error : function(){
                alert('???????????? ?????? ??????');   
          }
       }) 
    });
   
    	var ideletes = document.getElementsByClassName("inquiry_delete");
    	var iqn;
    	console.log(ideletes);
    	for(idelete of ideletes){
    		idelete.addEventListener("click",function(){
    			const no = this.nextElementSibling.value;
    			document.getElementById("inquiryNo").value = no;
    		
//     			document.getElementById('deleteModal').modal('show');
    			$('#deleteModal').modal('show');
    		})
    	}
    
    
    
    $('#confirm').on('click',function(){
    	
    	var inquiryNo = document.getElementById("inquiryNo").value;
    	const productNo = document.getElementById("productNo").value; 
    	console.log(inquiryNo);
    	console.log(productNo);
    	$.ajax({
              url: '${contextPath}/deleteInquiry.st',
              data: {inquiryNo:inquiryNo,productNo:productNo},
              success:(data)=>{
                 console.log(data);
                location.reload();
            
              },
              error: (data)=>{
               console.log(data);
            }
           });
    });
    
    // ?????????
    window.onload =()=>{
       $(".wishListBtn").click(function(){
            if($(this).attr("class") == "btn btn-outline-danger wishListBtn"){
                  $.ajax({
                        url: '${contextPath}/wishListOn.st',
                        data: {boardNo: ${ pList[0].boardNo }},
                        type: 'post',
                        success:(data)=>{
                           console.log(data);
                           var wishListCount = parseInt($('#wishListCount').html());
                           alert("'My Page'?????? ???????????? ??????????????????");
                      
                        },
                        error: (data)=>{
                         console.log(data);
                      }
                     });
               
                  $(this).attr("class","btn btn-outline-danger active wishListBtn");
                  
            } else if($(this).attr("class") == "btn btn-outline-danger active wishListBtn"){
                  $.ajax({
                        url: '${contextPath}/wishListOff.st',
                        data: {boardNo: ${ pList[0].boardNo }},
                        type: 'post',
                        success:(data)=>{
                           console.log(data);
                           alert("??????????????? ?????????????????????.");
                        },
                        error: (data)=>{
                         console.log(data);
                      }
                     });
                  
                  $(this).attr("class","btn btn-outline-danger wishListBtn");
            }
         })


    }
    
    // ?????? ?????????
    
        var moreReview = document.getElementById("moreReview");
    if(moreReview != null){
  		  moreReview.addEventListener("click",function(){
       var productNo = '${pList[0].productNo}';
//        console.log(productNo);
       location.href='${contextPath}/moreReview.st?productNo=' + productNo;
  	  })
    	
    }
    
   	 var moreInquiry = document.getElementById("moreInquiry");
  		  console.log(moreInquiry);
  		  if(moreInquiry != null){
	   	 moreInquiry.addEventListener("click",function(){
	       var productNo = '${pList[0].productNo}';
	//        console.log(productNo);
	       location.href='${contextPath}/moreInquiry.st?productNo=' + productNo;
	    })
  			  
  		  }

    
   // ???????????? ????????? ??????
   $(function(){
         $('#textarea').keyup(function(e){
            const input = $(this).val();
            const inputLength = input.length;

            $('#counter').html('<b>' + inputLength + '<b>');
            
            if(inputLength > 300){
               $('#counter').css('color','red');
            } else{
               $('#counter').css('color','black');
            }
         
            const piece = input.substr(0, 300);
            $(this).val(piece);
         });
   });
   
    // ??????????????? ??????, ?????? ????????????
   $('.payment_2').on('click', function(){
      let productQty = $('.quantity_input').val();
      let productOps = $('.option:selected').val();
       //console.log(productQty);  
       //console.log(productOps); 
       $('.order_form').find("input[name='productQty']").val(productQty);
       $('.order_form').find("input[name='productOption']").val(productOps);    
       $('.order_form').submit() ;   
   }); 

    // URL ????????????
   function shareURL(){

        var url = ''; 
        var textarea = document.createElement("textarea");  
        
        document.body.appendChild(textarea); 
        url = window.document.location.href; 
        textarea.value = url; 
        textarea.select();
        document.execCommand("copy");   
        document.body.removeChild(textarea); 
        
        alert("URL??? ?????????????????????.") 
    }

			
		// ?????? ?????????
		   const avgRating = document.getElementById("avgRating");
		   const rating = '${ trList[0].avgStar }';
		   
		   let print = '';

		   if(rating >= 5 ){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>';
		   }else if(rating >= 4.5){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>';
		   } else if (rating >= 4.0) {
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 3.5){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 3.0){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 2.5){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 2.0){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 1.5){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"><i class="bi bi-star-half"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   }else if(rating >= 1.0){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 0.5){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star-half"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating > 0){
		      print = '???????????? '+ rating + '??? <i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else{
		      print = '???????????? 0??? <i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   }
		   
		   avgRating.innerHTML = print; 
		
</script>
</html>