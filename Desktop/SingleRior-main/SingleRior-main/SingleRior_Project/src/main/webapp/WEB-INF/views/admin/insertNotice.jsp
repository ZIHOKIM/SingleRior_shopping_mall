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
				<h1>공지사항 작성</h1>


			</div>

			<div class="container">
				<div>
					<form class="needs-validation"
						action="${ contextPath }/enrollNotice.adm" method="POST">
						<div class="row g-3">

							<div class="col-12">
								<select class="form-select form-select-sm" name="noticeCategory"
									aria-label=".form-select-sm example"
									style="width: 120px; margin-bottom: 15px; text-align: center;">
									<option>전체</option>
									<option>씽씽마켓</option>
									<option>싱글벙글</option>
								</select> <label for="boardTitle" class="form-label">TITLE</label> <input
									type="text" class="form-control" id="boardTitle"
									name="boardTitle">
							</div>

							<div class="col-12">
								<label for="boardContent" class="form-label">CONTENT</label>
								<div class="input-group">
									<textarea class="form-control" rows="10" name="boardContent"
										style="resize: none;"></textarea>
								</div>
							</div>



							<div id="btn">
							<button type="submit" class="btn btn-primary">등록하기</button> &nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-success"  onclick="javascript:history.back();">목록으로</button>
							
							</div>
						</div>
					</form>
				</div>
			</div>

		</main>
		<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid px-4">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; SingleRior 2022</div>
				</div>
			</div>
		</footer>
	</div>
	
	
	
	
	
	
	
</body>
</html>
