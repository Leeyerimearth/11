<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="/resources/demos/external/jquery-mousewheel/jquery.mousewheel.js"></script>


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
		
	$( function() {
	    
		$( ".spinner.abc" ).spinner({
	      	min :1,
			spin: function( event, ui ) {
	    	  
	    	  
	    	 // alert($(this).spinner("value"));
	    	 var eachPrice = $(this).attr('id');
	    	 var value = $(this).spinner("value")+1;
	    	 var sumPrice = eachPrice * value; // 얘를 set해주면된다.
			
	    	 if(value==1){
	    		 $(this).parent().parent().parent().find("#totalPrice").html("<h4>"+eachPrice+"원<h4>"); 
	    	}
	    	
	    	 else{
	    	 	$(this).parent().parent().parent().find("#totalPrice").html("<h4>"+sumPrice+"원<h4>");
	    	 } 
	    	 
	        if ( ui.value < 1 ) {
	          $( this ).spinner( "value", 1 );
	          
	          return false;
	        }
	
	      }
	    });
	    
	    
	    
	    
	  } );
	
	
	
	</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>내 장바구니</h3>
	    </div>
	
		
		 <table class="table table-hover table-striped" >

			<thead>
				<tr>
					<th align="center">선택</th>
					<th align="center"></th>
					<th align="left">상품정보</th>
					<th align="left">수량</th>
					<th align="left">주문금액</th>
					<th align="left">배송비</th>
				</tr>
			</thead>
	
			<tbody>
		
		  	<c:set var="i" value="0" />
		  	<c:forEach var="cart" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">
			  <br/><br/>
			  	<input type="checkbox" id="${cart.cartProduct.prodNo}" value="${cart.cartProduct.prodNo}"/>
			  </td>
			  <td align="left" width="150">
			  	<img src = "/images/uploadFiles/${cart.cartProduct.fileName1}" width="100" height="100"/>
			  </td>  
			  <td align="left">
			  	<h5><ins>${cart.cartProduct.prodName}</ins></h5>
			  	<h5><strong> ${cart.cartProduct.prodDetail} </strong></h5>
			  	<h5> <fmt:formatNumber value="${cart.cartProduct.price}" groupingUsed="true"/> 원 </h5>
			  </td>
			  <td align="left">
			  	<br/>
  				<input class="spinner abc" name="value" id ="${cart.cartProduct.price}" ><br/><br/>
  			
  				<div class="col-sm-offset-1 col-sm-11">
  					<button type="button" class="btn btn-warning">BUY NOW</button>
			  	</div>
			  </td> 
			  <td align="left">
			  	<!-- 바로바로 값 바뀌는거로 onclick 이벤트 (spinner)-->
			  	<br/>
			  	
			  	<strong id ="totalPrice"><h4>${cart.cartProduct.price} 원 </h4></strong>
			  		
			  </td>
			   <td align="left"><!-- 배송비필요없음. --></td>
	  
			</tr>
          </c:forEach>
        
        </tbody>


		</table>
	
		<hr/>
		
		<div class="btn-group" role="group" aria-label="...">
  			<button type="button" class="btn btn-default">선택상품 삭제</button>
  			<button type="button" class="btn btn-default">선택상품 구매</button>
  		</div>
	
	</div>


</body>
</html>