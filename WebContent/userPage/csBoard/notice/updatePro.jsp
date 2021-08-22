<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>	<!--  -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>	<!-- 덮어씌우기 방지 -->
<%@ page import="user.dto.noticeDTO" %>
<%@ page import="user.dao.noticeDAO" %>


    <%
		int num = Integer.parseInt(request.getParameter("num")); // 글번호 받기 위함
    	
    	// notice에 img폴더 생성 후 이쪽으로 경로 지정
    	String path = request.getRealPath("/userPage/csBoard/notice/img");	// 업로드 파일 저장 경로
    	String enc = "UTF-8"; // 인코딩
    	int size = 1024*1034*10; // 업로드 최대 크기(10MB)
    	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();	 // 덮어씌우기 방지.. 중복된 이름일 경우 뒤에 숫자가 늘어남	
    	MultipartRequest mr = new MultipartRequest(request, path, size, enc, dp); //업로드 진행
    	
    	
    	String subject = mr.getParameter("subject");
    	String content = mr.getParameter("content");
    	String orgsave = mr.getParameter("orgsave"); // 기존 첨부파일
    	String save = mr.getFilesystemName("save");	// 파일명을 꺼낸다는 내용..
    	if(save == null){		// 등록한 파일이 없는 경우 기존의 파일을 갖고온다.
    		save = orgsave;
    		if(orgsave.equals("null")){	// 기존 파일이 없을 경우 orgsave가 문자열 null을 같고 와서 if문
    			save = null;
    		}
    	}
    	noticeDTO dto = new noticeDTO();
    	//System.out.println("save = " + save);		// 등록한 파일 확인하기 위함
    	//System.out.println("orgsave = " + orgsave);	// 등록된 파일 확인하기 위함
    	
    	dto.setSave(save);
    	dto.setSubject(subject);
    	dto.setContent(content);
    	
    	noticeDAO dao = new noticeDAO();
    	dao.updateBoard(dto, num);
    %>
    
    <script>
		alert("수정 되었습니다..");
		window.location="notice.jsp";
	</script>



