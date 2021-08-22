<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "user.dao.CartDAO" %>
    <%@ page import = "user.dto.CartDTO" %>
 	<% request.setCharacterEncoding("UTF-8"); %>
 	
 	
 	<title>상품 삭제</title>
 	<form action="cartDeletePro.jsp" method="post">
 	<center>
  	상품을 장바구니에서 지우시겠습니까?
  	<br /><br />
  	<input type="submit" value="확인" name="check"/>
  	<input type="button" value="취소" name="cancel" onclick="self.close();" />
 	</center>
  	
  	<%
  		String str = "";
  		String [] deleteCart = request.getParameterValues("cart_no");
  		for(String c : deleteCart){
  			str += c+",";
  		}
  	%>
  	<input type="hidden" name="deleteCart" value="<%=str %>" />
 	</form>
