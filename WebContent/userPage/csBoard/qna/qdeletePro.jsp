<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dao.QnaBoardDAO" %>   

<h1>qna deletepro</h1>


<% 
  int num = Integer.parseInt(request.getParameter("num"));
// 글번호에 해당되는 DB 삭제후 리스트로 이동
  
    QnaBoardDAO dao = new QnaBoardDAO();
	dao.deleteBoard(num);
	
%>

 <script>
 	alert("삭제완료");
 	window.location="qnalist.jsp";
 </script>