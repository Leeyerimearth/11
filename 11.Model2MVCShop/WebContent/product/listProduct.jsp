<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	
	// commonUtil을 안쓰니까, 밑에서 empty(!=null) 처리 해줘야함
%>

--%>

<html>
<head>
<title>상품 목록조회</title>

<meta charset="EUC-KR">

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script type="text/javascript">
	
	//var dialogProdNo = null; 일단 전역쓰면 안댄다

	function fncGetProductList(currentPage) {

		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action",
				"/product/listProduct?menu=search").submit();

		// jQuery로 수정!
		//document.getElementById("currentPage").value = currentPage;
		//document.detailForm.submit();
	}

	function fncAutoComplete() {

		$.ajax({

			url : "/common/json/autocomplete",
			method : "POST",
			headers : { // 보내는거 json
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({ //보내는 data jsonString 화
				table : "product",
				searchKeyword : $("input[name=searchKeyword]").val(),
				searchCondition : $("select[name=searchCondition]").val()
			}),
			dataType : "text",
			success : function(serverData, status) {

				var array = JSON.parse(serverData);

				//alert(array);
				$("input#auto").autocomplete({
					source : array
				});

			}

		});

	}

	function readProduct() {
		
		//alert("readProduct 실행되냐?")
		//alert( $("#dialogProdNo").val() );
		self.location = "/product/getProduct?prodNo="+$("#dialogImage").val(); //prod_no
	}
	function purchaseProduct() {

		self.location = "/purchase/addPurchase?prodNo="+$("#dialogImage").val(); //prod_no
	}

	$(function() {

		///////////////////////jQuery 검색 post
		$(".ct_btn01:contains('검색')").on("click", function() {

			fncGetProductList(1);
		})

		///////////////////////////////////////////////////dialog
		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 400,
			width : 350,
			modal : true,
			buttons : {
				"제품상세보기" : function() {
					//alert("제품상세보기");
					dialog.dialog("close");
					//alert("제품상세보기2");
					readProduct(); // 제품상세보기 page
				},
				"구매" : function() {
					dialog.dialog("close");
					purchaseProduct();
				}
			},
			close : function() {
				form[0].reset();
				dialog.dialog("close");
			}

		});

		form = dialog.find("form").on("submit", function(event) {
			event.preventDefault();

			//addUser();
		});

		// No 클릭하면? No 클릭 event  prodNo보내기 체크
		$(".ct_list_pop td:nth-child(3)")
				.on(
						"click",
						function() {
							//Debug..
							alert($(this).find('input').val());
							///////////////////////classic web에서 ajax web으로 변경
							//self.location ="/product/getProduct?prodNo="+$(this).find('input').val(); //prod_no

							$.ajax({

										url : "/product/json/getProduct/"
												+ $(this).find('input').val(),
										method : "GET",
										dataType : "text",
										success : function(serverData, status) {
											//alert(status);
											//alert(serverData);

											var JSONData = $
													.parseJSON(serverData); // json 객체로 변경			

											// 밑에 다이얼로그 소스를 받아온 이미지Set

											var displayValue = "<img src = \"/images/uploadFiles/"+JSONData.fileName+"\"/>";
											
											//alert(JSONData.fileName);
											//alert(displayValue);

											//function에서도 사용할수있는 prodNo지정
											$("#dialogImage").val(JSONData.prodNo); //dialog에 현재 클릭한 상품 prodNo 셋팅
											//alert($("#dialogImage").val());

											$("#dialogImage").html(displayValue); //dialog 이미지태그 넣기

											dialog.dialog("open");
										}

									});

						});

		///////////////////////////////////////////////////////////////////////
		$("#before").on("click", function() {

			fncGetUserList('${ resultPage.currentPage-1}');
		})

		$("#after").on("click", function() {

			fncGetUserList('${resultPage.endUnitPage+1}');
		})

		$("input[name=searchKeyword]").keyup(function() {

			fncAutoComplete();
		});

		$("#highPrice").click(function() {

			alert("highPrice");
			fncGetProductList(1);
		});

		$("#lowPrice").click(function() {

			alert("lowPrice");
			fncGetProductList(1);
		})

		////////////////////////////////////////////////////////////////////////////
		//productName글씨 빨간색으로 변경	
		$(".ct_list_pop td:nth-child(3)").css("color", "red");
		$("h7").css("color", "red");

		//==> 아래와 같이 정의한 이유는 ??
		//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
		$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		console.log($(".ct_list_pop:nth-child(4)").html()); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 

	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<!--  dialog form -->
	<div id="dialog-form" title="이미지 미리보기">
		<form>
			<fieldset id="dialogImage" value="">
				
				<!-- 여기에 .html() 해주기 
				<label for="title" id=""> .text() 해주기</label> 	
				Allow form submission with keyboard without duplicating the dialog button 
				<input type="submit" tabindex="-1" style="position: absolute; top: -1000px"> -->
			</fieldset>
		</form>
	</div>




	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">상품 목록조회</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>

					<td align="left"><select name="orderCondition"
						class="ct_input_g" style="width: 100px">
							<option value="0" id="default"
								${!empty search.orderCondition && search.orderCondition==0 ? "selected" : "" }>--정렬--</option>
							<option value="1" id="highPrice"
								${!empty search.orderCondition && search.orderCondition==1 ? "selected" : "" }>가격높은순</option>
							<option value="2" id="lowPrice"
								${!empty search.orderCondition && search.orderCondition==2 ? "selected" : "" }>가격낮은순</option>

					</select></td>

					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<%--
					<option value="0" <%=(searchCondition.equals("0")? "selected" : "") %>>상품번호</option>
					<option value="1"<%=(searchCondition.equals("1")? "selected" : "" ) %>>상품명</option>
					<option value="2"<%=(searchCondition.equals("2")? "selected" : "") %>>상품가격</option>
					--%>
							<option value="0"
								${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
							<option value="1"
								${!empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
							<option value="2"
								${!empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select> <input type="text" name="searchKeyword"
						value="${!empty search.searchKeyword ? search.searchKeyword : "
						" }"
				    	id="auto" class="ct_input_g"
						style="width: 200px; height: 19px"></td>

					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;">
									<!-- 
						///////////////////////////////////////////////////////////////////////////////
						<a href="javascript:fncGetProductList('1');">검색</a>
						//////////////////////////////////////////////////////////////////////////////////////
						 --> 검색
								</td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount} 건수 , 현재
						${resultPage.currentPage} 페이지</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>

					<!-- /////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////클릭가능///////////////////////////////////
		////////////////////////////////////////////////////////////////////// -->
					<td class="ct_list_b" width="150">상품명<br> <h7>(상품명
						click:상세정보)</h7>
					</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">상품상세정보</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				<%--//////////////////////////////////////////////////////////////
	<% 	
		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center"><%=i+1 %></td>
		<td></td>
				<td align="left"><a href="/getProduct.do?prodNo=<%= vo.getProdNo() %>"><%=vo.getProdName() %></a>
		</td>
		<td></td>
		<td align="left"><%=vo.getPrice() %></td>
		<td></td>
		<td align="left"><%=vo.getRegDate() %></td>
		<td></td>
		<td align="left"><%= vo.getProTranCode() %>
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	<% } %>	
	 --%>
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						<td align="center">${i}</td>
						<td></td>
						<td align="left"><input type="hidden" id="prodNo"
							name="prodNo" value="${product.prodNo}" /> <!-- <a href="/product/getProduct?prodNo=${product.prodNo}">${product.prodName}</a>-->
							${product.prodName}</td>
						<td></td>
						<td align="left"><fmt:formatNumber value="${product.price}"
								groupingUsed="true" /></td>
						<td></td>
						<td align="left">${product.prodDetail}</td>
						<td></td>
						<td align="left"><c:if test="${product.quantity==0}">
				품절
			</c:if> <c:if test="${product.quantity!=0 }">
				판매중
			</c:if></td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> <jsp:include
							page="../common/productPageNavigator.jsp" /></td>
				</tr>
			</table>
			<!--  페이지 Navigator 끝 -->

		</form>

	</div>
</body>
</html>
