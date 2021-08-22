<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dao.ProductDAO2" %>
<%@ page import="admin.dto.UpdateDTO" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="pdmng" align="center">
<%@ include file="../adminAside.jsp" %>
<main>
<%
	String id = (String)session.getAttribute("memId"); // id는 세션에서 받아옴
	String pw = request.getParameter("pw");
	String pdCode = (String)request.getParameter("pdCode");
%>

<center>
	<h1>상품 삭제</h1>
	<form action="productDeletePro.jsp" method="post">
		<table border=1 width="300" cellpadding="7">
			<tr>
				<td bgcolor="lightgray" align="center">관리자 권한</td>
			</tr>
			<tr>
				<td align="center">
					<br />
					<input type="hidden" name="pdCode" value="<%=pdCode%>" /><%=pdCode %>번 상품을 삭제합니다. <br />
					비밀번호: <input type="password" name="password" /> <br />
					<br />
				</td>
			</tr>
			<tr>
				<td align="center">
				<input type="submit" value=" 삭 제 " />
				<input type="button" value=" 취 소 " onclick="history.go(-1)" />
				</td>
			</tr>
		</table>
	</form>
</center>
</main>
</div>