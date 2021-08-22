<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.dao.UserMenuDAO" %>
    <%@ page import = "user.dto.UserMenuDTO" %>
    <%@ page import = "java.util.*" %>
    <% request.setCharacterEncoding("UTF-8");%>
    
<title>재고 확인</title>

<%
	//상품 코드 받기
	String productCode = request.getParameter("pdCode");
	int pdCode = Integer.parseInt(productCode);
	
	UserMenuDAO dao = new UserMenuDAO();
	ArrayList<UserMenuDTO> stockList = dao.getStock(pdCode);
	String stockStatus="";
%>


<center>
<h1> 재고 확인</h1>

<table border='1' width='300'>
	<tr>
		<td width='100' align="center" bgcolor="lightgray"><b>사이즈</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>색상</b></td>
		<td width='100' align="center" bgcolor="lightgray"><b>재고수량</b></td>
	</tr>
<%
	for(int i=0; i<stockList.size(); i++){
		UserMenuDTO dto = stockList.get(i);
		if(dto.getRemainQuant()>=1){
			stockStatus="배송 가능";
		} else{
			stockStatus="품절";
		}
		%><tr>
			<td align="center"><%=dto.getSize() %></td>
			<td align="center"><%=dto.getColor() %></td>
			<td align="center"><%=stockStatus %></td>
		</tr><%
	}
%>
</table>
<br/>
<input type="button" value="닫 기" onclick="self.close();" />
</center>