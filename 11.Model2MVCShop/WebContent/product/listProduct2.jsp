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

	function fncGetProductList(currentPage){
		
		$("#currentPage").val(currentPage)
		$("form").attr("method","POST").attr("action","/product/listProduct2?menu=manage").submit();
	
		// jQuery�� ����!
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	}
	
	function fncAutoComplete(){
		
		$.ajax({
			
			 url :"/common/json/autocomplete",
			 method : "POST",
			 headers : { // �����°� json
					"Accept" : "application/json",
					"Content-Type" : "application/json ; charset=UTF-8"
				},
			 data: JSON.stringify({ //������ data jsonString ȭ
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
	
		///////////////////////jQuery �˻� post
		$("button:contains('�˻�')").on("click",function(){
		
			fncGetProductList(1);
		})
	
		// No Ŭ���ϸ�? No Ŭ�� event  prodNo������ üũ
		$( "td:nth-child(2)" ).on("click" , function() {
			//Debug..
				//alert( $('input[id=prodNo]').val() );
				alert( $(this).find('input').val()); //$('input[id=prodNo]').val() );
			self.location ="/product/getProduct?prodNo="+$(this).find('input').val();
		
		});
	
		
		$("input[name=searchKeyword]").keyup(function() {

			fncAutoComplete();
		});
		
	
		//productName�۾� ���������� ����	
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
	       <h3>�ǸŻ�ǰ����</h3>
	    </div>
		
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		<div class="row">
			
			 <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
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
		<!-- table ���� �˻� end /////////////////////////////////////-->
	
		 <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">���</th>
            <th align="left">�������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ������">${product.prodName}
			  	<input type="hidden" id="prodNo" name="prodNo" value="${product.prodNo}"/>
			  </td>
			  <td align="left">
			 	 <fmt:formatNumber value="${product.price}" groupingUsed="true"/>
			  </td>
			  <td align="left">${product.regDate}</td>
			  <td align="left">${product.quantity}</td>
			  
			  <c:if test="${product.quantity >= 1}">
			  <td align="center">�Ǹ���
			  </c:if>
			  <c:if test="${product.quantity <= 0}">
			  <td align="center">ǰ��
			  </c:if>
			 
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
	
	<!-- PageNavigation Start... -->
	<jsp:include page="../common/productPageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
	

</body>
</html>
