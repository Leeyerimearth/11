<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%--
<%@ page import ="com.model2.mvc.service.domain.Product" %>
<%@ page import ="com.model2.mvc.service.domain.User" %>

<%
	Product product = (Product)session.getAttribute("vo");
	User user = (User)session.getAttribute("user");
%>

 --%>
 
<html>
<head>
<title>Insert title here</title>
</head>

<body>

<form name="updatePurchase" action="/purchase/updatePurchase?tranNo=0" method="post"> <!--  �ʿ� ���� �Ⱦ�. -->

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>���� ��ǰ</td>
		<td>${sessionScope.vo.prodName}</td>
		<td></td>
	</tr>
	<tr>
		<td>���� ����</td>
		<td>${param.buyQuantity}</td>
		<td></td>
	</tr>
	<tr>
		<td>�� ���Ű���</td>
		<td>${(param.buyQuantity)*(sessionScope.vo.price)-(param.usePoint)}</td>
		<td></td>
	</tr>
	
	<tr>
		<td>�����ھ��̵�</td>
		<td>${user.userId}</td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
		<c:if test="${param.paymentOption=='1'}">
			���ݱ���
		</c:if>
		<c:if test="${param.paymentOption=='2'}">
			�ſ뱸��
		</c:if>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${param.receiverName}</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${param.receiverPhone}</td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${param.divyAddr}</td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${param.divyRequest}</td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${param.divyDate}</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>