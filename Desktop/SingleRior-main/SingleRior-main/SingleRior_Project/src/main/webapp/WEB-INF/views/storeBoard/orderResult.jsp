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
 
 .btn{text-align: center;}
 .btn1{display :inline-block;}
 .tds{text-align: center;}
 
 table{
 	border: 1px gray solid;
 	font-size: 18px/* 1rem */;}
 table tr {
 	border: 1px gray solid;
 	}
  table tr td{
 	border: 1px gray solid;
 	}	
	.wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 70vh;
  background: #F5F5F5;
}

.content {
  border: 2px solid #008cd4;
  font-size: 2rem;
  padding: 1rem;
  border-radius: 1rem;
  background: white;
  width: 400px; height:300px;
}

.find-btn{
	text-align: center;
}
.find-btn1{
	display :inline-block;
}

</style>
</head>
<body>
<header class="sticky-top">
		<div>
			<jsp:include page="../common/top.jsp"/>
		</div>
	</header>
	
<div class="wrapper" >
  <div class="content"><img src="https://cdn-icons-png.flaticon.com/512/4003/4003644.png" width="70px"> <br>
  <span>고객님 주문이 완료되었습니다.</span><br>
  
 	 <!-- <div class="content">
 	 <span style="font-size:25px;">　</span><br>
 	 <br><br> -->
 	 <!-- 	<table>
 	 		<tr>
 	 			<td style="width:80px" class="tds">주문번호</td>
 	 			<td style="width:280px"> 20230102</td>
 	 		</tr>
 	 		<tr>
 	 			<td class="tds">주문일자</td>
 	 			<td> 2023-01-01</td>
 	 		</tr>
 	 		<tr>
 	 			<td class="tds">배송지</td>
 	 			<td>서울시 종로구 새문안로 3길 23</td>
 	 		</tr>
 	 		<tr>
 	 			<td class="tds">주문금액</td>
 	 			<td>23,000원</td>
 	 		</tr>	  
 	 	</table> -->
 	 	<br>
 	 	<div class="find-btn">
 	 		<button type="button" class="find-btn1" style="width:150px;height:50px;font-size:20px;background-color:#008cd4; color:white;" onclick="location.href='${contextPath}/storeList.st'">계속 쇼핑하기</button>
			<button type="button" class="find-btn1" style="width:150px;height:50px;font-size:20px;" onclick="location.href='${contextPath}/orderList.me'">구매내역 보기</button>
 	 	</div>
 	 </div>
  </div>
</div>
</body>
<script>
</script>
</html>