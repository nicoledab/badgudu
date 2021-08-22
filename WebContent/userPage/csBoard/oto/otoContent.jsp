<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<html>
<head>
<title>1:1문의</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
	String id = (String)session.getAttribute("memId");   // 세션이름 맞아? 옙 맞아요
	
	otoBoardDBBean dbPro = new otoBoardDBBean();
	otoBoardDataBean article =  dbPro.getArticle(num, id);
  
	int ref=article.getRef();
	int re_step=article.getRe_step();
	int re_level=article.getRe_level();
%>

<%@ include file ="../../top.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">
<jsp:include page="Header.jsp"/>

<main>
<body>  
<center><b>문의내용 보기</b>
<br>
<table  class="table   table-bordered">  
	<tr height="30">
		<td align="center" width="125" >문의번호</td>
		<td align="center" width="125" align="center"><input type="hidden" name="otonum" value=<%=article.getNum()%> /><%=article.getNum()%></td>
	    <td align="center" width="125" >문의상태</td>
	    <td align="center" width="125" align="center">
        <%if(article.getReadcount()>0 && article.getRe_level()>0){%>
           <b>문의답변</b>
           <%}else if(article.getReadcount()>0 && article.getRe_level()==0){%>
           <b>문의확인</b>
           <%}else{%>
           <b>문의대기</b> 
           </td>
           <%} %>
           </td>
   </tr>
  <tr height="30">
	    <td align="center" width="125" >작성자</td>
	    <td align="center" width="125" align="center"><%=article.getWriter()%></td>
	    <td align="center" width="125"  >작성일</td>
	    <td align="center" width="125" align="center"><%= sdf.format(article.getReg_date())%></td>
  </tr>
  
  <tr height="30">
	    <td align="center" width="125" >문의제목</td>
	    <td align="center" width="125" align="center"><%=article.getSubject()%></td>
	    <td align="center" width="125"  >휴대폰번호</td>
	    <td align="center" width="125" align="center"><%=article.getPh() %></td>
  </tr>
  <tr>
	    <td align="center" width="125">문의내용</td>
	    <td align="left" width="375" colspan="3"><pre><%=article.getContent()%></pre></td>
  </tr>
    <tr>
	    <td align="center" width="125">첨부파일</td>
	    <td align="left" width="375" colspan="3"><pre> <img src="/badgudu/save/<%=article.getSave()%>" /> <br />
		  </pre></td>
  </tr>
  <tr height="30">      
	    <td colspan="4" align="right" > 
			<input type="button" value="문의수정" onclick="window.location='otoUpdateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="문의삭제" onclick="window.location='otoDeleteForm.jsp?num=<%=article.getNum()%>&otonum=<%=article.getOtonum()%>&pagenum=<%=pageNum%>&re_level=<%=article.getRe_level() %>'">
			<input type="button" value="문의목록" onclick="window.location='otoUserList.jsp?pageNum=<%=pageNum%>'">
	    </td>
  </tr>
</table>
</body>
</main>
</div>
</html>      
