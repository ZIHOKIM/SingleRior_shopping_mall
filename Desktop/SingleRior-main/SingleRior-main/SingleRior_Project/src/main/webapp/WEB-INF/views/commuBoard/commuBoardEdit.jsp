<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
	    font-family: 'BMJUA';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	* {
		font-family: 'BMJUA';
	}
	.css-title{
		overflow: hidden;
		display: inline-block;
		color: rgb(47, 52, 56);
		letter-spacing: -0.3px;
		white-space: nowrap;
		text-overflow: ellipsis;
		font-size: 30px;
		line-height: 28px;
	}
</style>
</head>
<body>
	<header class="sticky-top">
		<div>
			<jsp:include page="../common/top.jsp"/>
		</div>
	</header>
		<div class="py-1 border-bottom fs-5" style="background-color: #008cd4; text-align: center;">
			<ul class="nav me-auto justify-content-center">
		        <li class="nav-item"><a href="${ contextPath }/commuAllList.co?commuType=1" class="nav-link px-5 mx-2" style="color: white;">생활팁</a></li>
		        <li class="nav-item"><a href="${ contextPath }/commuAllList.co?commuType=2" class="nav-link px-5 mx-2" style="color: white;">후기</a></li>
		        <li class="nav-item"><a href="${ contextPath }/commuAllList.co?commuType=3" class="nav-link px-5 mx-2" style="color: white;">자유</a></li>
		    </ul>
		</div>
	
	<main>
  		<div class="container">
			<div style="margin-left: 200px; margin-right: 200px; margin-top: 100px;">
				<form class="needs-validation" action="${ contextPath }/updateCommuBoard.co" method="POST" enctype="multipart/form-data" id="commuBoardForm">
					<div class="row g-3">
						<h1 style="align-self: center;">싱글벙글</h1>
						<div class="col-12">
							<select class="form-select form-select-sm" name="commuType" aria-label=".form-select-sm example" style="width: 120px; margin-bottom: 15px; text-align: center;">
								<option value="1" <c:if test="${ coBoard.commuType == 1 }">selected</c:if>>생활팁</option>
								<option value="2" <c:if test="${ coBoard.commuType == 2 }">selected</c:if>>후기</option>
								<option value="3" <c:if test="${ coBoard.commuType == 3 }">selected</c:if>>자유</option>
							</select>
						
							<label for="boardTitle" class="form-label">TITLE</label>
							<input type="hidden" name="boardNo" value="${ coBoard.boardNo }">
							<input type="hidden" name="page" value="${ page }">
							<input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${ coBoard.boardTitle }">
						</div>

						<div class="col-12">
							<label for="boardContent" class="form-label">CONTENT</label>
							<div class="input-group">
								<textarea class="form-control" rows="10" name="boardContent" style="resize: none;">${ coBoard.boardContent }</textarea>
					        </div>
						</div>
						
						<br><br><br>
						<div>
							<c:forEach items="${ list }" var="a">
								<h5>
									<a href="${ contextPath }/resources/uploadFiles/${ a.imgRename }" download="${ a.imgOriginalName }">
										${ a.imgOriginalName }
									</a>
									<button type="button" class="btn btn-outline-dark btn-sm deleteAttm" id="delete-${ a.imgRename }/${a.level}">
										 삭제 X
									</button>
									<input type="hidden" name="deleteAttm">
								</h5>
								<br>
							</c:forEach>
						</div>
						
						<div id="fileArea">
							<div class="mb-3">
								<button type="button" class="btn" id="addFile"><img src="https://cdn-icons-png.flaticon.com/512/4148/4148851.png" style="width: 40px; height: 40px;"></button>
								<input type="file" class="form-control" name="file" style="margin-top: 15px;">
							</div>
						</div>
						
						<br><br><br><br><br>
						
						<div style="text-align: center;">
							<input type="hidden" name="boardType" value="2">
							<button class="btn btn-outline-primary" type="button" style="width: 100px;" onclick="javascript:history.back();">취소</button>
							<button class="btn btn-outline-primary" type="submit" id="submitAttm" style="width: 100px;">등록</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</main>
	
	<footer>
		<jsp:include page="../common/footer.jsp"/>
	</footer>
	
	<script>
		window.onload = () =>{
			const fileArea = document.querySelector('#fileArea');
			document.getElementById('addFile').addEventListener('click',()=>{
				const newDiv = document.createElement('div');
				newDiv.classList.add('mb-3');
				newDiv.innerHTML = '<input type="file" class="form-control" name="file">';
				
				fileArea.append(newDiv);
			});
		}
		
		const delBtns = document.getElementsByClassName('deleteAttm');
		for(const btn of delBtns){
			btn.addEventListener('click', function(){
				const nextHidden = this.nextElementSibling;
				if(nextHidden.value == ''){ // 삭제 버튼을 누르지 않았다면(삭제 OFF)
					this.style.background = 'black';
					this.style.color = 'white';
					this.innerText = '삭제 O';
					nextHidden.value = this.id.split("-")[1];
				} else { // 삭제 버튼이 눌린 상태라면(삭제 ON)
					this.style.background = 'none';
					this.style.color = 'black';
					this.innerText = '삭제 X';
					nextHidden.removeAttribute('value');
				}
			});
		}
	</script>
</body>
</html>