<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="admin.dto.CompanyDTO" %>
<%@ page import="admin.dao.CompanyDAO" %>
    
<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="company" align="center">
<%@ include file="../adminAside.jsp" %>

<%
CompanyDAO dao = new CompanyDAO();
CompanyDTO dto = dao.getCompany();

%>

<main>
<title>회사정보수정</title>
<center>
<h1>회사정보 수정</h1>
<form name="companyInfo" action="companyPro.jsp" method="post">
<table border=1 width="700" cellpadding="7">

<%--고객지원--%>
	<tr> <td colspan="2" bgcolor="lightgray"><b>고객지원<b/></td></tr>
	<tr>
	<%--회사이메일--%>
		<td align="center" width="150">회사이메일</td>
		<td width="600" >
			<textarea name="companyMail" rows="2" cols="60"><%=dto.getCompanyMail() %></textarea>
		</td>
	</tr>
	<tr>
	<%--회사번호--%>
		<td align="center" width="150">회사번호</td>
		<td>
			<textarea name="companyNumber" rows="2" cols="60"><%=dto.getCompanyNumber() %></textarea>
		</td>
	</tr>
	<tr>
	<%--업무시간--%>
		<td align="center" width="150">업무시간</td>
		<td>
			<textarea name="businessHour" rows="2" cols="60"><%=dto.getBusinessHour() %></textarea>
		</td>
	</tr>
	<tr>
	<%--휴무일--%>
		<td align="center" width="150">휴무일</td>
		<td>
			<textarea name="closedDays" rows="2" cols="60"><%=dto.getClosedDays() %></textarea>
		</td>
	</tr>
	
<%--반품/교환--%>
	<tr> <td colspan="2" bgcolor="lightgray"><b>반품/교환<b/></td></tr>
	<tr>
	<%--회사주소--%>
		<td align="center" width="150">회사주소</td>
		<td>
			<textarea name="companyAddress" rows="2" cols="60"><%=dto.getCompanyAddress() %></textarea>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value=" 수 정 "/>
		</td>
	</tr>
	

</table>
</form>
</center>
</main>

</div>