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
			
			#pTable{
			
				display: flex;
				flex-direction: column;
				justify-content: center;
				align-items: center;
				margin-top:50px;	
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
				
			}
			#updateBtn{
			
				display: flex;
				flex-direction: row;
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
                    <h1>포인트 변경</h1>
                    </div>
                    <form>
							<fieldset>
								
								<table id="pTable">
									
									
									<tr>
										<td style="text-align:right;">회원 아이디 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;"></td>
									</tr>								
									<tr>
										<td style="text-align:right;">회원 이름 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;"></td>
									</tr>		
									<tr>
										<td style="text-align:right;">포인트 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;"></td>
									</tr>				
									<tr>
										<td style="text-align:right;">포인트 수정:&nbsp;&nbsp;  </td>
										<td colspan="2"><input type="text" style="width:500px;"></td>
									</tr>
									<tr>
										<td style="text-align:right;">포인트 내용 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;"></td>
									</tr>
								</table>
								<br><br>
                    		<div id="updateBtn">
								<button type="button" class="btn btn-primary">수정 완료</button>&nbsp;&nbsp;&nbsp;
								<button type="reset"  class="btn btn-danger" onclick="history.back();">목록으로</button>
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
            </div>
        
        
        
        
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='${ pageContext.servletContext.contextPath }/resources/js/scripts.js'></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-area-demo.js"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/js/datatables-simple-demo.js"></script>
    </body>
</html>
