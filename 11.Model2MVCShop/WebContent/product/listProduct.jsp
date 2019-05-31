<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>


<html lang="ko">
<head>
<title>상품 목록조회</title>

<meta charset="EUC-KR">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>


	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>



<script type="text/javascript">
	
	//var dialogProdNo = null; 일단 전역쓰면 안댄다
	
	var ranoutOrNot;
	
	var buttons = {
		'제품상세보기' : function() {
			//alert("제품상세보기");
			dialog.dialog("close");
			//alert("제품상세보기2");
			readProduct(); // 제품상세보기 page
		},
		'장바구니담기':function(){
			addCart();
		},
		"구매" : function() {
			dialog.dialog("close");
			purchaseProduct();
		}//구매버튼 funciton 끝
		
	}

	function fncGetProductList(currentPage) {

		$("#currentPage").val(currentPage)
		$(".form-inline").attr("method", "POST").attr("action","/product/listProduct?menu=search").submit();

		// jQuery로 수정!
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	}

	function fncAutoComplete() {

		$.ajax({

			url : "/common/json/autocomplete",
			method : "POST",
			headers : { // 보내는거 json
				"Accept" : "application/json",
				"Content-Type" : "application/json ; charset=UTF-8"
			},
			data : JSON.stringify({ //보내는 data jsonString 화
				table : "product",
				searchKeyword : $("input[name=searchKeyword]").val(),
				searchCondition : $("select[name=searchCondition]").val()
			}),
			dataType : "text",
			success : function(serverData, status) {

				var array = JSON.parse(serverData);

				//alert(array);
				$("input#searchKeyword").autocomplete({
					source : array
				});

			}

		});

	}

	function addCart(){
		
		if(ranoutOrNot=='품절')//품절상품은 장바구니에 담을수 없음.
		{
			alert("품절상품입니다.");
			return;
		}
		else{ alert($("#dialogImage").val())}
		
		//ajax로 cart정보 table에 추가 화면은 변하는것 없고, success하면 추가됐다는 alert창뜨기
		
		$.ajax({
			
			url:"/cart/json/addCart",
			method : "POST",
			headers : { // 보내는거 json
				"Accept" : "application/json",
				"Content-Type" : "application/json ; charset=UTF-8"
			},
			data : JSON.stringify({ 
				prodNo : $("#dialogImage").val() //장바구니에 담을 prodNo만 보내준다
			}),
			success : function(status) {
				
				alert(status);
				alert("장바구니에 추가되었습니다!");
	
			}
			
		});
		
		
	}

	function readProduct() {

		//alert("readProduct 실행되냐?")
		//alert( $("#dialogProdNo").val() );
		self.location = "/product/getProduct?prodNo=" + $("#dialogImage").val(); //prod_no
	}
	function purchaseProduct() {
		
		if(ranoutOrNot=='품절')
		{
			alert("품절상품입니다.");
			return;
		}
		alert($("#dialogImage").val());
		self.location = "/purchase/addPurchase?prodNo="+ $("#dialogImage").val(); //prod_no
	}

	$(function() {

		///////////////////////jQuery 검색 post
		$("button:contains('검색')").on("click", function() {

			fncGetProductList(1);
		})

		///////////////////////////////////////////////////dialog
		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 400,
			width : 350,
			modal : true,
			buttons : buttons,
			close : function() {
				//form[0].reset();
				dialog.dialog("close");
			}

		});

		form = dialog.find("#dialog-form").on("submit", function(event) {
			event.preventDefault();

			//addUser();
		});

		// No 클릭하면? No 클릭 event  prodNo보내기 체크
		$("td:nth-child(2)").on("click",

						function() {
							//Debug..
							alert($(this).find('input').val());
							ranoutOrNot = $(this).parent().find('#quantity')
									.text().trim();
							alert("_" + ranoutOrNot + "_");

							///////////////////////classic web에서 ajax web으로 변경
							//self.location ="/product/getProduct?prodNo="+$(this).find('input').val(); //prod_no
							$.ajax({
										url : "/product/json/getProduct/"
												+ $(this).find('input').val(),
										method : "GET",
										dataType : "text",
										success : function(serverData, status) {
											//alert(status);
											//alert(serverData);
											var JSONData = $
													.parseJSON(serverData); // json 객체로 변경			
											// 밑에 다이얼로그 소스를 받아온 이미지Set
											var displayValue = "<img src = \"/images/uploadFiles/"+JSONData.fileName1+"\" width =\"300\" height=\"300\"/>";

											//alert(JSONData.fileName);
											//alert(displayValue);

											//function에서도 사용할수있는 prodNo지정
											$("#dialogImage").val(
													JSONData.prodNo); //dialog에 현재 클릭한 상품 prodNo 셋팅
											//alert($("#dialogImage").val());

											$("#dialogImage")
													.html(displayValue); //dialog 이미지태그 넣기
											dialog.dialog("open");
										}

									}); //ajax끝
						});

		
		});
		///////////////////////////////////////////////////////////////////////

	$(function() {	
		
		
		$("input[name=searchKeyword]").keyup(function() {

			fncAutoComplete();
		});

		
		$("#highprice").click(function() {

			alert("highPrice");
			fncGetProductList(1);
		});
		 
		$("#lowprice").on("click",function() {
			
			//alert("엥?");
			//alert($(this).parent().html());
			fncGetProductList(1);
		})

		////////////////////////////////////////////////////////////////////////////
		//productName글씨 빨간색으로 변경	
		$("td:nth-child(2)").css("color", "red");

	});
		
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->


	<!--  dialog form -->
	<div id="dialog-form" title="이미지 미리보기">
		<form>
			<fieldset id="dialogImage" value="">
				
				<!-- 여기에 .html() 해주기 
				<label for="title" id=""> .text() 해주기</label> 	
				Allow form submission with keyboard without duplicating the dialog button 
				<input type="submit" tabindex="-1" style="position: absolute; top: -1000px"> -->
			</fieldset>
		</form>
	</div>


	<div class="container">
		
		<div class="page-header text-info">
	       <h3>판매상품목록</h3>
	    </div>
		
		<div class="row">
		
			<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
			
		    
		    <div class="col-md-6 text-right">
			   
			    <form class="form-inline" name="detailForm">
			    
			      <div class="form-group">
		    			<select class="form-control" name="orderCondition" >
							
							<option value="0"  ${!empty search.orderCondition && search.orderCondition==0 ? "selected" : "" }>--정렬--</option>
							<option value="1" id="highprice" ${!empty search.orderCondition && search.orderCondition==1 ? "selected" : "" }>가격높은순</option>
							<option value="2" id="lowprice" ${!empty search.orderCondition && search.orderCondition==2 ? "selected" : "" }>가격낮은순</option>

						</select>
		    	  </div>
			    	
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
		   
		</div>

	<br/><br/>
	
	
	
	<c:set var="i" value="0" />  
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />

		<div class="row-inline">
			<div class="col-sm-6 col-md-4">
				<div class="thumbnail">
					<img src="/images/uploadFiles/${product.fileName1}">
					<div class="caption">
						<h5><ins><strong>${product.prodName}</strong><ins></h5>
						<h6>${product.prodDetail}</h6>
						<br/>
						<h5><strong>${product.price}</strong> 원</h5>
						<p>
							<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
							&nbsp; &nbsp; &nbsp; &nbsp;
							<span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
						</p>
					</div>
				</div>
			</div>
		</div>
		
		</c:forEach>




		
	
	</div>

	<!-- PageNavigation Start... -->
	<jsp:include page="../common/productPageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>
