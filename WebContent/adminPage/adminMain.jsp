<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "admin.dao.adminMainDAO" %>
    <%@ page import = "admin.dao.SalesDAO" %>
    <%@ page import = "admin.dao.ProductDAO2" %>
    <%@ page import = "user.dao.otoBoardDBBean" %>
    <%@ page import = "admin.dto.OrderListDTO" %>
    <%@ page import = "admin.dto.SalesDTO" %>
    <%@ page import = "admin.dto.StockDTO" %>
    <%@ page import = "user.dto.otoBoardDataBean" %>
    <%@ page import = "java.util.*" %>
    <% request.setCharacterEncoding("UTF-8");%>
    
<title>BadGudu 관리자</title>
<link href="adminStyle.css" rel="stylesheet" type="text/css">


<%@ include file="adminTop.jsp" %>

<div class="adminMain" align="center">
<%@ include file="adminAside.jsp" %>
<style>
	.mainTable{
		margin-top : 50px;
	}
	th{
		vertical-align: top;
	}
</style>

<%
	adminMainDAO dao = new adminMainDAO();
	SalesDAO sdao = new SalesDAO();
	ProductDAO2 pdao= new ProductDAO2();
	otoBoardDBBean odao = new otoBoardDBBean();

%>



<main>

<table border='1' width="1200" class='mainTable'>
	<tr height='300'>
		<th width='600' align='center'>
			<table width='520'>
				<tr height='30' >
					<td colspan='5' bgcolor='CCCCFF' align='center'>
						<b>최근 3일 이내 주문내역</b>
					</td>
				</tr>
				<tr>
					<td colspan='3' align='left' style="font-size:10pt;"> 
						최근 주문건수 : <%=dao.getRecentlyOrderCount() %>
					</td>
					<td colspan='2' align='right' style="font-size:10pt;"> 
						<a href="/badgudu/adminPage/orderManage/orderList.jsp">주문목록</a>
					</td>
				</tr>
				<tr height='25'>
					<td width='100' align='center'>판매일자</td>
					<td width='80' align='center'>주문번호</td>
					<td width='120' align='center'>구매자</td>
					<td width='100' align='center'>총 금액</td>
					<td width='120' align='center'>주문상태</td>
				</tr>
				<%
				int orderCount = dao.getRecentlyOrderCount();
				int pageSize = 5;
				String pageNum = request.getParameter("pageNum");
				if(pageNum==null){pageNum="1";}
				int currentPage = Integer.parseInt(pageNum);
				int startRow = (currentPage - 1) * pageSize + 1;
				int endRow = currentPage * pageSize;
				
				List list = null;
				list = dao.getRecentlyOrderList(startRow, endRow);
				
				if(list==null){
					%><tr height='20'><td colspan='5' align='center'> 최근 주문내역이 없습니다.</td></tr><%
				} else if(list!=null){
					
					for(int i=0; i<list.size(); i++){
						OrderListDTO dto = (OrderListDTO)list.get(i);
						%><tr align='center' height='25'>
							<td><%=dto.getOrderDate() %></td>
							<td><a href="/badgudu/adminPage/orderManage/detailCheck.jsp?odcode=<%=dto.getOdcode()%>" onclick="window.open(this.href, '_blanck','width=1600, height=400'); return false">
							<%=dto.getOdcode() %></a></td>
							<td><%=dto.getUserid() %></td>
							<td align='right'><%=dto.getAmount() %></td>
							<td><%=dto.getOrderStatus() %></td>
						</tr><%
					}
				}
				%>
				<tr height='25'><td colspan='5' align='center'><%
				if(orderCount>0){
					int pageCount = orderCount / pageSize + (orderCount%pageSize == 0 ? 0:1);
					
					int startPage = (int)(currentPage/10)*10+1;
					int pageBlock = 10;
					int endPage = startPage+pageBlock-1;
					if (endPage>pageCount) {
						endPage = pageCount;
					}
					if (startPage>10){
						%> <a href="adminMain.jsp?pageNum=<%=startPage-10 %>"> [이전]</a><%
					}
					for(int i = startPage; i <= endPage; i++){
						%> <a href="adminMain.jsp?pageNum=<%=i %>">[<%=i %>]</a><%
					}
					if (endPage<pageCount) {
						%> <a href="adminMain.jsp?pageNum=<%=startPage+10 %>">[다음]</a><%
					}
				}
				%></td></tr>
				
			</table>
		</th>
		
		<th width='600' align='center'>
			<table width='520'>
				<tr height='30'>
					<td colspan='4' bgcolor='CCCCFF' align='center'>
					<b>최근 3일간 매출액</b>
				</tr>
				<tr>
					<td colspan='4' align='right' style="font-size:10pt;">
					<a href="/badgudu/adminPage/orderManage/salesManage.jsp">매출관리</a>
					</td>
				</tr>
				<tr>
				<tr height='30'>
					<td width='150' align='center'>일자</td>
					<td width='150' align='center'>실 주문건수 </td>
					<td width='150' align='center'>매출액 </td>
					<td width='150' align='center'>영업이익</td>
				</tr>
				<%
				List slist = null;
				slist = sdao.recentlyDateOrder();
				int Amount = 0;
				if(slist == null){
					%><tr height='20'><td colspan='4' align='center'> 최근 매출이 없습니다.</td></tr><%
				} else if(slist!=null){
					for(int i =0; i<slist.size(); i++){
						SalesDTO dto = (SalesDTO)slist.get(i);
						Amount += dto.getMargin();
						%> <tr align='center' height='30'>
						<td><a href="/badgudu/adminPage/orderManage/dateDetail.jsp?date=<%=dto.getSalesDate() %>" onclick="window.open(this.href, '_blanck','width=1600, height=700'); return false">
						<%=dto.getSalesDate() %></a></td>
						<td><%=dto.getSalesCount()-dto.getCancelCount()%></td>
						<td align='right'><%=dto.getSell() %></td>
						<td align='right'><%=dto.getMargin() %></td>
						</tr><%
					}
					%><tr height='50'>
					<td colspan ='3' align='right'><b>최근 매출 총 금액</b></td>
					<td align='right'><b><%=Amount %></b></td>
					</tr><%
				}
				%>

			</table>	
		
		
		</th>
	</tr>
	<tr height='300' align='center'>
		<th width='600'>
			<table width='520'>
				<tr height ='30'>
					<td colspan='6' bgcolor='CCCCFF' align='center'>
						<b>재고품절 및 임박</b>
					</td>
				</tr>
				<tr>
					<td colspan='6' align='right' style="font-size:10pt;">
						<a href="/badgudu/adminPage/productManage/produckStock.jsp">재고목록</a>
					</td>
				</tr>
				<tr height='25' align='center'>
					<td width='50'>상품코드</td>
					<td width='150'>상품이름</td>
					<td width='80'>색상</td>
					<td width='80'>사이즈</td>
					<td width='80'>잔여수량</td>
					<td width='100'>상품상태</td>
				</tr>
				<%
				int stockCount = pdao.soldStockCount();
				pageSize = 5;
				String pageNum2 = request.getParameter("pageNum2");
				if(pageNum2==null){pageNum2="1";}
				int currentPage2 = Integer.parseInt(pageNum2);
				int startRow2 = (currentPage2 - 1) * pageSize + 1;
				int endRow2 = currentPage2 * pageSize;
				
				List plist = null;
				plist = pdao.soldStock(startRow2, endRow2);
				
				if(plist==null){
					%><tr height='20'><td colspan='6' align='center'>품절 및 임박 재고가 없습니다.</td></tr><%
				} else if(plist!=null){
					
					for(int i=0; i<plist.size(); i++){
						StockDTO dto = (StockDTO)plist.get(i);
						%><tr align='center' height='25'>
							<td><%=dto.getPdCode() %></td>
							<td><a href="/badgudu/adminPage/productManage/productUpdateForm.jsp?pdCode=<%=dto.getPdCode()%>&pageNum=1">
							<%=dto.getProductName() %></a></td>
							<td><%=dto.getColor() %></td>
							<td align='right'><%=dto.getSize() %></td>
							<td><%=dto.getRemainquant() %></td>
							<td><%if(dto.getRemainquant() < 1){%>
	    		 					<font color="red"><b>품절</b></font>
	    						<%}else if(dto.getRemainquant() <= 10){%>
	    							<font color="FF9900"><b>품절임박</b></font>
	    						<%}else{%>
	    							여유
	    						<%} %></td>
						</tr><%
					}
				}%>
				<tr height='25'><td colspan='6' align='center'><%
				if(stockCount>0){
					int pageCount2 = stockCount / pageSize + (stockCount%pageSize == 0 ? 0:1);
					
					int startPage2 = (int)(currentPage2/10)*10+1;
					int pageBlock2 = 10;
					int endPage2 = startPage2+pageBlock2-1;
					if (endPage2>pageCount2) {
						endPage2 = pageCount2;
					}
					if (startPage2>10){
						%> <a href="adminMain.jsp?pageNum2=<%=startPage2-10 %>"> [이전]</a><%
					}
					for(int i = startPage2; i <= endPage2; i++){
						%> <a href="adminMain.jsp?pageNum2=<%=i %>">[<%=i %>]</a><%
					}
					if (endPage2<pageCount2) {
						%> <a href="adminMain.jsp?pageNum2=<%=startPage2+10 %>">[다음]</a><%
					}
				}
				%></td></tr>
				
			</table>
		
		
		</th>
		<th width='600'>
			<table width='520'>
				<tr height='30'>
					<td colspan='3' bgcolor='CCCCFF' align='center'>
					<b>미답변 1:1문의접수</b>
				</tr>
				<tr>
					<td colspan='2' align='left' style="font-size:10pt;"> 미답변 문의글 수 : <%=odao.nonCheckCount() %>
					<td align='right' style="font-size:10pt;">
						<a href="/badgudu/adminPage/otoManage/otoAdminList.jsp">1:1문의목록</a>
					</td>
				</tr>
				<tr height='25' align='center'>
					<td width='100'>문의일자</td>
					<td width='100'>작성자</td>
					<td width='320'>제목</td>
				</tr>
				<%
				int otoCount = odao.nonCheckCount();
				int pageSize3 = 5;
				String pageNum3 = request.getParameter("pageNum3");
				if(pageNum3==null){pageNum3="1";}
				int currentPage3 = Integer.parseInt(pageNum3);
				int startRow3 = (currentPage3 - 1) * pageSize3 + 1;
				int endRow3 = currentPage3 * pageSize3;
				
				List olist = null;
				olist = odao.nonCheck(startRow3, endRow3);
				
				if(olist==null){
					%><tr height='20'><td colspan='6' align='center'>미답변 문의글이 없습니다.</td></tr><%
				} else if(olist!=null){
					
					for(int i=0; i<olist.size(); i++){
						otoBoardDataBean dto = (otoBoardDataBean)olist.get(i);
						%><tr align='center' height='45'>
							<td><%=dto.getReg_date().toString().substring(0, 10) %></td>
							<td><%=dto.getWriter() %></td>
							<td><a href="/badgudu/adminPage/otoManage/otoAdminContent.jsp?num=<%=dto.getNum() %>&pageNum=1">
							<%=dto.getSubject() %></a></td>
						</tr><%
					}
				}%>
				
				<tr height='25'><td colspan='6' align='center'><%
				if(otoCount>0){
					int pageCount3 = otoCount / pageSize3 + (otoCount%pageSize3 == 0 ? 0:1);
					
					int startPage3 = (int)(currentPage3/10)*10+1;
					int pageBlock3 = 10;
					int endPage3 = startPage3+pageBlock3-1;
					if (endPage3>pageCount3) {
						endPage3 = pageCount3;
					}
					if (startPage3>10){
						%> <a href="adminMain.jsp?pageNum3=<%=startPage3-10 %>"> [이전]</a><%
					}
					for(int i = startPage3; i <= endPage3; i++){
						%> <a href="adminMain.jsp?pageNum3=<%=i %>">[<%=i %>]</a><%
					}
					if (endPage3<pageCount3) {
						%> <a href="adminMain.jsp?pageNum3=<%=startPage3+10 %>">[다음]</a><%
					}
				}
				%></td></tr>
				
			</table>
		
		</th>
	</tr>

</table>


</main>


</div>