<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="admin.dao.ProductDAO2" %>

<%
	String id = (String)session.getAttribute("memId"); // id�� ���ǿ��� �޾ƿ�
	String password = request.getParameter("password"); // listDelete �Է��� ��й�ȣ
	int pdCode = Integer.parseInt(request.getParameter("pdCode"));
	
	ProductDAO2 dao = new ProductDAO2();
	boolean product = dao.productDelete(id, password, pdCode);
	boolean stock = dao.stockDelete(id, password, pdCode);
	boolean pdImage = dao.pdImageDelete(id, password, pdCode);
	
	if(product&&stock&&pdImage){%>
	<script>
		alert("�����Ǿ����ϴ�.");
		window.location="productListBoard.jsp";
	</script>
	<%}else{%>
		<script>
			alert("�߸��� ��й�ȣ�Դϴ�.");
			history.go(-1);
		</script>
<%}%>