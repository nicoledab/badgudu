 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dto.QnaBoardDTO" %>
<%@page import="user.dao.QnaBoardDAO" %>
<%@page import="java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%@ include file ="../../adminTop.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../adminAside.jsp" %>
<link href="../style.css" rel="stylesheet" type="text/css">


<main>

<html>
<head>
<title> q&a 글쓰기 </title>
<script language="JavaScript" src="script.js"></script>
<jsp:include page="Header.jsp"/> 
</head>
<h1>q&a 글쓰기 </h1>







<% 
request.setCharacterEncoding("UTF-8");
String enc = "UTF-8";
 	//해당 게시글의 넘버/ ex= http://localhost:8080~content.jsp?num=3
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum= request.getParameter("pageNum");

	// 해당 글의 조회수 1증가
	// 글번호에 맞는 내용을 DB에서 가져온다. 
	//readcount , getContent 호출
	QnaBoardDAO dao = new QnaBoardDAO();
	
	
	dao.readCount(num);
	
	QnaBoardDTO dto = dao.getContent(num);
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int ref=dto.getRef();
	int re_step=dto.getRe_step();
	int re_level=dto.getRe_level();
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
	    <td align="center" width="125" align="center"><%=dto.getReg_date() %></td>
  </tr>
  
  <tr height="30">
		<td align="center" width="125" >글제목</td>
		<td align="center" width="375" align="center" colspan="3"><%=dto.getTitle() %></td>
  </tr>
   <tr height="30">
		<td align="center" width="125" >문의 유형 </td>
		<td align="center" width="375" align="center" colspan="3"><%=dto.getSubject()%></td>
  </tr>
  
  <tr>
	    <td align="center" width="125" >글내용</td>
	    <td align="left" width="375" colspan="3"><pre><%=dto.getContent()%></pre></td>
  </tr>
  <tr height="30">      
	    <td colspan="4"  align="right" > 
	
	
<%
	String id =(String)session.getAttribute("memId");
	int status = 0;	// status = 로그인이 아닌경우 0
	Object obj = session.getAttribute("memSt");	// 로그인인 경우 status를 obj라는 이름으로 가져옴
		if(obj != null)	// obj 값을 가져오면 status에 넣는다.
				{
					status = (int)obj;
				}

		//if(id != null || status == 10) { 
		if(status == 10) { 
		      if(id.equals(dto.getWriter())){ %>
			<input type="button" value="수정"  onclick="window.location='qupdateForm.jsp?num=<%=dto.getNum()%>&writer=<%=dto.getWriter()%>&subject=<%=dto.getSubject()%>&title=<%=dto.getTitle()%>&content=<%=dto.getContent()%>'" />
	        <input type="button" value="삭제" onclick="window.location='qdeleteForm.jsp?num=<%=dto.getNum()%>'" />
	   			<%}%>
			<input type="button" value="답글쓰기" onclick="window.location='qwriteForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	<%}%>		
	
	
     	<input type="button" value="글목록" onclick="window.location='qnalist.jsp'" />
     	
     
     			
     	
     	
	    </td>
  </tr>
</table>
</html></main></div>

    