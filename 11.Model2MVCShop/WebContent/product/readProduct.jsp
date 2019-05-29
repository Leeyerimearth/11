<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko">


<head>

	<meta charset="EUC-KR">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>


	<script type="text/javascript">
	
		$(function(){
			
			$("button.btn.btn-primary").on("click",function(){
				alert( ${sessionScope.vo.prodNo} );
				self.location = "/purchase/addPurchase?prod_no=${sessionScope.vo.prodNo}";
			});
			
			$("a[href='#' ]").on("click", function(){
				history.go(-1);
			});
			
			$("td:contains('리뷰보기')").on("click",function(){
				
			});
			
			$("#accordion").accordion({
				collapsible:true
			});
			
		});
	</script>


</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
		
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	       <h5 class="text-muted">상품상세정보입니다.<strong class="text-danger"></strong></h5>
	    </div>
		
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.vo.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품 이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${sessionScope.vo.fileName1 !=null}">
					<img src="/images/uploadFiles/${sessionScope.vo.fileName1}" />
				</c:if>
				<c:if test="${sessionScope.vo.fileName2 !=null}">
					<img src="/images/uploadFiles/${sessionScope.vo.fileName2}" />
				</c:if>
				<c:if test="${sessionScope.vo.fileName3 !=null}">
					<img src="/images/uploadFiles/${sessionScope.vo.fileName3}" />
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.vo.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.vo.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">
				<fmt:formatNumber value="${sessionScope.vo.price}" groupingUsed="true"/>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${sessionScope.vo.regDate}</div>
		</div>		
		
		<hr/>
		<br/>
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2" id ="ShowReview">
	  			<h4>
	  				<strong>리뷰보기</strong>
	  				<span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span> 
	  			</h4>
	  		</div>
		</div>
		
		<br/>
		<hr/>

		<div id="accordion">
			
		   <c:set var="i" value="0" />
		   <c:forEach var="review" items="${list}">
		   	<c:set var="i" value="${ i+1 }" />
			
			<h3>${review.writerId}님이 작성한 리뷰 입니다.</h3>
			<div id="${i}context">
				<p>${review.reviewContext}</p>
			</div>
		   </c:forEach>
		   
		</div>
		
		<br/>
		<hr/>

		<div class="col-sm-offset-4  col-sm-4 text-center">
		     <c:if test="${sessionScope.vo.quantity>=1}">
		      <button type="button" class="btn btn-primary"  >구 &nbsp;매</button> &nbsp;
		     </c:if>
			  <a class="btn btn-primary btn" href="#" role="button">이&nbsp;전</a>
		 </div>
	
	</div>
	

</body>
</html>