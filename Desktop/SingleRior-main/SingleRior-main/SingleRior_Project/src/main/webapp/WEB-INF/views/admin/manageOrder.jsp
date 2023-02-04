<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
       <style>
       
        table, td, th {
				 border : 1px solid black;
				 border-collapse : collapse;
				}
			th, td {
				 text-align: center;
				}
				
		</style>
    </head>
    <body >
	<jsp:include page="../common/adminTop.jsp"/>
	<jsp:include page="../common/adminLeft.jsp"/>
<!-----------------------------------------------------좌측 네비바 ------------------------------------------------------------------------------------------------------------------->                    
<!-------------------------------------------------------- 내용 ----------------------------------------------------------------------- -->            
            <div id="layoutSidenav_content">
                <main>
                     <div class="container-fluid px-4">
                        <h1 class="mt-4">주문 목록 리스트</h1>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                주문 목록
                               
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>주문번호</th>
                                            <th>주문 상품</th>
                                            <th>주문 가격 </th>
                                            <th>주문일시</th>
                                            <th>아이디</th>
                                            <th>이름</th>
                                            <th>연락처</th>
                                            <th>주소</th>
                                            <th>처리상태</th>
                                            <th>상세보기</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                       <tr>
                                            <th>주문번호</th>
                                            <th>주문 상품</th>
                                            <th>주문 가격 </th>
                                            <th>주문일시</th>
                                            <th>아이디</th>
                                            <th>수령인</th>
                                            <th>연락처</th>
                                            <th>주소</th>
                                            <th>처리상태</th>
                                        	<th>주문 내역</th>
                                        	<th>상세보기</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    	<c:forEach items="${list}" var="p">
                                         <tr>
                                            <td>${p.orderNo}</td>
                                            <td>${p.products}</td>
                                            <td><fmt:formatNumber value="${p.orderTotalPrice}" pattern="#,###"/>원</td>
                                            <td>${p.orderDate}</td>
                                            <td>${p.memberId}</td>
                                            <td>${p.recipient}</td>
                                            <td>${p.reciPhone}</td>
                                            <td>${p.reciAddress}</td>
                                            <td>${p.orderTotalStatus }</td>
                                           <td><button type="button" class="btn btn-danger">상세 주문 보기</button></td>
                                        </tr>
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
        	
        $(document).on('click','.btn-danger',function(){
    		const orderNo=$(this).parents('tr').children().eq(0).text();
        	location.href="${contextPath}/detailOrderProduct.adm?orderNo="+orderNo;
        });
        
        
        </script>
        <script>
        
        
        
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
