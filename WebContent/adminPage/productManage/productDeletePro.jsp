<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="admin.dao.ProductDAO2" %>

<%
	String id = (String)session.getAttribute("memId"); // id는 세션에서 받아옴
	String password = request.getParameter("password"); // listDelete 입력한 비밀번호
	int pdCode = Integer.parseInt(request.getParameter("pdCode"));
	
	ProductDAO2 dao = new ProductDAO2();
	boolean product = dao.productDelete(id, password, pdCode);
	boolean stock = dao.stockDelete(id, password, pdCode);
	boolean pdImage = dao.pdImageDelete(id, password, pdCode);
	
	if(product&&stock&&pdImage){%>
	<script>
		alert("삭제되었습니다.");
		window.location="productListBoard.jsp";
	</script>
	<%}else{%>
		<script>
			alert("잘못된 비밀번호입니다.");
			history.go(-1);
		</script>
<%}%>