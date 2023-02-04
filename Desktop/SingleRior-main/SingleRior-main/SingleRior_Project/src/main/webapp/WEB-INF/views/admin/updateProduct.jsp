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
                    <h1>상품 수정</h1>
                    </div>
                    <div id="pInsert">
                    	<form action="${contextPath}/editProduct.adm" method="POST" id="productUpdateForm" enctype="multipart/form-data">
							<fieldset>
								
								<table id="pTable">
									<tr>
										<td style="text-align:right;">상위 카테고리 :&nbsp;&nbsp;  </td>
										<td>
											<select class="form-select" aria-label="Disabled select example" id="mainCategory" >
												<option value="선택">카테고리 선택</option>
												<option value="가구" <c:if test="${p.topCateCode eq 1}">selected</c:if> >가구</option>
												<option value="패브릭" <c:if test="${p.topCateCode eq 2}">selected</c:if> >패브릭</option>
												<option value="인테리어 소품" <c:if test="${p.topCateCode eq 3}">selected</c:if> >인테리어</option>
												<option value="주방용품" <c:if test="${p.topCateCode eq 4}">selected</c:if> >주방용품</option>
												<option value="가전제품" <c:if test="${p.topCateCode eq 5}">selected</c:if> >가전제품</option>
												<option value="소형가전" <c:if test="${p.topCateCode eq 6}">selected</c:if> >소형가전</option>
											</select>
										</td>
									</tr>
									<tr>
										<td style="text-align:right;">하위 카테고리 :&nbsp;&nbsp;  </td>
										<td>
											<select class="form-select" aria-label="Disabled select example" id="subCategory" name="subCategory">
											</select>
										</td>
									</tr>
									
									
									
									
									<tr>
										<td style="text-align:right;">상품 이름 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;" placeholder="상품명을 입력해주세요" name="productName" value="${p.boardTitle}"></td>
									</tr>								
									<tr>
										<td style="text-align:right;">상품 가격(원가) :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;" placeholder="가격을 입력해주세요" name="productPrice" value="${p.productPrice}"></td>
									</tr>		
									<tr>
										<td style="text-align:right;">상품 할인율 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;" placeholder="적용하지 않을시 0으로 입력해주세요" name="productDiscount" value="${p.discount}"></td>
									</tr>				
									<tr>
										<td style="text-align:right;">상품 옵션 :&nbsp;&nbsp;  </td>
										<td colspan="2"></td>
										<td><input class="btn btn-secondary" id="addOption" type="button" value="추가"></td>
									</tr>
									<c:forEach items="${list}" var="i" >
									<tr><td style="text-align:right;"></td>
										<td colspan="2"><input type="text" style="width:500px;" placeholder="옵션 설명" value="${i}"name="productOption"></td>
										<td><input class='btn btn-danger' name='dBtn' type='button' value='삭제' onclick='deleteKey(this)'></td>
									</tr>
									</c:forEach>
									<tr>
										<td style="text-align:right;">상품 모델명 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;" placeholder="모델명을 입력해주세요" name="modelName" value="${p.modelName}"></td>
									</tr>
									<tr>
										<td style="text-align:right;">브랜드 :&nbsp;&nbsp;  </td>
										<td colspan="3"><input type="text" style="width:500px;" placeholder="브랜드를 입력해주세요" name="brand" value="${p.brand}"></td>
									</tr>
									<c:forEach items="${aList}" var="a">
									<tr>
										<td style="text-align:right;">게시된 사진 :&nbsp;&nbsp;  </td>
										<td colspan="2"><a href="${contextPath }/resources/uploadFiles/${a.imgRename}" download='${a.imgOriginalName}'>${a.imgOriginalName}</a></td>
										<td><button type="button" class="btn btn-outline-dark btn-sm deleteAttm" id="delete-${a.imgRename}/${a.level}">사진삭제</button><input type="hidden" name="deleteAttm"> </td>
									</tr>	
									</c:forEach>
									<tr>
									<td style="text-align:right;">상품 사진 추가:&nbsp;&nbsp;</td>
									<td colspan='2'><input type='file' name='file' style='width:500px;' ></td>
									<td><input class="btn btn-primary" type="button" value="사진 추가" onclick="addAttm(this)" ></td>
									</tr>
									
								</table>
							</fieldset>
								<div id="hiddenElement">
									<input type="hidden" name="boardNo" value="${p.boardNo }">
								</div>
								<div class="btn">
									<button type="submit" class="btn btn-success" id="editProduct">상품 수정</button>&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="reset" class="btn btn-danger">초기화</button>
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
            </div>
        </div>
        
        
        
        <script>
        // 상품 옵션 추가 자바스크립트
        	window.onload=()=>{
        		//querySelect로 mainCategory에 접근한다.
        		var mainCategory= document.querySelector('#mainCategory');
        		
        		changeCategory();
        		
        		document.getElementById("addOption").addEventListener('click',()=>{
        			
        			//테이블 접근
        			const table=document.getElementById("pTable");
					//테이블 추가 행접근
        			const newOpt=table.insertRow(6);
        			//새 행에 추가
        			const newOpt1=newOpt.insertCell(0);
        			const newOpt2=newOpt.insertCell(1);
        			const newOpt3=newOpt.insertCell(2);
        			newOpt1.innerHTML="<td style='text-align:right;'></td>";
        			newOpt2.innerHTML="<td colspan='2' class='tds'><input type='text' style='width:400px;' placeholder='옵션 설명' name='productOption'></td>";
        			newOpt3.innerHTML="<td><input class='btn btn-danger' name='dBtn' type='button' value='삭제' onclick='deleteKey(this)'></td>";
        		
        		});	
        		
        		
    			
        		//selelct~option 변경시 함수 발동
				mainCategory.onchange=function(){
					changeCategory();
				}
        	}
        
        //삭제 버튼 클릭시 해당 요소 삭제
	        function deleteKey(obj){
	        	var div = $(obj).parent().parent();
	        	div.remove();
	        	}
        
        //사진 추가
	        function addAttm(obj){
	        	var insertTr='';
	        	insertTr+="<tr><td style='text-align:right;'></td><td colspan='2'><input type='file' name='file' style='width:500px;' ></td><td><input class='btn btn-danger' type='button' value='삭제' onclick='deleteKey(this)'></td></tr>"	;
	        	$('#pTable').append(insertTr)
	        }
        </script>
		<script>
			/*상위 카테고리 생성시 하위 카테고리 생성  */
			const changeCategory = () =>{
				//subCategory 접근
				var subCategory = document.querySelector('#subCategory');
				// select~option 값 뽑아 내기!!!
				var mainOption=mainCategory.options[mainCategory.selectedIndex].innerText;
				
				
				//하위 요소들 담기
				 var subOptions={
						funiture:['침대','테이블','서랍장','의자','옷장','화장대'],
						bed:['이불','배개','커튼/블라인드','러그'],
						mini:['식물','시계','캔들/디퓨저','윌데코/장식'],
						kitchen:['냄비/프라이팬','그릇','보관용기','수저/커트러리','컵/텀블러','칼/도마'],
						electrnic:['냉장고','TV/모니터','세탁기/건조기','컴퓨터/노트북/태블릿','청소기','계절가전'],
						minielect:['이어폰/헤드셋','스피커','마이크','빔프로젝터','미용가전']
				}
				 
				
				//상위 카테고리 선택 시 하위카테고리 담기
				switch(mainOption){
					case '가구':
						var subOption=subOptions.funiture;
						break;
					case '패브릭':
						var subOption=subOptions.bed;
						break;
					case '인테리어':
						var subOption=subOptions.mini;
						break;
					case '주방용품':
						var subOption=subOptions.kitchen;
						break;
					case '가전제품':
						var subOption=subOptions.electrnic;
						break;
					case '소형가전':
						var subOption=subOptions.minielect;
						break;
				}

				
				subCategory.options.length=0;
				
			 	for(var i=0;i<subOption.length;i++){
					var option=document.createElement('option');
					option.innerText=subOption[i];
					subCategory.append(option);
				}
			}
		
		
		</script>			        
        <script>
        const delBtns= document.getElementsByClassName('deleteAttm');/* 삭제를 누르는 버튼을 의미한다. */
		for(const btn of delBtns){
			btn.addEventListener('click',function(){
				const nextHidden=this.nextElementSibling;
				
				if(nextHidden.value==''){//삭제 버튼을 누르지 않았다면(삭제 off)
					this.style.background='black';
					this.style.color='white';
					this.innerText='삭제취소';
					nextHidden.value=this.id.split("-")[1];
				
				}else{//삭제 버튼을 눌렀다면 (삭제 on)
					this.style.background='none';
					this.style.color='black';
					this.innerText='사진삭제';
					nextHidden.removeAttribute('value');
				}
			});
		}
        
          const form = document.getElementById('productUpdateForm');
        	document.getElementById('editProduct').addEventListener('click',function(e){
        	const files=document.getElementsByName('file');
        	
        	let isEmpty=true;
        	
        	for(const f of files){
        		if(f.value!=''){
        			isEmpty=false;
        		}
        	}
        	let isAllRemove=true;
        	
        	for(const btn of delBtns){
        		if(btn.innerText=='사진삭제'){
        			isAllRemove=false;
        		}
        	}
        	if(isEmpty &&isAllRemove){
        		alert("사진 데이터가 없습니다. 확인 부탁드립니다.")
        		e.preventDefault();
        	}else{
        		form.submit;
	        }
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
