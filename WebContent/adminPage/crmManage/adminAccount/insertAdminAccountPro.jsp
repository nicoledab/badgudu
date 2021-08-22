<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dao.MemberDAO" %>
   
   
    <h1>SignupPro</h1>

 <%
 request.setCharacterEncoding("UTF-8");
 %>
 
	<jsp:useBean id="dto" class="user.dto.MemberDTO" />
	<jsp:setProperty property ="*" name="dto"/>

<%
	MemberDAO dao= new MemberDAO();
	dao.AdminInsertMember(dto);
	
	response.sendRedirect("crmForm.jsp");
%>

