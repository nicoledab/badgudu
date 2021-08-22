<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "admin.dao.OrderDAO" %>
<%@ page import = "admin.dto.OrderDetailDTO" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("UTF-8");%>
    
    
<title>주문 상세내역</title>

<%
	String odCode = request.getParameter("odcode");
	//System.out.println(odCode);
	
	
	List orderDetailList = null;
	OrderDAO dbPro = new OrderDAO();
	
	orderDetailList = dbPro.getOrderDetail(Integer.parseInt(odCode));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
%>


<center>
<h1>주문 상세내역</h1>

<table border='1' width='1600'>
	<tr>
		<td width='100' align="center" bgcolor="lightgray"><b>주문번호</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>상품코드</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>주문날짜</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>구매자 ID</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>구매자 연락처</b></td>
		<td width='300' align="center" bgcolor="lightgray"><b>주소</b></td>
		<td width='300' align="center" bgcolor="lightgray"><b>상품명</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>사이즈</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>색상</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>수량</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>판매가</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>합계금액</b></td>
	</tr>
	<%for (int i = 0; i < orderDetailList.size(); i++) {  
		OrderDetailDTO dto = (OrderDetailDTO)orderDetailList.get(i);%>
		<tr height="50">
    	<td align="center" width="100"><%=odCode%></td>						<!-- 주문번호(묶음) -->
    	<td align="center" width="100"><%=dto.getPdCode()%></td>			<!-- 상품코드 -->
    	<td align="center" width="100"><%=sdf.format(dto.getOrderDate())%></td>			<!-- 주문날짜 -->
    	<td align="center" width="100"><%=dto.getUserId()%></td>			<!-- 구매자 ID -->
    	<td align="center" width="100"><%=dto.getPhonenumber()%></td>		<!-- 구매자 연락처 -->
    	<td align="center" width="300"><%=dto.getUserAddr()%></td>			<!-- 주소 -->
    	<td align="center" width="300"><%=dto.getProductName()%></td>		<!-- 상품명 -->
    	<td align="center" width="100"><%=dto.getSizes()%></td>				<!-- 사이즈 -->
    	<td align="center" width="100"><%=dto.getColor()%></td>				<!-- 색상 -->
    	<td align="center" width="100"><%=dto.getPdQuantity()%></td>		<!-- 수량 -->
    	<td align="center" width="100"><%=dto.getSupplyPrice()%></td>		<!-- 판매가 -->
    	<td align="center" width="100"><%=dto.getAmount()%></td>			<!-- 합계금액 -->
    	</tr>
    	</form>
    	<%} %>
</table>
<br/>
<input type="button" value="닫 기" onclick="self.close();" />
</center>