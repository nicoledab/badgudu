<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.dao.myPageDAO" %>    

<h1>updatePro</h1>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto"  class="user.dto.MemberDTO" />
<jsp:setProperty property="*" name="dto"/>
<%
	String id = (String)session.getAttribute("memId"); // 세션 ID 
	dto.setId(id);
	myPageDAO dao = new myPageDAO();
	dao.changePw(dto);
%>
<script>
	alert("수정되었습니다..");
	window.location="myPageMain.jsp";
</script>


