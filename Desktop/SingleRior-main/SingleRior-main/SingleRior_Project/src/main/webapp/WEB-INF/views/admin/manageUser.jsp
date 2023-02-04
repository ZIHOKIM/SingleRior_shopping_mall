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
                        <h1 class="mt-4">싱글리어 유저 관리</h1>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                회원정보
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>ID</th>
                                            <th>이름</th>
                                            <th>이메일</th>
                                            <th>상태</th>
             								<th>가입일</th>
                                            <th>최종 로그인</th>
                                             <th>정보 수정</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>번호</th>
                                            <th>ID</th>
                                            <th>이름</th>
                                            <th>이메일</th>
                                            <th>상태</th>
             								<th>가입일</th>
                                            <th>최종 로그인</th>
                                            <th>정보 수정</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:forEach items="${ mList}" var="m" varStatus="status">
                                       <tr>
                                       	<td><c:out value="${status.count}"/></td>
                                       	<td>${m.memberId}</td>
                                       	<td>${m.memberName}</td>
                                       	<td>${m.email}</td>
                                       	<td><c:if test="${m.memberStatus eq 'Y'}">정상</c:if><c:if test="${m.memberStatus eq 'N'}">탈퇴</c:if></td>
                                       	<td>${m.enrollDate }</td>
                                       	<td>${m.memberLog }</td>
                                       	<td><c:if test="${m.memberStatus eq 'Y'}"><button type="button" class="btn btn-primary" onclick="location.href='${contextPath}/updateManageUser.adm?memberId=${m.memberId}'">정보 수정</button></c:if>
                                       		<c:if test="${m.memberStatus eq 'N'}"><button type="button" class="btn btn-danger" disabled>탈퇴 회원</button></c:if>
                                       	
                                       	</td>
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
        <script>
        
        
/*         
    	 window.onload=()=>{
			const tbody=document.querySelector('tbody');
			
			const tds=tbody.querySelectorAll('td');
			console.log(tds);
			for(const td of tds){
				td.addEventListener('click', function(){
				const trTds = this.parentElement.querySelectorAll('td');
				const memberId =trTds[1].innerText;
				console.log(memberId)
				location.href='${contextPath}/updateManagerMember.adm?memberId='+memberId;
				
				});
			}
		}
 */         
        
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
