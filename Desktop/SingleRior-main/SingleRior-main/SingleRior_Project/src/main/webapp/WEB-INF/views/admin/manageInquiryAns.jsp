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
        
        	#inquiryButton{
        		
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
                        <h1 class="mt-4"> 상품 문의함 목록</h1>
							<div class="btn-group"  id="btnGroup" role="group" aria-label="Basic outlined example">
							  <button type="button" class="btn btn-outline-primary" onclick="location.href='${contextPath}/manageInquiry.adm'">전체 보기</button>
							  <button type="button" class="btn btn-outline-primary" onclick="location.href='${contextPath}/manageInquiryQue.adm'">미답변 내역</button>
							  <button type="button" class="btn btn-outline-primary" onclick="location.href='${contextPath}/manageInquiryAns.adm'">답변 내역</button>
							</div>

							<br><br>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                상품 문의 목록
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
							
							<thead>
                                        <tr>
                                            <th>문의 번호</th>
                                            <th>상품 번호</th>
                                            <th>상위 카테고리</th>
                                            <th>하위 카테고리 </th>
                                            <th>상품명</th>
                                            <th>문의 내용</th>
                                            <th>문의자</th>
                                            <th>문의 일시</th>
                                            <th>답변여부</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                          	<th>문의 번호</th>
                                          	<th>상품 번호</th>
                                            <th>상위 카테고리</th>
                                            <th>하위 카테고리 </th>
                                            <th>상품명</th>
                                            <th>문의 내용</th>
                                            <th>문의자</th>
                                            <th>문의 일시</th>
                                            <th>답변여부</th>                                          
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                       
                                       <c:forEach items="${list}" var="i">
                                        <tr>
                                            <td>${i.inquiryNo}</td>
                                            <td>${i.productNo}</td>
                                            <td>${i.proTopCateName}</td>
                                            <td>${i.proSubCateName}</td>
                                            <td>${i.boardTitle}</td>
                                            <td>${i.inquiryContent }</td>
                                            <td>${i.memberId}</td>
                                            <td>${i.inquiryDate }</td>
                                            <td>
                                            <c:if test="${i.adminStatus eq 'N' }"><button type="button" class="btn btn-primary" data-bs-toggle="modal" style="display:inline-block;" data-bs-target="#viewModal${i.inquiryNo}">글 보기</button>&nbsp;&nbsp;<button type="button" class="btn btn-danger" data-bs-toggle="modal" style="display:inline-block;" data-bs-target="#inquiryModal${i.inquiryNo}">답변달기</button></c:if>
                                            <c:if test="${i.adminStatus eq 'Y' }"><button type="button" class="btn btn-success" data-bs-toggle="modal" style="display:inline-block;" data-bs-target="#answerModal${i.inquiryNo}">답변 보기</button></c:if>
                                            </td>
                                        </tr>
                                        <!-- 작성글 봃수 있는 모달 -->
										<div class="modal fade" id="viewModal${i.inquiryNo}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										  <div class="modal-dialog">
										    <div class="modal-content">
										      <div class="modal-header">
										        <h1 class="modal-title fs-5" id="exampleModalLabel">${i.boardTitle}</h1>
										        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										      </div>
										      <div class="modal-body">
										        ${i.inquiryContent}
										      </div>
										      <div class="modal-footer">
										        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
										        <button type="button" class="btn btn-primary" id="showProduct">상품보기</button>
										      </div>
										    </div>
										  </div>
										</div>
										
										<!--문의하기 모달창 -->
									<div class="modal fade"  id="inquiryModal${i.inquiryNo}"  tabindex="-1" id="inquiryModal">
									  <div class="modal-dialog">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title">문의 답변 하기</h5>
									        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									      </div>
									      <form action="${ contextPath }/inquiryAnswer.adm" method="post">
									       <input type="hidden" name="productNo" value="${i.productNo}">
									       <input type="hidden" name="inquiryNo" value="${i.inquiryNo}">
										      <div class="modal-body">
										       <h2>상품명</h2>
										       ${i.boardTitle}
										       <br><br>
										        <h2>문의 내용</h2>
										        	${i.inquiryContent }
												 	<br>
												 	<br><br>
												<h2>답변 내용 작성</h2><span id="counter">0</span>/300
												<textarea cols="50" rows="3" id="textarea" name="inquiryContent"></textarea>
										      </div>
											  <div class="modal-footer">
											  	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
											  	<button type="submit" class="btn btn-primary" id="inquiry_modal" >완료</button>
											  </div>
										   </form>
									      </div>
									  	</div>
									</div>	
									<!-- 답변글 봃수 있는 모달 -->
										<div class="modal fade" id="answerModal${i.inquiryNo}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										  <div class="modal-dialog">
										    <div class="modal-content">
										      <div class="modal-header">
										        <h1 class="modal-title fs-5" id="exampleModalLabel">답변 글</h1>
										        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										      </div>
										      <div class="modal-body">
										      <h2>문의 글 제목</h2><br>
										      ${i.boardTitle}
										      <br>
										      <br>
										      <br>
										      <h2>문의 글 내용</h2><br>
										      ${i.inquiryContent}
										      <br>
										      <br>
										      <br>
										      <h2>답변 내용</h2><br>
										      ${i.inquiryAnswer }
										      <br>
										      <br>
										      </div>
										      <div class="modal-footer">
										        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
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
				 $(document).on('click','.btn-primary',function(){
					const productNo=$(this).parents('tr').children().eq(1).text();
						document.getElementById('showProduct').addEventListener('click',function(){
							location.href="${contextPath}/productDetail.st?productNo="+productNo;
						})					
				 });
				 
				 
				 
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
