<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">


<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncGetPurchaseList(currentPage) {
		
		$("#currentPage").val(currentPage);
		$('form').attr("method","POST").attr("action","/purchase/listPurchase").submit();
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	
	}
	
	$(function(){
		
		
		$( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
			//Debug..
				//alert( $('input[id=prodNo]').val() );
				alert( $(this).find('input').val()); //$('input[id=prodNo]').val() );
				///purchase/getPurchase?tranNo=${purchase.tranNo}
			self.location ="/purchase/getPurchase?tranNo="+$(this).find('input').val();
		
		});
	
		$( ".ct_list_pop td:contains('���ǵ���')" ).on("click" , function() {
			//Debug..
				
				alert($(this).find("input[id=currentPage1]").val() ); //$('input[id=prodNo]').val() );
				///purchase/updateTranCode?tranNo=${purchase.tranNo}&currentPage=${resultPage.currentPage}
			self.location ="/purchase/updateTranCode?tranNo="+$(this).parent().find("input[id=tranNo]").val()
					+"&currentPage="+$(this).find("input[id=currentPage1]").val();
		
		});
		
		
		$("#before").on("click", function(){
			
			fncGetUserList('${ resultPage.currentPage-1}');
		})
		
		$("#after").on("click", function(){
			
			fncGetUserList('${resultPage.endUnitPage+1}');
		})
		
	
		//1��° ���� No�� ������
		$( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		
		//==> �Ʒ��� ���� ������ ������ ??
		//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
		
		
		
	});
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� ��� ��ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No<br>
			<h7 >(No click:������)</h7> </td>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�� ���Ű���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">���� ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%-- 
	<% 	
		int no=list.size();
		String code =null;
		for(int i=0; i<list.size(); i++) {
			Purchase vo = (Purchase)list.get(i);
			code = vo.getTranCode();
			
			if(code.equals("001"))
				code="�Ǹ���";
			else if(code.equals("002"))
				code="�����";
			else if(code.equals("003"))
				code="��ۿϷ�";
			else if(code.equals("004"))
				code="���ſϷ�";
	%>
	--%>
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items ="${list}">
		<c:set var="i" value="${i+1}"/>
		<tr class="ct_list_pop">
		<td align="center">
			<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo}"/>
			<!-- ///////////////////////////////////////////////////////////////////////
			<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${i}</a>
			//////////////////////////////////////////////////////////////////////////////
			-->
			${i}
		</td>
		<td></td>
		<td align="left">
			<%-- <a href="/getUser.do?userId=${user.userId}">${user.userId}</a>--%>
			${purchase.purchaseProd.prodName}
		</td>
		<td></td>
		<td align="left">
		<fmt:formatNumber value="${purchase.purchaseProd.price}" groupingUsed="true"/>
		</td>
		<td></td>
		<td align="left">${purchase.buyQuantity}</td>
		<td></td>
		<td align="left">${purchase.orderDate}</td>
		<td></td>
		<td align="left">
		<c:if test="${purchase.tranCode=='001'}">
			�Ǹ���
		</c:if>
		<c:if test="${purchase.tranCode=='002'}">
			�����		
		
			<input type="hidden" id ="currentPage1" name="currentPage1" value="${resultPage.currentPage}"/>
			<!-- 
			<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&currentPage=${resultPage.currentPage}">���ǵ���</a>
			-->
			���ǵ���
		</c:if>
		<c:if test="${purchase.tranCode=='003'}">
			��ۿϷ�
		</c:if>
		<c:if test="${purchase.tranCode=='004'}">
			���ſϷ�
		</c:if>
		<c:if test="${purchase.tranCode=='005'}">
			�������
		</c:if>
		</td>
		<td></td>
		<%--
		<td align="left">
			<%
				if(code.equals("�����")){
			%>
			<a href="/updateTranCode.do?prodNo=<%=vo.getPurchaseProd().getProdNo() %>">���ǵ���</a>
			<%} %>
		</td>
		--%>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<%--<%} %> --%>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			 	<jsp:include page="../common/purchasePageNavigator.jsp"/>
			
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>