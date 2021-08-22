<%@page import="admin.dto.OrderDeleteDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dto.OrderDeleteDTO" %>
<%@ page import="admin.dao.OrderDAO" %>    
<% request.setCharacterEncoding("UTF-8");%>

<!-- 주문 취소 (송장번호랑 다른방법)-->
<%
	int odCode = Integer.parseInt(request.getParameter("odcode"));
	String pageNum = request.getParameter("pageNum");
	//System.out.println(pageNum);
	
	OrderDeleteDTO dto = new OrderDeleteDTO();
	dto.setOdCode(odCode);
	
	OrderDAO dao = new OrderDAO();
	dao.deleteOrder(dto);
	
%>
<script>
		alert("취소되었습니다.");
		window.location="orderList.jsp?pageNum=<%=pageNum%>";
</script>
