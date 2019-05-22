<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<%--
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.Purchase" %>
<%@ page import="com.model2.mvc.service.domain.User" %>
<%@ page import="com.model2.mvc.common.*" %>

<%
	User user =(User)session.getAttribute("user");

	List<Purchase> list=(List<Purchase>)request.getAttribute("list");
	Search search=(Search)request.getAttribute("search");
	Page resultPage = (Page)request.getAttribute("resultPage");
	/*
	int total=0;
	ArrayList<Purchase> list=null;
	if(map != null){
		total=((Integer)map.get("count")).intValue();
		list=(ArrayList<Purchase>)map.get("list");
	}
	
	int currentPage=search.getCurrentPage();
	*/
%>

--%>

<html  lang="ko">
<head>
<title>구매 관리</title>

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
	function fncGetPurchaseList(currentPage) {
		
		$("#currentPage").val(currentPage);
		$('form').attr("method","POST").attr("action","/purchase/listPurchase").submit();
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	}
	
	$(function(){
		
		$( "td:nth-child(1)" ).on("click" , function() {
			//Debug..
				//alert( $('input[id=prodNo]').val() );
				alert( $(this).find('input').val()); //$('input[id=prodNo]').val() );
				///purchase/getPurchase?tranNo=${purchase.tranNo}
			self.location ="/purchase/getPurchase?tranNo="+$(this).find('input').val();
		
		});
	
		$( "td:contains('배송하기')" ).on("click" , function() {
			//Debug..
				
				alert($(this).find("input[id=currentPage1]").val() ); //$('input[id=prodNo]').val() );
				///purchase/updateTranCode?tranNo=${purchase.tranNo}&currentPage=${resultPage.currentPage}
			self.location ="/purchase/updateTranCode?tranNo="+$(this).parent().find("input[id=tranNo]").val()
					+"&currentPage="+$(this).find("input[id=currentPage1]").val();
		
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
   	
   	<div class="container">
   		
   		<div class="page-header text-info">
	       <h3>구매내역관리</h3>
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
            <th align="left">구매자</th>
            <th align="left">총 구매가격</th>
            <th align="left">구매개수</th>
            <th align="left">구매일</th>
            <th align="left">배송현황</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center" title="Click : 상세정보">
			  	<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}"/>
			  	${ i }
			  </td>
			  <td align="left">${purchase.purchaseProd.prodName}</td>
			  <td align="left">${purchase.buyer.userId}</td>
			  <td align="left"> 
			  <fmt:formatNumber value="${purchase.purchaseProd.price}" groupingUsed="true"/>
			  </td>
			  <td align="left">${purchase.buyQuantity}</td>
			  <td align="left">${purchase.orderDate}</td>
			  
			  <td align="left">현재
				<c:if test="${purchase.tranCode=='002'}">
					배송중 상태 입니다.
				</c:if>
				<c:if test="${purchase.tranCode=='003'}">
					배송완료 상태 입니다.
				</c:if>
				<c:if test="${purchase.tranCode=='004'}">
					구매완료 상태 입니다.
				
					<input type="hidden" id ="currentPage1" name="currentPage1" value="${resultPage.currentPage}"/>
					 배송하기 
				</c:if>
				<c:if test="${purchase.tranCode=='005'}">
					구매취소 상태 입니다.
				</c:if>

			  </td>
			 
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
   	
   	</div>
   	
   	<!-- PageNavigation Start... -->
	<jsp:include page="../common/purchasePageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
   	
</body>
</html>