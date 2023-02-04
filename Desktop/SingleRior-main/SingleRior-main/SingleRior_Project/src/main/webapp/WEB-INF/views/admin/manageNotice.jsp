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
			
			#pInsert{
			
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
				
			}
			.btn{
			
				display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
				
			
			}
    	 	.pageArea{
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
	
   
            <div id="layoutSidenav_content">
                <main>
                
                 <div id="logo">
                    <img src="${ pageContext.servletContext.contextPath }/resources/image/SingleRior_logo.png" style="width:250px; height:100px;">
                    <br>
                    <h1>공지사항 리스트</h1>
                    <br>
                    
                    
                    </div>
                   <div class="container px-5 bd-example-snippet bd-code-snippet" style="padding-bottom: 20px; text-align: center;">
           
           
           <div class="bd-example">
           
           	<button style="float:right"  type="button" class="btn btn-outline-secondary" onclick="location.href='${contextPath}/insertNotice.adm'">공지 내용 작성</button>
           <br><br>
            <table class="table table-hover">
               <thead>
                  <tr class="fs-5">
                     <th width="100px">카테고리</th>
                     <th>글 제목</th>
                     <th>작성자</th>
                     <th width="130px">작성일</th>
                      </tr>
                   </thead>
                  <tbody class="tbody">
                      
                      <c:forEach items="${list}" var="list">
                      <tr>
	                     <td>${list.noticeCategory}<input type="hidden" value="${list.boardNo}"></td>
	                     <td>${list.boardTitle }</td>
	                     <td>${list.boardWriter }<input type="hidden" value="${list.boardWriter}"></td>
	                     <td>${list.modifyDate }</td>
                      </tr>
                      </c:forEach>
                   </tbody>
              </table>
             </div>
      </div>
      	<div class="pageArea">
   			 <nav aria-label="Standard pagination example" style="float: right;">
				<ul class="pagination">
	          				<li class="page-item">
	           					<c:url var="goBack" value="${ loc }">
	           						<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
	           					</c:url>
	           					<a class="page-link" href="${ goBack }" aria-label="Previous">
	           						<span aria-hidden="true">&laquo;</span>
	             					</a>
	           				</li>
	           				<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
	          					<c:url var="goNum" value="${ loc }">
	          						<c:param name="page" value="${ p }"></c:param>
	          					</c:url>
	           					<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
	           				</c:forEach>
	           				<li class="page-item">
	           					<c:url var="goNext" value="${ loc }">
	           						<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
	           					</c:url>
	           					<a class="page-link" href="${ goNext }" aria-label="Next">
	           						<span aria-hidden="true">&raquo;</span>
	           					</a>
	           				</li>
	   				</ul>
      			</nav>
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
         
         <script>
         	window.onload=()=>{
         		const tbody=document.querySelector('.tbody');
         		const trs = tbody.querySelectorAll('tr');
         	
         		console.log(trs)
         		for(const tr of trs){
         			tr.addEventListener('click',function(){
         			const bNo=this.querySelectorAll('input')[0].value;
         			const boardWriter=this.querySelectorAll('input')[1].value;
         			location.href='${contextPath}/detailNotice.adm?bNo='+bNo+'&page='+${pi.currentPage}+'&boardWriter='+boardWriter;
         			});
         		}
         		
         		
         		
         	}
         
         
         </script>
    </body>
</html>
