<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>싱글리어 관리자 페이지</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/resources/css/styles.css"  />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        
        <style>
        	#btnGroup{
        		display: flex;
				flex-direction: row;
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
        	table, td, th {
				 border : 1px solid black;
				 border-collapse : collapse;
				}
			th, td {
				 text-align: center;
				}
        
        </style>
        
        
        
    </head>
    <body class="sb-nav-fixed">
		<jsp:include page="../common/adminTop.jsp"/>
		<jsp:include page="../common/adminLeft.jsp"/><!-----------------------------------------------------좌측 네비바 ------------------------------------------------------------------------------------------------------------------->                    
<!-------------------------------------------------------- 내용 ----------------------------------------------------------------------- -->            
            <div id="layoutSidenav_content">
                <main>
                     <div class="container-fluid px-4">
                        <h1 class="mt-4">신고 게시글 목록</h1>
                        <div id="btnGroup" class="btn-group"  aria-label="Basic radio toggle button group">
								<input type="button" class="btn-check" 
									id="reportBoard"  onclick="${contextPath}/manageReport.adm" checked > <label
									class="btn btn-outline-primary" for="reportBoard">게시글 신고목록</label>

								<input type="button" class="btn-check" 
									id="reportReply" onclick="${contextPath}/manageReportReply.adm"> <label
									class="btn btn-outline-primary" for="reportReply">댓글 신고 목록</label>

							</div>
							<br><br>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                게시글 신고 목록
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
							
							<thead>
                                        <tr>
                                            <th>신고번호</th>
                                            <th>게시글 종류</th>
                                            <th>신고 카테고리 </th>
                                            <th>신고글 제목</th>
                                            <th>신고 일시</th>
                                            <th>신고한 회원</th>
                                            <th>상태 변경</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                          	<th>신고번호</th>
                                            <th>게시글 종류</th>
                                            <th>신고 카테고리 </th>
                                            <th>신고글 제목</th>
                                            <th>신고 일시</th>
                                            <th>신고한 회원</th>
                                            <th>상태 변경</th>
                                            
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                       
                                       <c:forEach items="${rList}" var="r">
                                        <tr>
                                            <td>${r.reportNo}
                                            	<input type="hidden"  name="contentNo" value="${r.contentNo}">
                                            </td>
                                            <td><c:if test="${r.boardType eq 2}">싱글벙글</c:if><c:if test="${r.boardType eq 3}">씽씽마켓</c:if></td>
                                            <td>${r.reportType }</td>
                                            <td>${r.boardTitle }</td>
                                            <td>${r.createDate }</td>
                                            <td>${r.memberId }</td>
                                            <td><button type="button" class="btn btn-primary" data-bs-toggle="modal" style="display:inline-block;" data-bs-target="#viewModal${r.reportNo}">글 보기</button> <button type="button" class="btn btn-danger" data-bs-toggle="modal" style="display:inline-block;" data-bs-target="#reportModal${r.reportNo}">신고 처리</button></td>
                                        </tr>
                                        <!-- 작성글 봃수 있는 모달 -->
										<div class="modal fade" id="viewModal${r.reportNo}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										  <div class="modal-dialog">
										    <div class="modal-content">
										      <div class="modal-header">
										        <h1 class="modal-title fs-5" id="exampleModalLabel">${r.boardTitle}</h1>
										        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										      </div>
										      <div class="modal-body">
										        ${r.boardContent}
										      </div>
										      <div class="modal-footer">
										        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
										      </div>
										    </div>
										  </div>
										</div>
										<!-- 신고 처리 모달 -->
										<div class="modal fade" id="reportModal${r.reportNo}" tabindex="-1" aria-labelledby="exampleModalLabel${r.reportNo}" aria-hidden="true">
										  <div class="modal-dialog">
										    <div class="modal-content">
										      <div class="modal-header">
										        <h1 class="modal-title fs-5" id="exampleModalLabel${r.reportNo}">신고 처리</h1>
										        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										        
										      </div>
										      <div class="modal-body">
										        게시글을 신고처리 하시겟습니까?
										      </div>
										      <div class="modal-footer">
										        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
										      	<button type="button" class="btn btn-danger" id="deleteReportBoard">게시글 삭제</button>
										        <button type="button" class="btn btn-primary" id="cancelReport">신고 취소</button>
										      </div>
										    </div>
										  </div>
										</div>
										
                                       </c:forEach>                                         
                                        
                                    </tbody>
                                </table>
                            </div>
                        </div>
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
            
           
            
            
        </div>
        
        
        
        <script>
        
			 $(function(){
				 $(document).on('click','.btn-danger',function(){
			 		const reportNo=$(this).parents('tr').children().eq(0).text();
						document.getElementById('deleteReportBoard').addEventListener('click',function(){
							alert("신고처리가 완료되었습니다.");
							location.href="${contextPath}/reportBoard.adm?reportNo="+reportNo;
			
						});
						document.getElementById('cancelReport').addEventListener('click',function(){
							alert("신고처리를 취소하셨습니다.");
							location.href="${contextPath}/cancelReport.adm?reportNo="+reportNo;
						});
				 	});
				 
			
			 
			 });
        
        </script>
        <script>
			window.onload=()=>{
		 		document.getElementById('reportBoard').addEventListener('click',function(){
		 			location.href='${contextPath}/manageReport.adm';
		 		})
		 		document.getElementById('reportReply').addEventListener('click',function(){
		 			location.href='${contextPath}/manageReportReply.adm';
		 		})
		 		document.getElementById('reportReReply').addEventListener('click',function(){
		 			location.href='${contextPath}/manageReportReReply.adm';
		 		})
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
