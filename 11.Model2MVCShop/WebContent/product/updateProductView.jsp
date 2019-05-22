<%@ page contentType="text/html; charset=EUC-KR" %>

<!DOCTYPE html>


<html lang="ko">
<head>
<title>ȸ����������</title>
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

function fncAddProduct(){
	//Form ��ȿ�� ����
 	/*
		var name = document.detailForm.prodName.value;
		var detail = document.detailForm.prodDetail.value;
		var manuDate = document.detailForm.manuDate.value;
		var price = document.detailForm.price.value;
	*/
	
	var name = $('input[name=prodName]').val();
	var detail = $('input[name=prodDetail]').val();
	var manuDate = $('input[name=manuDate]').val();
	var price = $('input[name=price]').val();
	
	
	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	
	$("form").attr("method","POST").attr("action","/product/updateProduct").submit();
	
	//document.detailForm.action='/product/updateProduct';
	//document.detailForm.submit();
}

	$(function(){
		
		$("#manuDate").datepicker();
		
		$( "button.btn.btn-primary" ).on("click" , function() { // ���
			fncAddProduct();
		});
		
		$("a[href='#' ]").on("click" , function() { // ���
			history.go(-1);
		});
		
	})

</script>
</head>

<body>
	
	<div class="container">
   	
   		<h1 class="bg-primary text-center">�� ǰ �� ��</h1>
   		
   		<form class="form-horizontal" enctype="multipart/form-data">
   		
   			<input type="hidden" name="prodNo" value="${sessionScope.vo.prodNo}"/>
   			
   			<div class="form-group">
		    	<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
		   	 <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${sessionScope.vo.prodName}"/>
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${sessionScope.vo.prodDetail}" />
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="price" class="col-sm-offset-1 col-sm-3 control-label">�ǸŰ���</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" value="${sessionScope.vo.price}" />
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" value="${sessionScope.vo.manuDate}"/>
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="quantity" class="col-sm-offset-1 col-sm-3 control-label">��ǰ����</label>
		     <div class="col-sm-4">
		      <input type="text" class="form-control" id="quantity" name="quantity" value="${sessionScope.vo.quantity}" />
		     	<span id="helpBlock" class="help-block">
		      	 <strong class="text-danger"> *(999������ �Է°����մϴ�.)</strong>
		      	</span>
		     </div>
		 	</div>
		 	
		 	<div class="form-group">
		    	<label for="multifile" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		     <div class="col-sm-4">
		      <input type="file" id="multifile" name="multifile" value="${sessionScope.vo.fileName}"/>
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