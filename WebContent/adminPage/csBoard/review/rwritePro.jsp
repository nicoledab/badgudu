<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "user.dto.ReviewBoardDTO" %>
<%@ page import = "user.dao.ReviewBoardDAO" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>   
<% request.setCharacterEncoding("UTF-8");

String path = request.getRealPath("userPage/csBoard/review/savePic"); //업로드 파일 저장 경로!!!
String enc = "UTF-8"; //한글 인코딩
int size = 1024*1024*10; // 10MB
DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
MultipartRequest mr = new MultipartRequest(request,path,size,enc,dp);
    // 업로드 진행

// int num = Integer.parseInt(mr.getParameter("num"));   
    
    
String writer = mr.getParameter("writer");    
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	String save = mr.getFilesystemName("save"); //파일명이 아닌 이름으로 받기 !!! name=''
	ReviewBoardDTO dto = new ReviewBoardDTO();
	//dto.setNum(num);

	dto.setWriter(writer);
	dto.setSave(save);
	dto.setSubject(subject);
	dto.setContent(content);
	
	ReviewBoardDAO dao = new ReviewBoardDAO();
   
	//ReviewBoardDAO dao = new ReviewBoardDAO(); //dao 호출! 
	dao.insertreviewBoard(dto);

   response.sendRedirect("reviewlist.jsp");
%>

