<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko">
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">


	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	<style>
 		body {
            padding-top : 50px;
        }
     </style>

<script type="text/javascript">

function fncAddPurchase() {
	
	//���⿡ ���ǵ��ϴ�. alert
	
	var usePoint = $("input[name='usePoint']").val();
	var quantity = $("input[name='buyQuantity']").val();

	
	
	if(usePoint%100 != 0 || usePoint < 0){
		alert("����Ʈ�� 100p ������ ����� �����մϴ�.");
		return;
	}
	
	if(usePoint > "${sessionScope.user.userPoint}"){
		alert("���� �ݾ� �̻� ����� �Ұ����մϴ�.");
		$("input[name='usePoint']").val( ${sessionScope.user.userPoint} );
		return;
	}
	
	if(usePoint > quantity * "${sessionScope.vo.price}"){
		alert("���űݾ� �̻��� ����Ʈ�� ����� �� �����ϴ�.");
		$("input[name='usePoint']").val(${sessionScope.user.userPoint});
		return;	
	}
	
	if(quantity<1){
		
		alert("���Ű����� �Է����ּ���");
		return;
	}
	
	if(quantity> ${sessionScope.vo.quantity}){
		
		alert("�ִ� ���Ű�����"+${sessionScope.vo.quantity}+" �� �Դϴ�!");
		return;
	}
	
	
	$('form').attr("method","POST").attr("action","/purchase/addPurchase").submit();
	//document.addPurchase.submit();
}

	$(function(){
		
		$("#divyDate").datepicker();
		
		$("button.btn.btn-primary").on("click", function(){
			
			fncAddPurchase();
		});
		
		$("a[href='#' ]").on("click", function(){
			
			history.go(-1);
		});
		
		$("input[name=userPoint]:contains('����Ʈ')").on("click", function(){
			$("input[name=userPoint]").val("${sessionScope.user.userPoint}");
		})
		
	});

</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   		
   		<form class="form-horizontal">
   			
   			<input type="hidden" name="prodNo" value="${sessionScope.vo.prodNo}" />
   			<input type="hidden" name="buyerId" value=" ${sessionScope.user.userId}"/>


			<div class="page-header">
				<h3 class=" text-info">��ǰ��������</h3>
				<h5 class="text-muted">
					�� ���� �� <strong class="text-danger">��ǰ������ Ȯ��</strong>�� �ּ���.
				</h5>
			</div>

			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
		    	<div class="col-sm-4">${sessionScope.vo.prodName}</div>
		    </div>

			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    	<div class="col-sm-4">${sessionScope.vo.prodDetail}</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    	<div class="col-sm-4">${sessionScope.vo.manuDate}</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    	<div class="col-sm-4">
		    		<fmt:formatNumber value="${sessionScope.vo.price}" groupingUsed="true" /> ��
		    	</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    	<div class="col-sm-4">${sessionScope.vo.regDate}</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
		    	<div class="col-sm-4">${user.userId}</div>
		    </div>

			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    	<div class="col-sm-4">
		      		<select class="form-control" name="paymentOption">
						<option value="1" selected="selected">���ݱ���</option>
						<option value="2">�ſ뱸��</option>
					</select>
		   		</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">���� ����Ʈ</label>
		    	<div class="col-sm-4">${sessionScope.user.userPoint}</div>
		    </div>
			
			<div class="form-group">
		    	<label for="usePoint" class="col-sm-offset-1 col-sm-3 control-label">��� ����Ʈ</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="usePoint" name="usePoint" value="0" >
		      		p(* 100p ������ ��밡���մϴ�.)
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="buyQuantity" class="col-sm-offset-1 col-sm-3 control-label">���� ����</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="buyQuantity" name="buyQuantity" value="0">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="divyRequest" name="divyRequest" >
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="����������">
		   		</div>
		    </div>


			<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>




		</form>
   
   	</div>

</body>
</html>