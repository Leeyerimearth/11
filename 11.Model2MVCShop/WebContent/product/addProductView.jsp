<%@ page contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="EUC-KR">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->

<style>
body>div.container {
	border: 3px solid #D6CDB7;
	margin-top: 50px;
}
</style>

<script type="text/javascript">
	function fncAddProduct() {
		//Form ��ȿ�� ����
		/*
		var name = document.detailForm.prodName.value;
		var detail = document.detailForm.prodDetail.value;
		var manuDate = document.detailForm.manuDate.value;
		var price = document.detailForm.price.value;
		var quantity = document.detailForm.quantity.value; //�߰�
		 */

		var name = $('input[name=prodName]').val();
		var detail = $('input[name=prodDetail]').val();
		var manuDate = $('input[name=manuDate]').val();
		var price = $('input[name=price]').val();
		var quantity = $('input[name=quantity]').val();

		if (name == null || name.length < 1) {
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (detail == null || detail.length < 1) {
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if (manuDate == null || manuDate.length < 1) {
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (price == null || price.length < 1) {
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if (quantity == null || quantity.length < 1) {
			alert("��ǰ������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		//document.detailForm.action='/product/addProduct';
		//document.detailForm.submit();

		$("form").attr("method", "POST").attr("action", "/product/addProduct")
				.submit();
	}

	function resetData() {

		$("form")[0].reset();
		//document.detailForm.reset();
	}

	$(function() {

		
		$("#manuDate").datepicker();
		
		$( "button.btn.btn-primary" ).on("click" , function() { // ���
			fncAddProduct();
		});
		
		$("a[href='#' ]").on("click" , function() { // ���
			resetData();
		});

	});
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<jsp:include page="/layout/toolbar.jsp" />
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

   	
   	<div class="container">
   	
   		<h1 class="bg-primary text-center">�� ǰ �� ��</h1>
   		
   		<form class="form-horizontal" enctype="multipart/form-data">
   			
   			<div class="form-group">
		    	<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
		   	 <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ��" >
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��ǰ ������" >
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="price" class="col-sm-offset-1 col-sm-3 control-label">�ǸŰ���</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" placeholder="�Ǹ� ����" >
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="��ǰ ������" >
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="quantity" class="col-sm-offset-1 col-sm-3 control-label">��ǰ����</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="quantity" name="quantity" placeholder="��ǰ ����" >
		     	<span id="helpBlock" class="help-block">
		      	 <strong class="text-danger"> *(999������ �Է°����մϴ�.)</strong>
		      	</span>
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="multifile" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		     <div class="col-sm-4">
		      <input type="file" id="multifile" name="multifile" >
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button> &nbsp;
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
   		
   		</form>
   	</div>
 
</body>
</html>

