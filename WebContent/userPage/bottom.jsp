<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dto.CompanyDTO" %>
<%@ page import="admin.dao.CompanyDAO" %>
<%@ page import = "java.util.*" %>


<%
	CompanyDAO company = new CompanyDAO(); 
	CompanyDTO cccdto = company.getCompany();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="bottom">
 
<center>
 
 
<hr color="888888" size="2"> 
<table width='1200'>
     <%--   <tr> 
        <th> 고객 지원 </th>
         <td> 1111-1111</td>
         <td>카카오톡 문의 </td>
         <td>월-금 9:00~ 17:00</td>
         <td>토,일,공휴일 휴무</td>
        </tr>--%> 
	<tr>
		<td align="center" width='400' style="font-size:16pt"><b>고객지원</b></td>
		<td align="center" width='400' style="font-size:16pt"><b>반품/교환</b></td>
		<td align="center" width='400' style="font-size:16pt"><b>회사</b></td>
	</tr>
	<tr>
		<td rowspan='4' align='center'> <%=cccdto.getCompanyMail() %><br/>
			<%=cccdto.getCompanyNumber() %><br/>
			<%=cccdto.getBusinessHour() %><br/>
			<%=cccdto.getClosedDays() %>
		</td>
		<td rowspan='4' align='center'> <%=cccdto.getCompanyAddress() %><br />
		</td>
	</tr>
	<tr>
		<td align='center'>
			<a href="/badgudu/userPage/bsUser/bsView.jsp">브랜드스토리</a>
		</td>
	</tr>
	<tr>
		<td align='center'>
			<a href="/badgudu/userPage/bsUser/privacy.jsp">개인정보 보호정책</a>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td align="center" colspan='4'>
			<br/>
            이용약관 | 무단수집거부 | COPYRIGHT@2021 BAD GUDU, All rights reserved.
 
        </td>
    </tr>
</table>
</center>
</div>
