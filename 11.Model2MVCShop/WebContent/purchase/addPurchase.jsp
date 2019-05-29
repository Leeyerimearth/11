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
	
	//여기에 조건들어갑니다. alert
	
	var usePoint = $("input[name='usePoint']").val();
	var quantity = $("input[name='buyQuantity']").val();

	
	
	if(usePoint%100 != 0 || usePoint < 0){
		alert("포인트는 100p 단위로 사용이 가능합니다.");
		return;
	}
	
	if(usePoint > "${sessionScope.user.userPoint}"){
		alert("보유 금액 이상 사용은 불가능합니다.");
		$("input[name='usePoint']").val( ${sessionScope.user.userPoint} );
		return;
	}
	
	if(usePoint > quantity * "${sessionScope.vo.price}"){
		alert("구매금액 이상의 포인트는 사용할 수 없습니다.");
		$("input[name='usePoint']").val(${sessionScope.user.userPoint});
		return;	
	}
	
	if(quantity<1){
		
		alert("구매개수를 입력해주세요");
		return;
	}
	
	if(quantity> ${sessionScope.vo.quantity}){
		
		alert("최대 구매개수는"+${sessionScope.vo.quantity}+" 개 입니다!");
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
		
		$("input[name=userPoint]:contains('포인트')").on("click", function(){
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
				<h3 class=" text-info">제품구입정보</h3>
				<h5 class="text-muted">
					내 정보 및 <strong class="text-danger">제품정보를 확인</strong>해 주세요.
				</h5>
			</div>

			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
		    	<div class="col-sm-4">${sessionScope.vo.prodName}</div>
		    </div>

			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    	<div class="col-sm-4">${sessionScope.vo.prodDetail}</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    	<div class="col-sm-4">${sessionScope.vo.manuDate}</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    	<div class="col-sm-4">
		    		<fmt:formatNumber value="${sessionScope.vo.price}" groupingUsed="true" /> 원
		    	</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		    	<div class="col-sm-4">${sessionScope.vo.regDate}</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    	<div class="col-sm-4">${user.userId}</div>
		    </div>

			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    	<div class="col-sm-4">
		      		<select class="form-control" name="paymentOption">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
					</select>
		   		</div>
		    </div>
			
			<div class="form-group">
		    	<label class="col-sm-offset-1 col-sm-3 control-label">보유 포인트</label>
		    	<div class="col-sm-4">${sessionScope.user.userPoint}</div>
		    </div>
			
			<div class="form-group">
		    	<label for="usePoint" class="col-sm-offset-1 col-sm-3 control-label">사용 포인트</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="usePoint" name="usePoint" value="0" >
		      		p(* 100p 단위로 사용가능합니다.)
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="buyQuantity" class="col-sm-offset-1 col-sm-3 control-label">구매 개수</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="buyQuantity" name="buyQuantity" value="0">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="divyRequest" name="divyRequest" >
		   		</div>
		    </div>
		    
		    <div class="form-group">
		    	<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    	<div class="col-sm-4">
		      		<input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="배송희망일자">
		   		</div>
		    </div>


			<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >구 &nbsp;매</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>




		</form>
   
   	</div>

</body>
</html>