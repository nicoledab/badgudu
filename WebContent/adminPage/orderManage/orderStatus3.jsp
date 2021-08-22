<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dto.OrderDetailDTO" %>
<%@ page import="admin.dao.OrderDAO" %>    
<% request.setCharacterEncoding("UTF-8");%>

<!-- 송장번호 수정을 위한 페이지 -->
<%
	int odCode = Integer.parseInt(request.getParameter("odcode"));
	String invoice = request.getParameter("invoiceUp");
	String pageNum = request.getParameter("pageNum");
	//System.out.println(odCode);
	
	OrderDetailDTO dto = new OrderDetailDTO();
	dto.setOdCode(odCode);
	dto.setInvoice(invoice);
	
	OrderDAO dao = new OrderDAO();
	dao.updateOrder2(dto); // 송장번호 수정 쿼리짜야함
%>

  	<script>
    		 	alert("송장번호 수정되었습니다.");
    		 	window.location="orderList.jsp?pageNum=<%=pageNum%>";
    </script>
