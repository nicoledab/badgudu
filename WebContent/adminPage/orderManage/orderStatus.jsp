<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dto.OrderDetailDTO" %>
<%@ page import="admin.dao.OrderDAO" %>    
<% request.setCharacterEncoding("UTF-8");%>

<!-- 확인 버튼을 눌러 배송준비로 바뀌는 페이지 -->
<%
	int odCode = Integer.parseInt(request.getParameter("odcode"));
	String pageNum = request.getParameter("pageNum");
	//System.out.println(odCode);
	//System.out.println(pageNum);
	
	OrderDetailDTO dto = new OrderDetailDTO();
	dto.setOdCode(odCode);
	
	OrderDAO dao = new OrderDAO();
	dao.updateOrder(dto);
%>

  	<script>
  	function check(){
  		alert("주문확인되었습니다.");
	 	window.location="orderList.jsp?pageNum=<%=pageNum%>";
  	}
    </script>
    <script>check();</script>
