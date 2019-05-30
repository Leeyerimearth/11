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
	    	 //value = $(this).spinner("value")+1;
	    	 //$(this)
	    	 var value = ui.value;
	    	 //alert(value);
	    	 
	    	 var sumPrice = eachPrice * value; // �긦 set���ָ�ȴ�.
			
	    	 if(value==1){
	    		 $(this).parent().parent().parent().find("#totalPrice").html("<h4>"+eachPrice+" ��<h4>"); 
	    	}
	    	
	    	 else{
	    	 	$(this).parent().parent().parent().find("#totalPrice").html("<h4>"+sumPrice+" ��<h4>");
	    	 } 
	    	 
	        if ( ui.value < 1 ) {
	          $( this ).spinner( "value", 1 );
	          
	          return false;
	        }
	
	      }
	    });
	    
		
		$(".btn.btn-warning").on("click",function(){
			var prodNo = $(this).parent().parent().parent().find("input[type=checkbox]").val() //�����Ѿ� prodNo
			//$(this).parent().parent().parent().find(".spinner.abc").val()
			var quantity = $(this).parent().parent().parent().find(".spinner.abc").val();
			
			self.location = "/purchase/addPurchase?prodNo="+prodNo+"&quantity="+quantity;
			
		});
	    
		$("button:contains('���û�ǰ ����')").on("click",function(){
			
			alert("����!");
			$("input[type=checkbox]").each(function(){
				
		    	if(this.checked){
					//alert("���!");
					$(this).parent().parent().html(""); //�� �ƴ϶�, ajax�� db�����, list�ٽ� �޾ƿ�����
				}    	
		    });
			
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
	       <h3>�� ��ٱ���</h3>
	    </div>
	
		
		 <table class="table table-hover table-striped" >

			<thead>
				<tr>
					<th align="center">����</th>
					<th align="center"></th>
					<th align="left">��ǰ����</th>
					<th align="left">����</th>
					<th align="left">�ֹ��ݾ�</th>
					<th align="left">��ۺ�</th>
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
			  	<h5> <fmt:formatNumber value="${cart.cartProduct.price}" groupingUsed="true"/> �� </h5>
			  </td>
			  <td align="left">
			  	<br/>
  				<input class="spinner abc" id ="${cart.cartProduct.price}" value="1"><br/><br/>
  			
  				<div class="col-sm-offset-1 col-sm-11">
  					<button type="button" class="btn btn-warning">BUY NOW</button>
			  	</div>
			  </td> 
			  <td align="left">
			  	<!-- �ٷιٷ� �� �ٲ�°ŷ� onclick �̺�Ʈ (spinner)-->
			  	<br/>
			  	
			  	<strong id ="totalPrice"><h4>${cart.cartProduct.price} �� </h4></strong>
			  		
			  </td>
			   <td align="left"><!-- ��ۺ��ʿ����. --></td>
	  
			</tr>
          </c:forEach>
        
        </tbody>


		</table>
	
		<hr/>
		
		<div class="btn-group" role="group" aria-label="...">
  			<button type="button" class="btn btn-default">���û�ǰ ����</button>
  			<button type="button" class="btn btn-default">���û�ǰ ����</button>
  		</div>
	
	</div>


</body>
</html>