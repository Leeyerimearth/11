<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>


<html lang="ko">
<head>
<title>��ǰ �����ȸ</title>

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
	
	//var dialogProdNo = null; �ϴ� �������� �ȴ��
	
	var ranoutOrNot;
	
	var buttons = {
		'��ǰ�󼼺���' : function() {
			//alert("��ǰ�󼼺���");
			dialog.dialog("close");
			//alert("��ǰ�󼼺���2");
			readProduct(); // ��ǰ�󼼺��� page
		},
		'��ٱ��ϴ��':function(){
			addCart();
		},
		"����" : function() {
			dialog.dialog("close");
			purchaseProduct();
		}//���Ź�ư funciton ��
		
	}

	function fncGetProductList(currentPage) {

		$("#currentPage").val(currentPage)
		$(".form-inline").attr("method", "POST").attr("action","/product/listProduct?menu=search").submit();

		// jQuery�� ����!
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	}

	function fncAutoComplete() {

		$.ajax({

			url : "/common/json/autocomplete",
			method : "POST",
			headers : { // �����°� json
				"Accept" : "application/json",
				"Content-Type" : "application/json ; charset=UTF-8"
			},
			data : JSON.stringify({ //������ data jsonString ȭ
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
		
		if(ranoutOrNot=='ǰ��')//ǰ����ǰ�� ��ٱ��Ͽ� ������ ����.
		{
			alert("ǰ����ǰ�Դϴ�.");
			return;
		}
		else{ alert($("#dialogImage").val())}
		
		//ajax�� cart���� table�� �߰� ȭ���� ���ϴ°� ����, success�ϸ� �߰��ƴٴ� alertâ�߱�
		
		$.ajax({
			
			url:"/cart/json/addCart",
			method : "POST",
			headers : { // �����°� json
				"Accept" : "application/json",
				"Content-Type" : "application/json ; charset=UTF-8"
			},
			data : JSON.stringify({ 
				prodNo : $("#dialogImage").val() //��ٱ��Ͽ� ���� prodNo�� �����ش�
			}),
			success : function(status) {
				
				alert(status);
				alert("��ٱ��Ͽ� �߰��Ǿ����ϴ�!");
	
			}
			
		});
		
		
	}

	function readProduct() {

		//alert("readProduct ����ǳ�?")
		//alert( $("#dialogProdNo").val() );
		self.location = "/product/getProduct?prodNo=" + $("#dialogImage").val(); //prod_no
	}
	function purchaseProduct() {
		
		if(ranoutOrNot=='ǰ��')
		{
			alert("ǰ����ǰ�Դϴ�.");
			return;
		}
		alert($("#dialogImage").val());
		self.location = "/purchase/addPurchase?prodNo="+ $("#dialogImage").val(); //prod_no
	}

	$(function() {

		///////////////////////jQuery �˻� post
		$("button:contains('�˻�')").on("click", function() {

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

		// No Ŭ���ϸ�? No Ŭ�� event  prodNo������ üũ
		$("td:nth-child(2)").on("click",

						function() {
							//Debug..
							alert($(this).find('input').val());
							ranoutOrNot = $(this).parent().find('#quantity')
									.text().trim();
							alert("_" + ranoutOrNot + "_");

							///////////////////////classic web���� ajax web���� ����
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
													.parseJSON(serverData); // json ��ü�� ����			
											// �ؿ� ���̾�α� �ҽ��� �޾ƿ� �̹���Set
											var displayValue = "<img src = \"/images/uploadFiles/"+JSONData.fileName1+"\" width =\"300\" height=\"300\"/>";

											//alert(JSONData.fileName);
											//alert(displayValue);

											//function������ ����Ҽ��ִ� prodNo����
											$("#dialogImage").val(
													JSONData.prodNo); //dialog�� ���� Ŭ���� ��ǰ prodNo ����
											//alert($("#dialogImage").val());

											$("#dialogImage")
													.html(displayValue); //dialog �̹����±� �ֱ�
											dialog.dialog("open");
										}

									}); //ajax��
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
			
			//alert("��?");
			//alert($(this).parent().html());
			fncGetProductList(1);
		})

		////////////////////////////////////////////////////////////////////////////
		//productName�۾� ���������� ����	
		$("td:nth-child(2)").css("color", "red");

	});
		
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->


	<!--  dialog form -->
	<div id="dialog-form" title="�̹��� �̸�����">
		<form>
			<fieldset id="dialogImage" value="">
				
				<!-- ���⿡ .html() ���ֱ� 
				<label for="title" id=""> .text() ���ֱ�</label> 	
				Allow form submission with keyboard without duplicating the dialog button 
				<input type="submit" tabindex="-1" style="position: absolute; top: -1000px"> -->
			</fieldset>
		</form>
	</div>


	<div class="container">
		
		<div class="page-header text-info">
	       <h3>�ǸŻ�ǰ���</h3>
	    </div>
		
		<div class="row">
		
			<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
			
		    
		    <div class="col-md-6 text-right">
			   
			    <form class="form-inline" name="detailForm">
			    
			      <div class="form-group">
		    			<select class="form-control" name="orderCondition" >
							
							<option value="0"  ${!empty search.orderCondition && search.orderCondition==0 ? "selected" : "" }>--����--</option>
							<option value="1" id="highprice" ${!empty search.orderCondition && search.orderCondition==1 ? "selected" : "" }>���ݳ�����</option>
							<option value="2" id="lowprice" ${!empty search.orderCondition && search.orderCondition==2 ? "selected" : "" }>���ݳ�����</option>

						</select>
		    	  </div>
			    	
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
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
						<h5><strong>${product.price}</strong> ��</h5>
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
