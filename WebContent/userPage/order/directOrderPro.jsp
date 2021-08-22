<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "user.dao.CartDAO" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    
    <script type="text/javascript">
	function st(){
		alert("상품 수량이 부족합니다.");
		history.go(-1);
	}
    </script>
    
    <jsp:useBean id="dto" class="user.dto.CartDTO" />
    <jsp:setProperty property="*" name="dto" />
    
    <%
    	CartDAO dao = new CartDAO();
    	String pdCode = request.getParameter("productCode");
    	String color = request.getParameter("color");
    	String size = request.getParameter("size");
    	String id = request.getParameter("id");
    	String qty = request.getParameter("pdQuantity");
    
    	int stock = 0;
    	stock = dao.stockCheck(pdCode, color, size);
    	if(stock < dto.getPdQuantity()){
    		%><script>st();</script><%
    	}else{
        	response.sendRedirect("/badgudu/userPage/order/cartorderForm.jsp?id="+id+"&productCode="+pdCode+"&size="+size+"&color="+color+"&pdQuantity="+qty);
    	}
    %>
    