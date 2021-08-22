<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../../top.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">
<jsp:include page="Header.jsp"/>

<main>
<html>
<head>
<title> 공지사항 작성 </title>	
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
	
<body>  
<center><b>공지사항 작성</b>
<br>
<form action="writePro.jsp" method="post" enctype="multipart/form-data">
	<table  class="table table-bordered">
	<tr>
	<td  width="70"  align="center" >제 목</td>
	<td align="left" width="330">
		<input type="text" name="subject"/>
	</tr> 
	<tr>
	<td  width="70"  align="center" >내 용</td>
    <td align="left" width="330">
    <textarea rows="10" cols="40" name="content"></textarea>
    </td>
    <tr>
	<td  width="70"  align="center" >첨부파일</td>
	<td align="left" width="330">
		<input type="file" name="save"/> <br>
	</tr> 
	<td colspan=2 align="center">
			<input type="submit" value="등록"/>
			<input type="button" value="취소" onclick="history.go(-1)">
	</td>
</table>
</form>
</center>
</body>
</html>
</main>
</div>

