<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "user.dao.CartDAO" %>
    <%@ page import = "user.dto.CartDTO" %>
 	<% request.setCharacterEncoding("UTF-8"); %>
  
 <%
 	CartDAO dao = new CartDAO();
 	String cartNum = request.getParameter("cart_no");
 	int cart_no = Integer.parseInt(cartNum);
 	
 	dao.cartQtyUp(cart_no);
 	response.sendRedirect("cartorderForm.jsp");
 	
 %>