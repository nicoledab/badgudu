<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>	<!--  -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>	<!-- 덮어씌우기 방지 -->
<%@ page import="user.dto.noticeDTO" %>
<%@ page import="user.dao.noticeDAO" %>

<!-- 파일을 업로드하기 위해서는 멀티파트가 필요하며,
	WEB-INF 폴더 -- lib 폴더 안에 cos.jar과 ojd.jar 가 필요하다
 -->
    <%
    	
    	// notice에 img폴더 생성 후 이쪽으로 경로 지정
    	String path = request.getRealPath("/userPage/csBoard/notice/img");	// 업로드 파일 저장 경로
    	String enc = "UTF-8"; // 인코딩
    	int size = 1024*1034*10; // 업로드 최대 크기(10MB)
    	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();	 // 덮어씌우기 방지.. 중복된 이름일 경우 뒤에 숫자가 늘어남	
    	MultipartRequest mr = new MultipartRequest(request, path, size, enc, dp); //업로드 진행
    	
    	
    	String subject = mr.getParameter("subject");
    	String content = mr.getParameter("content");
    	String save = mr.getFilesystemName("save");	// 파일명을 꺼낸다는 내용.. 
    	
    	noticeDTO dto = new noticeDTO();
    	dto.setSave(save);
    	dto.setSubject(subject);
    	dto.setContent(content);

    	noticeDAO dao = new noticeDAO();
    	dao.insertBoard(dto);
    %>
    
    <script>
		alert("작성 되었습니다..");
		window.location="notice.jsp";
	</script>



