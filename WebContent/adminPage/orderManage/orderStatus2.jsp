<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dto.OrderDetailDTO" %>
<%@ page import="admin.dao.OrderDAO" %>    
<% request.setCharacterEncoding("UTF-8");%>

 <!--  송장번호 기입하여 배송중으로 바뀌는 페이지 -->
<%
	int odCode = Integer.parseInt(request.getParameter("odcode"));
	String invoice = request.getParameter("invoice");
	String pageNum = request.getParameter("pageNum");
	//System.out.println(odCode); // 받아오는 odcode 확인
	//System.out.println(invoice); // 받아오는 송장번호 확인
	//System.out.println(pageNum); // 받아오는 페이지번호 확인
	
	OrderDetailDTO dto = new OrderDetailDTO();
	dto.setOdCode(odCode);
	dto.setInvoice(invoice);
	
	OrderDAO dao = new OrderDAO();
	dao.updateOrder2(dto);
%>

  	<script>
    		 	alert("송장번호 기입되었습니다.");
    		 	window.location="orderList.jsp?pageNum=<%=pageNum%>";
    </script>
