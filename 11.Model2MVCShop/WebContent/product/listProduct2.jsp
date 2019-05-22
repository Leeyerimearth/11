<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<%--
<%@ page import="java.util.List" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.service.domain.Product"%>
<%@ page import="com.model2.mvc.common.Page" %>
<%@ page import="com.model2.mvc.common.util.CommonUtil" %>

<%
	String menu =request.getParameter("menu");

	List<Product> list=(List<Product>)request.getAttribute("list");
	Page resultPage = (Page)request.getAttribute("resultPage");

	Search search=(Search)request.getAttribute("search");

	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
	
%>

--%>
<html  lang="ko">
<head>
<title>상품 목록조회</title>


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

	function fncGetProductList(currentPage){
		
		$("#currentPage").val(currentPage)
		$("form").attr("method","POST").attr("action","/product/listProduct2?menu=manage").submit();
	
		// jQuery로 수정!
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	}
	
	function fncAutoComplete(){
		
		$.ajax({
			
			 url :"/common/json/autocomplete",
			 method : "POST",
			 headers : { // 보내는거 json
					"Accept" : "application/json",
					"Content-Type" : "application/json ; charset=UTF-8"
				},
			 data: JSON.stringify({ //보내는 data jsonString 화
				 		table : "product",
				 		searchKeyword : $("input[name=searchKeyword]").val(),
				 		searchCondition : $("select[name=searchCondition]").val()
				   }),
			 dataType : "text",
			 success : function(serverData, status){
				
				var array = JSON.parse(serverData);
			
				//alert(array);
				$("input#searchKeyword").autocomplete({
					source : array
				});
				
			 }
		
		 });
		
	}
	
	

	$(function(){ 
	
		///////////////////////jQuery 검색 post
		$("button:contains('검색')").on("click",function(){
		
			fncGetProductList(1);
		})
	
		// No 클릭하면? No 클릭 event  prodNo보내기 체크
		$( "td:nth-child(2)" ).on("click" , function() {
			//Debug..
				//alert( $('input[id=prodNo]').val() );
				alert( $(this).find('input').val()); //$('input[id=prodNo]').val() );
			self.location ="/product/getProduct?prodNo="+$(this).find('input').val();
		
		});
	
		
		$("input[name=searchKeyword]").keyup(function() {

			fncAutoComplete();
		});
		
	
		//productName글씨 빨간색으로 변경	
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
	       <h3>판매상품관리</h3>
	    </div>
		
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<div class="row">
			
			 <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
		   
		</div>
		<!-- table 위쪽 검색 end /////////////////////////////////////-->
	
		 <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">재고</th>
            <th align="left">현재상태</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 상세정보">${product.prodName}
			  	<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
			  </td>
			  <td align="left">
			 	 <fmt:formatNumber value="${product.price}" groupingUsed="true"/>
			  </td>
			  <td align="left">${product.regDate}</td>
			  <td align="left">${product.quantity}</td>
			  
			  <c:if test="${product.quantity >= 1}">
			  <td align="center">판매중
			  </c:if>
			  <c:if test="${product.quantity <= 0}">
			  <td align="center">품절
			  </c:if>
			 
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
	
	<!-- PageNavigation Start... -->
	<jsp:include page="../common/productPageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
	

</body>
</html>
