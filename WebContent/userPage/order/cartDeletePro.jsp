<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "user.dao.CartDAO" %>
    <%@ page import = "user.dto.CartDTO" %>
 	<% request.setCharacterEncoding("UTF-8"); %>
 	
  	<script>
  	function check(){
  		opener.location.href="cartView.jsp";
  		self.close();
  	}
  	</script>
  	
  	<center>
  	삭제되었습니다.
  	<br/><br/>
  	<input type="button" onclick="check();" value="확인"/>
  	</center>
  	
 <%
 	CartDAO dao = new CartDAO();
 
 	String deleteCart = request.getParameter("deleteCart");
 	System.out.println(deleteCart);
 	String [] delete = deleteCart.split(",");
 	
 	
 	for(String c : delete){
 		dao.cartDelete(Integer.parseInt(c));
 	}
 
 	
 %>