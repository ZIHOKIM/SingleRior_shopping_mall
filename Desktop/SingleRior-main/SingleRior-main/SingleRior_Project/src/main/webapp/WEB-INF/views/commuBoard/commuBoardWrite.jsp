<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<form class="needs-validation" action="${ contextPath }/insertCommuBoard.co" method="POST" enctype="multipart/form-data" id="attmForm">
					<div class="row g-3">
						<h1 style="align-self: center;">싱글벙글</h1>
						<div class="col-12">
							<select class="form-select form-select-sm" name="commuType" aria-label=".form-select-sm example" style="width: 120px; margin-bottom: 15px; text-align: center;">
								<option value="1">생활팁</option>
								<option value="2">후기</option>
								<option value="3">자유</option>
							</select>
						
							<label for="boardTitle" class="form-label">TITLE</label>
							<input type="text" class="form-control" id="boardTitle" name="boardTitle">
						</div>

						<div class="col-12">
							<label for="boardContent" class="form-label">CONTENT</label>
							<div class="input-group">
								<textarea class="form-control" rows="10" name="boardContent" style="resize: none;"></textarea>
					        </div>
						</div>
						
						<div id="fileArea">
							<div class="mb-3">
								<button type="button" class="btn " id="addFile"><img src="https://cdn-icons-png.flaticon.com/512/4148/4148851.png" style="width: 40px; height: 40px;"></button>
								<div class="mb-3 input-group" style="margin-top: 15px;">
									<input type="file" class="form-control" name="file">
									<button type="button" class="btn btn-outline-dark deleteFile">삭제</button>
								</div>
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
				newDiv.innerHTML = '<div class="mb-3 input-group"><input type="file" class="form-control" name="file"><button type="button" class="btn btn-outline-dark deleteFile" >삭제</button></div>';
				
				fileArea.append(newDiv);
			});
		}
		
		$(document).on('click', '.deleteFile', function(){
			$(this).parent().remove();
		});
		
	
	</script>
</body>
</html>