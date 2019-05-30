<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>


<html lang="ko">
<head>
<title>���� �����ȸ</title>

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

		//json���� tranNo�� userId�� ���Ѱ� ������ ���侲�� �����ؾ��ϳ�.
		
		$.ajax({

			url : "/review/json/addReview",
			method : "POST",
			headers : { // �����°� json
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			
			data : JSON.stringify({ //������ data jsonStringȭ
				
				tranNo : tranNo,
				prodNo : prodNo,
				reviewContext : textareaContext 
			}),
			dataType : "text",
			success : function() {
				
				//�޴� ������ �ʿ����, success�̸�!
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
	
		$( " td:contains('���ǵ���')" ).on("click" , function() {
			//Debug..
				
				alert($(this).find("input[id=currentPage1]").val() ); //$('input[id=prodNo]').val() );
				///purchase/updateTranCode?tranNo=${purchase.tranNo}&currentPage=${resultPage.currentPage}
			self.location ="/purchase/updateTranCode?tranNo="+$(this).parent().find("input[id=tranNo]").val()
					+"&currentPage="+$(this).find("input[id=currentPage1]").val();
		
		});
		
		$("td:contains('�����ۼ�')").on("click", function(){
			
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
		        "���": function() {
		          form[0].reset();
		          dialog.dialog( "close" );
		        },
				
		 		"���": function() {
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
		
		//1��° ���� No�� ������
		$( "td:nth-child(1)" ).css("color" , "red");
		
		
	});
	
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!--  dialog form -->
	<div id="dialog-form" title="���� ����">
		<p class="validateTips"></p>
		
		<form id="form">
			<fieldset>
		       <label for="txtArea"><h3>� ���� ���ҳ���?</h3></label>
		       <textarea id="txtArea" rows="20" cols="45" class="text ui-widget-content ui-corner-all" ></textarea>
				<!--  <input type="hidden" id="dialogTranNo" name="dialogTranNo" value=""/>
				<input type="hidden" id="dialogProdNo" name="dialogProdNo" value=""/>-->	
			</fieldset>
		</form>
	</div>
   	
   	
   	<div class="container">
   		
   		<div class="page-header text-info">
	       <h3>�� ���ų���</h3>
	    </div>
   			
   		<div class="row">
   			<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
   		</div>	
   			
   		<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">�� ���Ű���</th>
            <th align="left">���Ű���</th>
            <th align="left">������</th>
            <th align="left">�����Ȳ</th>
            <th align="left">����</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center" title="Click : ������">
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
					�����
					<input type="hidden" id ="currentPage1" name="currentPage1" value="${resultPage.currentPage}"/>
					���ǵ���
				</c:if>
				<c:if test="${purchase.tranCode=='003'}">
					��ۿϷ�
				</c:if>
				<c:if test="${purchase.tranCode=='004'}">
					���ſϷ�
				</c:if>
				<c:if test="${purchase.tranCode=='005'}">
					�������
				</c:if>

			  </td>
			  <td align="left">
				<c:if test="${purchase.tranCode=='003'}">
					<c:if test="${purchase.reviewCode=='Y'}">
						<span class="glyphicon glyphicon-ok" ria-hidden="true"></span>
					</c:if>
					<c:if test="${purchase.reviewCode=='N'}">
						�����ۼ�
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