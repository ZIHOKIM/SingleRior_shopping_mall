<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

#pInsert {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-top: 30px;
}

input {
	padding: 10px 20px;
	margin: 5px 0;
	box-sizing: border-box;
	border-radius: 15px;
}

#btn {
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
}

.pageArea {
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
}
</style>


</head>
<body>

	<jsp:include page="../common/adminTop.jsp" />
	<jsp:include page="../common/adminLeft.jsp" />


	<div id="layoutSidenav_content">
		<main>

			<div id="logo">
				<img
					src="${ pageContext.servletContext.contextPath }/resources/image/SingleRior_logo.png"
					style="width: 250px; height: 100px;"> <br>
				<h1>공지사항</h1>


			</div>

			<div class="container">
				<div>
					<form class="needs-validation" method="POST" id="detailForm">
						<div class="row g-3">

							<div class="col-12">
								${q.boardNo },${page }
								<label> 카테고리 </label>
								<input type="text" class="form-control" id="boardCategory" name="qnaCategory" value="${q.qnaCategory }" readonly>
								<label for="boardTitle" class="form-label">제목</label> 
								<input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${q.boardTitle }" readonly>
								<input type="hidden" value="${q.boardNo}" name="boardNo">
								<input type="hidden" value="${page}" name="page">
							</div>

							<div class="col-12">
								<label for="boardContent" class="form-label">내용</label>
								<div class="input-group">
									<textarea class="form-control" rows="10" name="boardContent" style="resize: none;" readonly>${q.boardContent }</textarea>
								</div>
							</div>

							<div id="btn">
							<button type="button" class="btn btn-primary" id="updateForm">수정하기</button> &nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-success"  onclick="javascript:history.back();">목록으로</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="btn btn-danger" type="button" id="deleteModal" >삭제하기</button>
							
							</div>
						</div>
					</form>
				</div>
			</div>

		</main>
			<div class="modal fade" tabindex="-1" role="dialog" id="modalChoice">
		<div class="modal-dialog" role="document">
    		<div class="modal-content rounded-3 shadow">
      			<div class="modal-body p-4 text-center">
        			<h3 class="mb-0">정말로 삭제하시겠습니까?</h3>
        			<p class="mb-0">삭제 후 게시글은 복구할 수 없습니다.</p>
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
		<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid px-4">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; SingleRior 2022</div>
				</div>
			</div>
		</footer>
	</div>
	<script>
		window.onload=()=>{
			const upd=document.getElementById('updateForm');
			const form=document.getElementById('detailForm');
			
			if(upd!=null){
				upd.addEventListener('click',()=>{
					form.action='${contextPath}/updateQNA.adm';
					form.submit();
				});
			}
			const deleteModal=document.getElementById('deleteModal');
			if(deleteModal!=null){
				document.getElementById('deleteModal').addEventListener('click',()=>{
					$('#modalChoice').modal('show');
				});
			}
			
			document.getElementById('delete').addEventListener('click',()=>{
				form.action='${contextPath}/deleteQNA.adm';
				form.submit();
			});
		
		}
	
	
	</script>


</body>
</html>
