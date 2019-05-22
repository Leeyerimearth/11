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

<html lang="ko">
<head>
<title>베스트 top 10</title>
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
	function fncGetProduct() {
		//document.getElementById("currentPage").value = currentPage;
		
		$("form").attr("method","POST").attr("action","/product/getProduct").submit();
		//document.detailForm.submit();
	}
	
	$(function(){
		
		$( "td:nth-child(2)" ).on("click" , function() {
			//Debug..
			alert( $(this).find('input').val());
			self.location ="/product/getProduct?prodNo="+$(this).find('input').val();
			
		});
		
		$( "td:nth-child(2)" ).css("color" , "red");
		
	
	
	});
	
	
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
		
		<div class="page-header text-info">
	       <h3>Best Top 10</h3>
	    </div>
	    
	   <table class="table table-hover table-striped" >
			
		<thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">미리보기</th>
            <th align="left">제품상세정보</th>
          </tr>
        </thead>
		
		
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${product.prodName}
			  	<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
			  </td>
			  <td align="left">
			 	 <fmt:formatNumber value="${product.price}" groupingUsed="true"/>
			  </td>
			  <td align="left" width="150">
			  	<img src = "/images/uploadFiles/${product.fileName}" width="150" height="150"/>
			  </td>  
			  <td align="left">${product.prodDetail}</td>
	  
			</tr>
          </c:forEach>
        
        </tbody>
		
		</table>
	
	</div>

</body>
</html>