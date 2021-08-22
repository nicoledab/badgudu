<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.dto.OrderDetailDTO" %>
    <%@ page import = "user.dao.OrderDetailDAO" %>
    <%@ page import = "user.dto.OrderDTO" %>
    <%@ page import = "user.dao.OrderDAO" %>
    <%@page import="java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%request.setCharacterEncoding("UTF-8");%>
<%
	int count = 0; 
	String id = (String)session.getAttribute("memId");  // 유저ID
	int odcode = Integer.parseInt(request.getParameter("odcode"));
	
  %>  
<title>BAD GUDU</title>

<%	
	
	OrderDetailDAO dbPro = new OrderDetailDAO();

	ArrayList<OrderDetailDTO> list = dbPro.getList(odcode); //주문이 추가되면 계속 추가되기
	count = dbPro.getArticleCount(odcode); //매개변수 바꾸기 
	
	
	
	
	
%>
<%@ include file ="../top.jsp" %>
<div id="main" align="center">
<%@ include file ="../aside.jsp" %>
<link href="orderDetail.css" rel="stylesheet" type="text/css">

<head>
<meta charset="UTF-8">
<title>주문내역조회</title>
</head>

<body>

<br /><br /><br /><h1> 주문 상세 조회 </h1> <br /><br />


<table  cellpadding="80" cellspacing="0" align="center" style=" border:1px solid gray;" height="400" width="900"  > 
<tr bgcolor="ededed">
<th>  주문번호  </th>  <th>  상품 정보 </th> <th>  수량  </th><th>  판매가  </th><th>  지불방법  </th><th>  주문처리상태  </th>
</tr>


<%	for (OrderDetailDTO dto : list) {%>

<tr align="center">
		<td > <%=dto.getOdcode()%></td>
		<td><%=dto.getProductname() %>, <%=dto.getSizes() %> , <%=dto.getColor() %> 
		<% if(dto.getOrderstatus().equals("구매자 취소")||dto.getOrderstatus().equals("판매자 취소")){
			
		} else { %>
			<a href="/badgudu/userPage/csBoard/review/rwriteFromOd.jsp?writer=<%=id %>&pdcode=<%=dto.getPdcode()%>" class="button2" style="float: right; text-decoration: none; font-size: 12px; "  >리뷰 쓰러가기</a>
		<%}	%> 
		</td>
		
		<td><%=dto.getPdQuantity() %> </td>
    	<td><%=dto.getAmount() %></td>
    	<td><%=dto.getPaymethod() %></td>
    	<td ><%=dto.getOrderstatus() %></td>
</tr>

 <%} %>
 
 
<%
OrderDAO dao = new OrderDAO();
%>
<tr>
<th bgcolor="ededed"> 받으시는 분 : </th> <td colspan='3' align="center"><%=id %></td>
</tr>
<tr>
<th bgcolor="ededed"> 연락처 : </th> <td colspan='3' align="center"><%=dao.getOdPhnum(odcode)%></td> <!-- 0518 추가 -->
</tr>
<tr>
<th bgcolor="ededed"> 주소 : </th> <td colspan='3' align="center"><%=dao.getOdAddress(odcode)%></td> <!-- 0518 수정 -->
</tr>
 <tr>
 <th bgcolor="ededed"> 주문날짜 : </th>  <td colspan='3' align="center"><%=dao.getOrderDate(odcode)%> </td>
</tr>
</table>

<br/> <br/> 


</body>


</div>
<br /><br /><br />
<%@ include file="../bottom.jsp" %>
