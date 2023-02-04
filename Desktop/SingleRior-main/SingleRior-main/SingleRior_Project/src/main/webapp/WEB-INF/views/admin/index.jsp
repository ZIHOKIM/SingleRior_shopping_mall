<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    	 
    	 
    	 
    	 </style>
    	 
    	 
    </head>
    <body>
    
	<jsp:include page="../common/adminTop.jsp"/>
	<jsp:include page="../common/adminLeft.jsp"/>
	
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">관리자 페이지</h1>
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-secondary text-white mb-4">
                                    <div class="card-body">싱글리어 홈페이지</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath}/home.do">바로 가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">상품등록</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath}/insertProduct.adm ">바로 가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body">주문 목록</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath}/manageOrder.adm">바로 가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body">신고글 처리</div>
                                    <div class="card-footer d-flex align-items-center justify-content-between">
                                        <a class="small text-white stretched-link" href="${contextPath}/manageReport.adm">바로 가기</a>
                                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                       	일일 로그인 현황
                                    </div>
                                    <div class="card-body"><canvas id="dailyLoginUser" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        일별 매출 현황
                                    </div>
                                    <div class="card-body"><canvas id="userSum" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                상품 주문 목록
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
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; SingleRior 2022</div>
                        </div>
                    </div>
                </footer>
            </div>
        <script>
		        var context = document.getElementById('dailyLoginUser').getContext('2d');
		    	var myChart = new Chart(context, {
		        type: 'line', // 차트의 형태
		        data: { // 차트에 들어갈 데이터
		            labels: [
		                //x 축
		                '${logCount[9].A}','${logCount[8].A}','${logCount[7].A}','${logCount[6].A}','${logCount[5].A}','${logCount[4].A}','${logCount[3].A}','${logCount[2].A}','${logCount[1].A}','${logCount[0].A}'
		            ],
		            datasets: [
		                { //데이터
		                    label: '일일 로그인 회원 수', //차트 제목
		                    fill: true, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
		                    data: [
		                    	 '${logCount[9].B}','${logCount[8].B}','${logCount[7].B}','${logCount[6].B}','${logCount[5].B}','${logCount[4].B}','${logCount[3].B}','${logCount[2].B}','${logCount[1].B}','${logCount[0].B}' //x축 label에 대응되는 데이터 값
		                    ],
		                    backgroundColor: [
		                        //색상
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)',
		                        'rgb(54, 162, 235,0.7)'
		                        
		                        ],
		                    borderColor: [
		                        //경계선 색상
		                    	'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)',
		                        'rgb(54, 162, 235,1)'
		                        
		                        ],
		                    borderWidth: 1 //경계선 굵기
		                }/* ,
		                {
		                    label: 'test2',
		                    fill: false,
		                    data: [
		                        8, 34, 12, 24
		                    ],
		                    backgroundColor: 'rgb(157, 109, 12)',
		                    borderColor: 'rgb(157, 109, 12)'
		                } */
		            ]
		        },
		        options: {
		            scales: {
		                yAxes: [
		                    {
		                        ticks: {
		                            beginAtZero: true
		                        }
		                    }
		                ]
		            }
		        }
		    });
		    	  var ctx2 = document.getElementById('userSum').getContext('2d');
		            var chart = new Chart(ctx2, {
		                // type : 'bar' = 막대차트를 의미합니다.
		                type: 'bar', // 
		                data: {
		                    labels: ['${bList[4].A}','${bList[3].A}','${bList[2].A}','${bList[1].A}','${bList[0].A}'],
		                    datasets: [{
		                       
		                        label: '일일 판매 금액 ',
		                        backgroundColor: 'rgb(54, 162, 235,0.7)',
		                        borderColor: 'rgb(54, 162, 235,0.7)',
		                        data: ['${bList[4].B}','${bList[3].B}','${bList[2].B}','${bList[1].B}','${bList[0].B}'],
		                        yAxisID: 'left-y-axis'
		                    
		                    }]
		                },
		                options: {
		                    scales: {
		                        yAxes: [{
		                            id: 'left-y-axis',
		                            scaleShowGridLines : false,
		                            type: 'linear',
		                            position: 'left',
		                            ticks:{
		                            	min:0,
		                            	stepSize:5000000,
		                            	max:30000000,
		                            	display:true
		                            }
		                        }]
		                    }
		                }
		                
		            });
		       	
	        $(document).on('click','.btn-danger',function(){
	    		const orderNo=$(this).parents('tr').children().eq(0).text();
	        	location.href="${contextPath}/detailOrderProduct.adm?orderNo="+orderNo;
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
