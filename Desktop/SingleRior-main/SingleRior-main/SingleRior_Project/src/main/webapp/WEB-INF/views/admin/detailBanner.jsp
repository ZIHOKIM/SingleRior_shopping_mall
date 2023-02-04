<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			
			#bTable{
			
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
				margin-top:30px;	
			}
			input { 
				padding: 10px 20px; 
				margin: 5px 0; 
				box-sizing: border-box; 
				border-radius: 15px;
				
				}
			tr td{
				margin-right:50px;
				margin-left:50px;
				text-align:right;
				
			}
			#bannerBtn{
				margin-top:30px;
				margin-bottom:30px;
				display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				
			
			}
			#banner{
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
			}
			
			#bannerDetail{
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
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
                    <h1>현재 등록된 배너</h1>
                    </div>
                    <div id="pInsert">
                   		<form  method="post" enctype="multipart/form-data" id="detailForm">
                   			<table id="bTable">
                   				<tr>
                   					<td><h3>배너 제목 : </h3></td>
                   					<td><input type="text" name="boardTitle" style="width:450px;" value="${b.boardTitle}" readonly>
                   						<input type="hidden" name="boardNo" value="${b.boardNo }">
                   					</td>
                   				</tr>
                   				<tr>
                   					<td><h3>배너 상세 내용 : </h3></td>
									<td><input type="text" name="boardContent" style="width:450px;" value="${b.boardContent}" readonly></td>
                   				</tr>
                   			</table>
                   			<br><br>
							<div id="banner">
							<h3>가로형 배너</h3><br>	
							<img >
								<img src="${contextPath}/resources/uploadFiles/${list[0].imgRename}" style="width: 80%;">
							</div> 
							<br><br>
							<div id="bannerDetail">
							<h3>기획전 이미지</h3><br>
								<img src="${contextPath}/resources/uploadFiles/${list[1].imgRename}" style="width: 80%;">
							</div>                  			
                   		<div id="bannerBtn">
							<button type="button"  class="btn btn-warning" onclick="javascript:history.back();">목록으로</button>&nbsp;&nbsp;&nbsp;
							<button type="button"  class="btn btn-danger" type="button" id="deleteModal" >배너 삭제</button>
						</div>
                   		
                   		</form>
                   
                    </div>
                    	
                    	
                    	
                </main>
<!-------------------------------------------------------- 내용 ----------------------------------------------------------------------- -->                
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; SingleRior 2022</div>
                        </div>
                    </div>
                </footer>
                <div class="modal fade" tabindex="-1" role="dialog" id="modalChoice">
					<div class="modal-dialog" role="document">
						<div class="modal-content rounded-3 shadow">
							<div class="modal-body p-4 text-center">
								<h3 class="mb-0">정말로 삭제하시겠습니까?</h3>
								<p class="mb-0">삭제 후 게시글은 되돌릴 수 없습니다.</p>
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
            </div>
        	
        	<script>
        	window.onload=()=>{
        		const form=document.getElementById('detailForm');
        		console.log(form);
        		
        		document.getElementById('deleteModal').addEventListener('click', ()=>{
    				$('#modalChoice').modal('show');	
    			});
        		
        		document.getElementById("delete").addEventListener('click',function(){
        			form.action='${contextPath}/deleteBanner.adm';
        			form.submit();
        		});
        	}
        	</script>
		        
        
        
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='${ pageContext.servletContext.contextPath }/resources/js/scripts.js'></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-area-demo.js"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/js/datatables-simple-demo.js"></script>
    </body>
</html>
