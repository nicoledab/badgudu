<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="admin.dao.BsDAO" %>
<%@ page import="admin.dto.BsDTO" %>  
 

<%
	BsDAO dao = new BsDAO();
	BsDTO dto = dao.insertBs();
%>

<%@ include file ="../top.jsp" %>

<div class="myPage" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../aside.jsp" %>

<link href="myPage.css" rel="stylesheet" type="text/css">


<title>브랜드스토리</title>


<form action="bsUpdatePro.jsp" method="post" enctype="multipart/form-data">


<table width="500" border="1" cellspacing="0" cellpadding="0"  align="center"> 
	<tr height="30">	
	   <td align="Center" width="330"> <h1>Brand Stoty</h1> </td>
  <br />
  <tr>
    <td align="left" width="330">
     <%=dto.getContent()%></td>
     <br />
     </tr>
     	 <tr>
	   <td align="center" width="375" colspan="3");><pre> <img height="300" width="300" src="/badgudu/productImg/<%=dto.getImg()%>" /> <br />
 	 </tr>
	 
</table>
</form>
