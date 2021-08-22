<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dao.OrderDAO" %>   
<%@page import="user.dto.OrderDTO" %>   
<%@page import="user.dto.OrderDetailDTO" %>  
<%@ page import="admin.dto.OrderDeleteDTO" %> 
   <%request.setCharacterEncoding("UTF-8");%>



<% 


int odcode = Integer.parseInt(request.getParameter("odcode")); 
OrderDeleteDTO dto = new OrderDeleteDTO();
dto.setOdCode(odcode);

OrderDAO dao = new OrderDAO();
dao.deleteOrder(dto);
		
//	dao.CancelOrder(odcode); //shoporder db amount -> 0 , 주문상태 -> '판매자취소'&구매자취소 ... 
	
	
	//dao.deleteOrderDetail(dao); //orderdetail 도 삭제 진행
	//dao.ReduceOrder(odcode); // stock 재고 order 삭감, remainquant는 증가- 
	
	
	//dao.ReduceStock(dto);
%>

 <script>
 	alert(" 주문을 일괄 취소했습니다! ");
 	window.location="MyOrderListNew.jsp";
 </script>