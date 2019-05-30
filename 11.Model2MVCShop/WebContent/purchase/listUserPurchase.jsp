<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>


<html lang="ko">
<head>
<title>구매 목록조회</title>

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
        
       #dialog-form { display: none; }
    </style>
<script type="text/javascript">
	
	function fncGetPurchaseList(currentPage) {
		
		$("#currentPage").val(currentPage);
		//$('form').attr("method","POST").attr("action","/purchase/listPurchase").submit();
		
		self.location = "/purchase/listPurchase?currentPage="+$("#currentPage").val();
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	
	}
	
	function addReview(tranNo,prodNo,selectedPurchase){
		
		alert($("#txtArea").val());
		var textareaContext = $("#txtArea").val();

		//json으로 tranNo랑 userId에 대한게 있으면 리뷰쓰기 삭제해야하나.
		
		$.ajax({

			url : "/review/json/addReview",
			method : "POST",
			headers : { // 보내는거 json
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			
			data : JSON.stringify({ //보내는 data jsonString화
				
				tranNo : tranNo,
				prodNo : prodNo,
				reviewContext : textareaContext 
			}),
			dataType : "text",
			success : function() {
				
				//받는 데이터 필요없고, success이면!
				alert(selectedPurchase.html());
				selectedPurchase.html("<span class='glyphicon glyphicon-ok' ria-hidden='true'></span>")

				
			}
		});
		
	}
	
	$(function(){
		
		var tranNo;
		var prodNo;
		var selectedPurchase;
		
		$( "td:nth-child(1)" ).on("click" , function() {
			//Debug..
				//alert( $('input[id=prodNo]').val() );
				alert( $(this).find('input').val()); //$('input[id=prodNo]').val() );
				///purchase/getPurchase?tranNo=${purchase.tranNo}
			self.location ="/purchase/getPurchase?tranNo="+$(this).find('input').val();
		
		});
	
		$( " td:contains('물건도착')" ).on("click" , function() {
			//Debug..
				
				alert($(this).find("input[id=currentPage1]").val() ); //$('input[id=prodNo]').val() );
				///purchase/updateTranCode?tranNo=${purchase.tranNo}&currentPage=${resultPage.currentPage}
			self.location ="/purchase/updateTranCode?tranNo="+$(this).parent().find("input[id=tranNo]").val()
					+"&currentPage="+$(this).find("input[id=currentPage1]").val();
		
		});
		
		$("td:contains('리뷰작성')").on("click", function(){
			
			tranNo = $(this).parent().find("input[id=tranNo]").val();
			prodNo = $(this).parent().find("input[id=prodNo]").val();
			selectedPurchase = $(this);
			alert("selectedPurchase : "+selectedPurchase);
			dialog.dialog("open");
			
		});
		
		dialog = $( "#dialog-form" ).dialog({
		      autoOpen: false,
		      height: 500,
		      width: 350,
		      modal: true,
		      buttons: {
		        "취소": function() {
		          form[0].reset();
		          dialog.dialog( "close" );
		        },
				
		 		"등록": function() {
		 		  alert("tranNo:"+tranNo);
		 		  addReview(tranNo,prodNo,selectedPurchase);
	          	  dialog.dialog( "close" );
	        	}
		
		      },
		      close: function() {
		        form[ 0 ].reset();
		        dialog.dialog("close");
		      }
		    });
		
		form = dialog.find( "form" ).on( "submit", function( event ) {
		      event.preventDefault();
		
		});
		
		//1번째 인자 No를 색변경
		$( "td:nth-child(1)" ).css("color" , "red");
		
		
	});
	
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!--  dialog form -->
	<div id="dialog-form" title="리뷰 쓰기">
		<p class="validateTips"></p>
		
		<form id="form">
			<fieldset>
		       <label for="txtArea"><h3>어떤 점이 좋았나요?</h3></label>
		       <textarea id="txtArea" rows="20" cols="45" class="text ui-widget-content ui-corner-all" ></textarea>
				<!--  <input type="hidden" id="dialogTranNo" name="dialogTranNo" value=""/>
				<input type="hidden" id="dialogProdNo" name="dialogProdNo" value=""/>-->	
			</fieldset>
		</form>
	</div>
   	
   	
   	<div class="container">
   		
   		<div class="page-header text-info">
	       <h3>내 구매내역</h3>
	    </div>
   			
   		<div class="row">
   			<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
   		</div>	
   			
   		<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >제품명</th>
            <th align="left">총 구매가격</th>
            <th align="left">구매개수</th>
            <th align="left">구매일</th>
            <th align="left">배송현황</th>
            <th align="left">리뷰</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center" title="Click : 상세정보">
			  	<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}"/>
			  	<input type="hidden" id="prodNo" name="prodNo" value="${purchase.purchaseProd.prodNo}"/>
			  	${ i }
			  </td>
			  <td align="left">${purchase.purchaseProd.prodName}</td>
			  <td align="left"> 
			  <fmt:formatNumber value="${purchase.purchaseProd.price}" groupingUsed="true"/>
			  </td>
			  <td align="left">${purchase.buyQuantity}</td>
			  <td align="left">${purchase.orderDate}</td>
			  
			  <td align="left">
				<c:if test="${purchase.tranCode=='002'}">
					배송중
					<input type="hidden" id ="currentPage1" name="currentPage1" value="${resultPage.currentPage}"/>
					물건도착
				</c:if>
				<c:if test="${purchase.tranCode=='003'}">
					배송완료
				</c:if>
				<c:if test="${purchase.tranCode=='004'}">
					구매완료
				</c:if>
				<c:if test="${purchase.tranCode=='005'}">
					구매취소
				</c:if>

			  </td>
			  <td align="left">
				<c:if test="${purchase.tranCode=='003'}">
					<c:if test="${purchase.reviewCode=='Y'}">
						<span class="glyphicon glyphicon-ok" ria-hidden="true"></span>
					</c:if>
					<c:if test="${purchase.reviewCode=='N'}">
						리뷰작성
					</c:if>
				</c:if>
			  </td>
			 
			</tr>
          </c:forEach>
        	<tr>
        		<td>
        			<input type="hidden" id="currentPage" name="currentPage" value=""/>
        		</td>
        	</tr>
        </tbody>
      	
      </table>	
   		
   	</div>
   	
   	
   	<!-- PageNavigation Start... -->
	<jsp:include page="../common/purchasePageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
   	

</body>
</html>