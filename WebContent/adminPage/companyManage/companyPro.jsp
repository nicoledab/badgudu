<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.dao.CompanyDAO" %>
<%@ page import="admin.dto.CompanyDTO" %>

<%

	request.setCharacterEncoding("UTF-8");

	String companyMail = request.getParameter("companyMail");
	String companyNumber = request.getParameter("companyNumber");
	String businessHour = request.getParameter("businessHour");
	String closedDays = request.getParameter("closedDays");
	String companyAddress = request.getParameter("companyAddress");
	
	CompanyDTO dto = new CompanyDTO();
	dto.setCompanyMail(companyMail);
	dto.setCompanyNumber(companyNumber);
	dto.setBusinessHour(businessHour);
	dto.setClosedDays(closedDays);
	dto.setCompanyAddress(companyAddress);
	
	CompanyDAO dao = new CompanyDAO();
	dao.companyUpdate(dto);
	
%>

<script>
	alert("수정되었습니다.");
	history.go(-1);
</script>