<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%
  Date now = new Date();
%>

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
                        <h1 class="mt-4">방문 및 사용자 통계</h1>
                        <div class="card mb-4">
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-chart-area me-1"></i>
                                일일 로그인 회원 수
                            </div>
                            <div class="card-body"><canvas id="dailyLoginUser" width="100%" height="30"></canvas></div>
                            <div class="card-footer small text-muted">마지막 업데이트 일시: <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="<%= now %>"/></div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                        일일/누적 회원가입 통계
                                    </div>
                                    <div class="card-body"><canvas id="userSum"></canvas></div>
                                    <div class="card-footer small text-muted">마지막 업데이트 일시: <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="<%= now %>"/></div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-pie me-1"></i>
                                        사용자 컨텐츠 조회수
                                    </div>
                                    <div class="card-body"><canvas id="viewContentChart" width="100%" height="50"></canvas></div>
                                    <div class="card-footer small text-muted">마지막 업데이트 일시: <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="<%= now %>"/></div>
                                </div>
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
             
            
            		/*일일 누적 회원가입 js  */	
            		var max=parseInt('${list[0].C}');
            		var max2=parseInt('${list[0].B}');
		            var ctx2 = document.getElementById('userSum').getContext('2d');
		            var chart = new Chart(ctx2, {
		                // type : 'bar' = 막대차트를 의미합니다.
		                type: 'bar', // 
		                data: {
		                    labels: ['${list[4].A}','${list[3].A}','${list[2].A}','${list[1].A}','${list[0].A}'],
		                    datasets: [{
		                        label: '일일 회원 가입자 수',
		                        type : 'line',         // 'line' type
		                        fill : false,         // 채우기 없음
		                        lineTension : 0,  // 0이면 꺾은선 그래프, 숫자가 높을수록 둥글해짐
		                        pointRadius : 1,    // 각 지점에 포인트 주지 않음
		                        backgroundColor: 'rgb(255, 99, 132,0.7)',
		                        borderColor: 'rgb(255, 99, 132,0.7)',
		                        data: ['${list[4].B}','${list[3].B}','${list[2].B}','${list[1].B}','${list[0].B}'],
		                        yAxisID: 'right-y-axis'
		                    },{
		                        label: '누적 회원 가입자 수',
		                        backgroundColor: 'rgb(54, 162, 235,0.7)',
		                        borderColor: 'rgb(54, 162, 235,0.7)',
		                        data: ['${list[4].C}','${list[3].C}','${list[2].C}','${list[1].C}','${list[0].C}'],
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
		                            	min:10,
		                            	stepSize:15,
		                            	max:max+20,
		                            	display:true
		                            }
		                        }, {
		                            id: 'right-y-axis',
		                            scaleShowGridLines : false,
		                            type: 'linear',
		                            position: 'right',
		                            ticks:{
		                            	min:0,
		                            	stepSize:20,
		                            	max:20,
		                           		display: true
		                            }
		                        }]
		                    }
		                }
		                
		            });
		            var context = document.getElementById('viewContentChart').getContext('2d');
		            var myChart = new Chart(context, {
		                type: 'pie', // 차트의 형태
		                data: { // 차트에 들어갈 데이터
		                    labels: [
		                        //x 축
		                        '스토어','싱글벙글','씽씽마켓'
		                    ],
		                    datasets: [
		                        { //데이터
		                            label: '컨텐츠 조회수', //차트 제목
		                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
		                            data: [
		                                '${viewContent[0].B}','${viewContent[1].B}','${viewContent[2].B}' //x축 label에 대응되는 데이터 값
		                            ],
		                            backgroundColor: [
		                                //색상
		                                'rgba(255, 99, 132,0.7)',
		                                'rgba(54, 162, 235,0.7)',
		                                'rgba(255, 206, 86,0.7)'
		                            ],
		                            borderColor: [
		                                //경계선 색상
		                                'rgba(255, 99, 132, 1)',
		                                'rgba(54, 162, 235, 1)',
		                                'rgba(255, 206, 86, 1)'
		                                
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
		            });

            
            
            
            </script>
            
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='${ pageContext.servletContext.contextPath }/resources/js/scripts.js'></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-area-demo.js"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-bar-demo.js"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/assets/demo/chart-pie-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="${ pageContext.servletContext.contextPath }/resources/js/datatables-simple-demo.js"></script>
    </body>
</html>
