<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.dao.noticeDAO" %>
<%@ page import = "user.dto.noticeDTO" %>


<link href="/badgudu/adminPage/loginStyle.css" rel="stylesheet" type="text/css">
<%@ include file ="../../adminTop.jsp" %>
<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../adminAside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">
<jsp:include page="Header.jsp"/>

<main>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

  noticeDAO dbPro = new noticeDAO();
  noticeDTO article =  dbPro.updateGetArticle(num);
%>
<script>
document.writeform.submit();
</script>
<body>  
<center><b>글수정</b>
<br>
<form form method="post" name="writeform" enctype="multipart/form-data" id="writeform" action="updatePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>" onsubmit="return writeSave()">
<table  class="table-bordered"  width="900" align="center">
  <tr>
    <td  width="70"  align="center" >제 목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject" value="<%=article.getSubject()%>"></td>
  </tr>
  <tr>
    <td  width="70"  align="center" >내 용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40"><%=article.getContent()%></textarea></td>
  </tr>
  <tr>
	<td  width="70"  align="center" >첨부파일</td>
	<td align="left" width="330">
		<input type="file" name="save" /><%=article.getSave()%><br>
		<input type="hidden" name="orgsave" value="<%=article.getSave()%>" /> <!-- 기존의 save파일 -->
	</tr> 
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='notice.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
    
      
</body>
</html>      
</main>
</div>


