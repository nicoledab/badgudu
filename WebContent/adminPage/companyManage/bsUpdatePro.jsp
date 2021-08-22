<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="admin.dto.BsDTO" %>
<%@ page import="admin.dao.BsDAO" %>    

<%
	String path = request.getRealPath("productImg");
	String enc="UTF-8";
	int max = 1024*1024*10;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp); 
	

	String content = mr.getParameter("content");
	String img = mr.getFilesystemName("img");
	
	BsDTO dto = new BsDTO();
	dto.setContent(content);
	dto.setImg(img);
	
	BsDAO dao = new BsDAO();
	dao.updateBs(dto);
%>
	<script>
		alert("수정되었습니다.");
		window.location="bsUpdate.jsp";
	</script>