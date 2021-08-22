<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="admin.dao.BsDAO" %>
<%@ page import="admin.dto.BsDTO" %> 

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="company" align="center">
<%@ include file="../adminAside.jsp" %>  
 

<%
	BsDAO dao = new BsDAO();
	BsDTO dto = dao.insertBs();
%>

<title>브랜드 스토리</title>
<form action="bsUpdatePro.jsp" method="post" enctype="multipart/form-data">



<h1 align="center">Brand Story</h1></td>

<table width="650" border="1" cellspacing="0" cellpadding="0"  align="center"> 
    <tr>
    <td  width="70" align="center" >브랜드 스토리</td>
    <td align="left" width="330">
     <textarea name="content" rows="20" cols="60"><%=dto.getContent()%></textarea></td>
     </tr>
     <br />
         <tr>
	    <td align="center" width="330">이미지파일</td>
	    <td align="left" width="375" colspan="3"><pre>
	    <%if(dto.getImg() == null){ %>
	    <input type="file" name="img" /> 이미지 가 없습니다. <br />
		  <%}else{%>
		  	<img src="/badgudu/productImg/<%=dto.getImg()%>" style="width:250px;"/> <br />
		  	<input type="file" name="img" /><br />
		  <%}%><br />
		  </pre></td>
 	 </tr>
 	   <tr height="30">      
	    <td colspan="4" align="right" > 
		<input type="submit" value="수정" />
		<input type="reset" value="다시작성">
		</tr>
		</table>
</form>
