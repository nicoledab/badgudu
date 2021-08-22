<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "user.dao.noticeDAO" %>
<%@ page import = "user.dto.noticeDTO" %>

<%
	int num = Integer.parseInt(request.getParameter("num")); // 글번호 받기 위함
	// 글번호에 해당하는 DB 삭제 후 리스트로 이동
	noticeDAO dao = new noticeDAO();
	dao.deleteBoard(num);
%>
	<script>
		alert("삭제 완료");
		window.location="notice.jsp";
	</script>