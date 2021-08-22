<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.dao.MemberDAO" %>
    
<h1>findIdPro</h1>

<%
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	
	MemberDAO dao = new MemberDAO();
	
	String id = dao.findid(name, pw);
	if (id==""){
		%>이름 또는 비밀번호를 잘못 입력했습니다. <% 
	}else{
		%> <%=name%> 님의 아이디는 <%=id%> 입니다. <%
	}

%>