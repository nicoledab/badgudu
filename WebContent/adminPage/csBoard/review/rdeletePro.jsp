<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dao.ReviewBoardDAO" %>   
<h1>deletepro</h1>


<% 
  int num = Integer.parseInt(request.getParameter("num"));
// 글번호에 해당되는 DB 삭제후 리스트로 이동
  
    ReviewBoardDAO dao = new ReviewBoardDAO();
	dao.deleteBoard(num);
	
%>

 <script>
 	alert("삭제완료");
 	window.location="reviewlist.jsp";
 </script>