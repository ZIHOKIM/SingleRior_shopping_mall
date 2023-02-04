<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#nav{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
		font-size:30px;
		cursor:pointer;
	}
	section{
		margin:auto;
		margin-top:70px;
		max-width:1500px;
	}
	.myAskListDiv{cursor:pointer;}
</style>
</head>
<body>
	<header>
		<jsp:include page="../common/top.jsp"/>
	</header>
	<nav class="navbar navbar-expand-lg" id="nav">
			<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
				<div class="navbar-nav">
					<a class="nav-link" aria-current="page" onclick="location.href='${contextPath}/messageBox.cm?msgType=0'" id="receiveMsg">받은 메시지</a>
					<a class="nav-link" onclick="location.href='${contextPath}/messageBox.cm?msgType=1'" id="sendMsg">보낸 메시지</a>
				</div>
			</div>
	</nav>
	<section>
		<h1 style="text-align:left">나의 메시지</h1><br><br>
		<c:if test="${ empty msgList}">
							<div >
							<div class="alert alert-secondary" role="alert">메시지가 없습니다.</div>
						</div>
						</c:if>
			<c:if test="${ ! empty msgList }">
					<table class="table table-hover" id="sendBox" style="text-align: center;">
						<thead>
						    <tr>
						    	<th></th>
						     	<th scope="col" style="text-align: center;">제목</th>
							    <c:if test="${msgType!=1}">
							      <th scope="col" style="text-align: center;">보낸사람</th>
							    </c:if>
							    <c:if test="${msgType==1}">
							      <th scope="col" style="text-align: center;">받는사람</th>
							    </c:if>
						      	<th scope="col" style="text-align: center;">날짜</th>
						    </tr>
						</thead>
						
						<tbody class="table-group-divider" >
							<c:forEach items="${msgList}" var="m">
								<c:set var="title" value="${fn:substring(m.messageTitle, 0, 10)}"></c:set>
								<tr>
									<td>
										<c:if test="${msgType != 1 && m.messageCheck eq 'N'}">
										<img alt="읽지않은메시지이미지" src="https://cdn-icons-png.flaticon.com/512/6188/6188613.png" style="width: 50px; height: 35px;">
										</c:if>
									</td>
									<td>
									${m.messageTitle}
									</td>
								    <c:if test="${loginUser.nickName eq m.receiver}">
							      		<td scope="col">${m.sender}</td>
							   		</c:if>
									<c:if test="${loginUser.nickName eq m.sender}">
							      		<td scope="col">${m.receiver}</td>
							      	</c:if>
							      	<td>${m.msgCreateDate}</td>
								    <td>
								    <input id="deleteMId" type="hidden" value="${ m.messageNo }" >
								    <input id="msgTypeVal" type="hidden" value="${ msgType }" >
								    </td>
							    </tr>
						    </c:forEach>				  
					  </tbody>
					</table>
		<nav aria-label="Standard pagination example">
				<ul class="pagination justify-content-center">
					<li class="page-item"><c:url var="goBack" value="${ loc }">
							<c:param name="page" value="${ pi.currentPage-1 }" />
							<c:param name="category" value="${ category }"/>
						</c:url> <a class="page-link" href="${ goBack }" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
					</a></li>
					<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
						<c:url var="goNum" value="${ loc }">
							<c:param name="page" value="${ p }" />
							<c:param name="category" value="${ category }"/>
						</c:url>
						<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
					</c:forEach>
					<li class="page-item"><c:url var="goNext" value="${ loc }">
							<c:param name="page" value="${ pi.currentPage+1 }" />
							<c:param name="category" value="${ category }"/>
						</c:url> <a class="page-link" href="${ goNext }" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
			</c:if>
	</section>
	
			<div class="modal fade" tabindex="-1" role="dialog" id="modalChoice">
			<div class="modal-dialog" role="document">
	    		<div class="modal-content rounded-3 shadow">
	      			<div class="modal-body p-4 text-center">
	        			<h3 class="mb-0">메시지를 삭제하시겠습니까?</h3>
	      			</div>
	      			<div class="modal-footer flex-nowrap p-0">
	        			<button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0 border-end" id="delete">
	        				<strong>네</strong>
	        			</button>
	        			<button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0" data-bs-dismiss="modal">아니오</button>
	      			</div>
	    		</div>
  			</div>
		</div>
	
	
	<!-- 메세지 확인 모달창 -->
		<div class="modal fade" id="msgDetailModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2"><img style="width:40px; height: 40px; " alt="" src="resources/image/msg.png">&nbsp;&nbsp;MESSAGE</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				    </div>
		      <div class="modal-body" style="text-align: left">
		    	제목<input type="text" class="form-control " id="recipient-name" name="selectMsgDetail" readonly>
		    	내용 <textarea readonly class="form-control " style="height: 300px" name="messageContent" id="msgContent">${m}</textarea>
		      	<br>
		      	닉네임 : <input readonly="readonly" name="selectMsgDetail" readonly style="border: none;">
		      </div>
		      <div class="modal-footer">
		      	 <c:if test="${msgType!=1}">
		        	<button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal" id="delete">답장하기</button>
		        </c:if>
		        <button class="btn btn-primary deleteBtn">삭제</button>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onClick="window.location.reload()">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		
	<!-- 메세지 답장 모달창 -->
		<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
	 			<div class="modal-content">
				   	<div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2"><img style="width:40px; height: 40px; " alt="" src="resources/image/msg.png">&nbsp;&nbsp;SEND MESSAGE</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				    </div>
				 	<div class="modal-body" style="text-align: left">
					    	제목<input type="text" class="form-control reMsgInput" id="recipient-name" name="messageTitle">
					    	내용<textarea class="form-control reMsgInput" style="height: 300px" name="messageContent" id="msgContent"></textarea>
					      	<br>
					      	보낼 닉네임 : <input type="text" name="receiver" class="reMsgInput" readonly style="border: none;">
					      	<input type="hidden" name="refBoardId" class="reMsgInput">
					 </div>
					 <div class="modal-footer">
						<button class="btn btn-primary" id="sendBtn" ><strong>보내기</strong></button>
				      	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					 </div>
		    	</div> 
		  </div>
		</div>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
	window.onload = () =>{
		
		const tbody = document.querySelector('tbody');
		const trs = tbody.querySelectorAll('tr');
		var msgNo;
		var type;
		
		<!-- 상세페이지 -->
		for(const tr of trs){
			tr.addEventListener('click', function() {
				msgNo = this.querySelectorAll('input')[0].value;
				type = this.querySelectorAll('input')[1].value;
				$.ajax({
					url: '${contextPath}/selectMsg.cm',
					data: {
							messageNo:msgNo,
							msgType:type
						},
					success: (data) => {
						$('#msgDetailModal').modal('show');
						const inputMsg = document.getElementsByName("selectMsgDetail");
						const msg = document.getElementById("msgContent");
						inputMsg[0].value=data.messageTitle;
						msg.value=data.messageContent;
						inputMsg[1].value=data.sender;
						
						const reMsgInput = document.getElementsByClassName('reMsgInput');
						reMsgInput[2].value=data.sender;
						
					},
					error: (data) => {
						console.log(data);
					}
				});
			});
		}
		
		
		<!-- 삭제 -->
		const deleteBtns = document.getElementsByClassName('deleteBtn');
		for(const deleteBtn of deleteBtns){
			deleteBtn.addEventListener('click', function() {
				$('#msgDetailModal').modal('hide');
				$('#modalChoice').modal('show');
			});
		}
		
		document.getElementById("delete").addEventListener('click', ()=>{
			const mNo = msgNo;
			const msgType = type;
			console.log(mNo);
			location.href='${contextPath}/deleteMsg.cm?mNo='+ mNo +'&msgType='+ msgType;
		});
		
		
		
		<!-- 답장보내기 -->
		document.getElementById('sendBtn').addEventListener('click', () => {
			const reMsgInput = document.getElementsByClassName('reMsgInput');
			$.ajax({
				url: '${ contextPath }/insertMsg.cm',
				data: {messageTitle:reMsgInput[0].value,
					   messageContent:reMsgInput[1].value,
					   receiver:reMsgInput[2].value},
				success: (data) => {
					 $('#exampleModalToggle2').modal('hide')
					 reMsgInput[0].value = '';
					 reMsgInput[1].value = ''; 
					 location.reload();
				},
				error: (data) => {
					console.log(data);
				}
			});
		});
		
		const sendMsg = document.getElementById('sendMsg');
		const receiveMsg = document.getElementById('receiveMsg');
		
		if(${msgType == 0 || msgType == null}){
			receiveMsg.style.color = '#008cd4';
			sendMsg.style.color = 'none';
		} else if(${msgType == 1}){
			receiveMsg.style.color = 'none';
			sendMsg.style.color = '#008cd4';
		}
	}
		
	</script>
</body>
</html>