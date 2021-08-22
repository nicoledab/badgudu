<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="admin.dao.SalesDAO" %>
    <%@ page import="admin.dto.SalesDTO" %>
    <%@ page import = "java.util.*" %>
    <% request.setCharacterEncoding("UTF-8");%>
    <%@ page import = "java.text.SimpleDateFormat" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="ormng" align="center">
<%@ include file="../adminAside.jsp" %>
<title>매출관리</title>

<style>
	.salesTable{
		margin-top : 30px;
	}
	h2{
		margin-top : 50px;	
	}
</style>




<%

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");

SalesDAO dao = new SalesDAO();
int dateCount = dao.dateCount();
int pageSize = 10;
String pageNum = request.getParameter("pageNum");
if(pageNum==null){pageNum="1";}
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

List list = null;
list = dao.dateSales(startRow, endRow);
%>
<center><h2>일별 매출관리</h2></center>    
<table border='1' width='1000' class='salesTable'>
	<tr height='50'>
		<th width='200' align='center' bgcolor='lightgray'>일자</th>
		<th width='200' align='center' bgcolor='lightgray'>매출발생건수</th>
		<th width='200' align='center' bgcolor='lightgray'>취소발생건수</th>
		<th width='200' align='center' bgcolor='lightgray'>실 주문건수</th>
		<th width='200' align='center' bgcolor='lightgray'>매출액</th>
		<th width='200' align='center' bgcolor='lightgray'>매입액</th>
		<th width='200' align='center' bgcolor='lightgray'>영업이익</th>
	</tr> 
	<% if(list==null){
		%><tr height='20'><td colspan='7' align='center'> 주문이 없습니다.</td></tr><%
	}else if(list!=null){
		for(int i = 0; i<list.size(); i++){
			SalesDTO dto = (SalesDTO)list.get(i);
			%><tr align='right' height='40'>
				<td align='center'><a href="dateDetail.jsp?date=<%=dto.getSalesDate() %>" onclick="window.open(this.href, '_blanck','width=1600, height=700'); return false">
				<%=dto.getSalesDate() %></a></td>
				<td align='center'><%=dto.getSalesCount() %>건</td>
				<td align='center'><%=dto.getCancelCount()%>건</td>
				<td align='center'><%=dto.getSalesCount()-dto.getCancelCount()%>건</td>
				<td><%=dto.getSell() %>원</td>
				<td><%=dto.getSupply() %>원</td>
				<td bgcolor='FFFFCC'><b><%=dto.getMargin() %>원</b></td>
				</tr><%
		}
	}
	
	%>
    <tr height='25'><td colspan='7' align='center'><%
				if(dateCount>0){
					int pageCount = dateCount / pageSize + (dateCount%pageSize == 0 ? 0:1);
					
					int startPage = (int)(currentPage/10)*10+1;
					int pageBlock = 10;
					int endPage = startPage+pageBlock-1;
					if (endPage>pageCount) {
						endPage = pageCount;
					}
					if (startPage>10){
						%> <a href="salesManage.jsp?pageNum=<%=startPage-10 %>"> [이전]</a><%
					}
					for(int i = startPage; i <= endPage; i++){
						%> <a href="salesManage.jsp?pageNum=<%=i %>">[<%=i %>]</a><%
					}
					if (endPage<pageCount) {
						%> <a href="salesManage.jsp?pageNum=<%=startPage+10 %>">[다음]</a><%
					}
				}
				%></td></tr>
    
</table>