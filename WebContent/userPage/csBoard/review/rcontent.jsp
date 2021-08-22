<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dto.ReviewBoardDTO" %>
<%@page import="user.dao.ReviewBoardDAO" %>
<%@page import="java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%@ include file ="../../top.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">


<main>
<html>
<head>
<title> review </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
<jsp:include page="Header.jsp"/> 
</head>
<h1> 상품후기 </h1>

<%  


 	//해당 게시글의 넘버/ ex= http://localhost:8080~content.jsp?num=3
	int num = Integer.parseInt(request.getParameter("num"));
String pageNum= request.getParameter("pageNum");

	// 해당 글의 조회수 1증가
	// 글번호에 맞는 내용을 DB에서 가져온다. 
	//readcount , getContent 호출
	ReviewBoardDAO dao = new ReviewBoardDAO();
	
	dao.readCount(num);
	ReviewBoardDTO dto = dao.getContent(num);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	
	String id = (String)session.getAttribute("memId");
	int status = 0;	// 로그인이 아닌경우 status =  0
	Object obj = session.getAttribute("memSt");	// 로그인인 경우 status를 obj라는 이름으로 가져옴 
	// System.out.println(obj); 입력받은 status 확인
	if(id == null || obj == null)	// id 혹은 status가 입력되지 않은경우. 즉, 비회원
	{
		//id = "GUEST";
		// System.out.println("status = " + status); 입력받은 status 확인
	}
	else
	{
		status = (int)obj; // status를 obj(받아온 status) 재설정
	}
		


%>






<br>
<table width="500" border="1" cellspacing="0" cellpadding="0"   align="center" class="table table-striped">  
	<tr height="30">
		<td align="center" width="125" >글번호</td>
		<td align="center" width="125" align="center"><%=dto.getNum()%></td>
	    <td align="center" width="125" >조회수</td>
	    <td align="center" width="125" align="center"><%=dto.getReadcount()%></td>
  </tr>
  <tr height="30">
	    <td align="center" width="125" >작성자</td>
	    <td align="center" width="125" align="center"><%=dto.getWriter()%></td>
	    <td align="center" width="125"  >작성일</td>
	    <td align="center" width="125" align="center"><%= sdf.format(dto.getReg_date())%></td>
  </tr>
  <tr height="30">
		<td align="center" width="125" >상품명</td>
		<td align="center" width="375" align="center" colspan="3"><%=dto.getSubject()%></td>
  </tr>
  <tr>
	    <td align="center" width="125" >글내용</td>
	    <td align="left" width="375" colspan="3"><%=dto.getContent()%>  <br /><br />
	   <%--  
	    <img src="${pageContext.request.contextPath}\서버 저장 폴더이름 \<%=dto.getSave()%>" width="270" height="270"/>
	    <img src="${pageContext.request.contextPath}\C:\Users\Nicole Jung\eclipse-workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\badgudu\csBoard\review\savePic\<%=dto.getSave()%>" width="270" height="270"/>
	
	 <%=dto.getSave() %></pre></td>
	 --%>
	 
	 	<% if(dto.getSave() != null){ %>
	    <img src="${pageContext.request.contextPath}\csBoard\review\savePic\<%=dto.getSave()%>" width="auto" height="auto"/>
	    <%} %>
	    </td>
	   
  </tr>
	   
  <%-- 
    <tr>
	    <td align="center" width="125" >사진 </td>
	    <td align="left" width="375" colspan="3"><pre><%=dto.getSave() %></pre></td>
  </tr>--%>
  <tr height="30">      
	    <td colspan="4"  align="right" > 
		
		<%  //if(id == null || obj == null)	
		if(id != null) { 
		      if(id.equals(dto.getWriter())){ %>
			<input type="button" value="수정"  onclick="window.location='rupdateForm.jsp?num=<%=dto.getNum()%>&writer=<%=dto.getWriter()%>&subject=<%=dto.getSubject()%>&content=<%=dto.getContent()%>'" />
	    <%--  --%>  <input type="button" value="삭제" onclick="window.location='rdeleteForm.jsp?num=<%=dto.getNum()%>'" />
		 
		
		<%}%>
	<%}
		
		if(status == 10){%>	
	<input type="button" value="삭제" onclick="window.location='rdeleteForm.jsp?num=<%=dto.getNum()%>'" />
	<%} %>
		
     	<input type="button" value="글목록" onclick="window.location='reviewlist.jsp'" />
     	
     	
     	
	    </td>
  </tr>
</table>
</html>
</main>
</div>


     

     
