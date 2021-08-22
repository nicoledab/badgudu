<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "admin.dao.SalesDAO" %>
    <%@ page import = "admin.dto.SalesDTO" %>

    <% request.setCharacterEncoding("UTF-8");%>
    
    <%
    String date = request.getParameter("date");
   	
    SalesDAO dao = new SalesDAO();
    int dateCount = dao.datePartCount(date);
    int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    if(pageNum==null){pageNum="1";}
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    
    
    List dateDetail = null;
   	dateDetail = dao.datePartSales(date, startRow, endRow);
    
    %>
    
    
    
    
    <title><%=date %> 주문내역</title>
    <center>
    <h2><%=date %> 주문내역</h2>
    
    <table border='1' width='1200'>
    	<tr>
    		<td width='50' align="center" bgcolor="lightgray">주문번호</td>
    		<td width='100' align="center" bgcolor="lightgray">구매자ID</td>
    		<td width='200' align="center" bgcolor="lightgray">상품이름</td>
    		<td width='100' align="center" bgcolor="lightgray">주문금액</td>
    		<td width='100' align="center" bgcolor="lightgray">전화번호</td>
    		<td width='150' align="center" bgcolor="lightgray">배송지</td>
    		<td width='100' align="center" bgcolor="lightgray">결제수단</td>
    		<td width='100' align="center" bgcolor="lightgray">송장번호</td>
    		<td width='100' align="center" bgcolor="lightgray">주문상태</td>
    	</tr>
    	<%for (int i = 0; i<dateDetail.size(); i++){
    		SalesDTO dto = (SalesDTO)dateDetail.get(i);
    		%><tr height='40'>
    		<td align="center"><%=dto.getOdcode()%></td>
    		<td align="center"><%=dto.getUserId()%></td>
    		<td align="center"><%=dto.getProductName()%></td>
    		<td align="right"><%=dto.getAmount()%></td>
    		<td align="center"><%=dto.getPhonenumber()%></td>
    		<td align="center"><%=dto.getUserAddr()%></td>
    		<td align="center"><%=dto.getPaymethod()%></td>
    		<td align="center"><%=dto.getInvoice()%></td>
    		<td align="center"><%=dto.getOrderstatus()%></td>
    		</tr><%
    	}%>
    	
    	<tr height='25'><td colspan='9' align='center'><%
				if(dateCount>0){
					int pageCount = dateCount / pageSize + (dateCount%pageSize == 0 ? 0:1);
					
					int startPage = (int)(currentPage/10)*10+1;
					int pageBlock = 10;
					int endPage = startPage+pageBlock-1;
					if (endPage>pageCount) {
						endPage = pageCount;
					}
					if (startPage>10){
						%> <a href="dateDetail.jsp?date=<%=date %>&pageNum=<%=startPage-10 %>"> [이전]</a><%
					}
					for(int i = startPage; i <= endPage; i++){
						%> <a href="dateDetail.jsp?date=<%=date %>&pageNum=<%=i %>">[<%=i %>]</a><%
					}
					if (endPage<pageCount) {
						%> <a href="dateDetail.jsp?date=<%=date %>&pageNum=<%=startPage+10 %>">[다음]</a><%
					}
				}
				%></td></tr>
    
    </table>
    <br />
    <input type="button" value="닫 기" onclick="self.close();" />
    
    </center>