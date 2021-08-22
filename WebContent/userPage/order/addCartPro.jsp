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
    	String pdCode = request.getParameter("pdCode");
    	String color = request.getParameter("color");
    	String size = request.getParameter("size");
    
    	int stock = 0;
    	stock = dao.stockCheck(pdCode, color, size);
    	if(stock < dto.getPdQuantity()){
    		%><script>st();</script><%
    	}else{
    		dao.insertCart(dto);
        	response.sendRedirect("cartView.jsp");
    	}
    %>
    