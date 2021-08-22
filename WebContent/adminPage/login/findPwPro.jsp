<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "user.dao.MemberDAO" %>
    
<h1>findPwPro</h1>

<%
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	
	MemberDAO dao = new MemberDAO();
	
	String pw = dao.findpw(name, id);
	if (pw=="") {
		%>이름 또는 아이디를 잘못 입력했습니다. <% 
	}else{
		%> <%=name%> 님의 아이디는 <%=pw%> 입니다. <%
	}%>
	