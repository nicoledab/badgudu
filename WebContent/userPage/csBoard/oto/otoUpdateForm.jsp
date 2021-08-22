<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>

<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%
int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

      otoBoardDBBean dbPro = new otoBoardDBBean();
      otoBoardDataBean article =  dbPro.updateGetArticle(num);
%>

<%@ include file ="../../top.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">
<jsp:include page="Header.jsp"/>

<main>
 
<center><b>글수정</b>
<br>
<form method="post" name="writeform" action="otoUpdatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<table class="table   table-bordered">
  <tr>
    <td  width="70"  align="center">이 름</td>
    <td align="left" width="330">
       <input type="text" size="10" maxlength="10" name="writer" value="<%=article.getWriter()%>">
	   <input type="hidden" name="num" value="<%=article.getNum()%>"></td>
  </tr>
  <tr>
    <td  width="70"  align="center" >제 목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject" value="<%=article.getSubject()%>"></td>
  </tr>
  <tr>
    <td  width="70" align="center">Email</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="30" name="email" value="<%=article.getEmail()%>"></td>
  </tr>
    <tr>
    <td  width="70" align="center">휴대폰번호</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="30" name="ph" value="<%=article.getPh()%>"></td>
  </tr>
  <tr>
    <td  width="70" align="center" >내 용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40"><%=article.getContent()%></textarea></td>
  </tr>
  <tr>
    <td  width="70"  align="center" >비밀번호</td>
    <td align="left" width="330" >
     <input type="password" size="8" maxlength="4" name="passwd">
	 </td>
  </tr>
    <tr>
    <td  width="70"  align="center" >첨부파일</td>
    <td align="left" width="330" >
     <input type="file" name="img" value="<%=article.getSave()%>" /> <br />
	 </td>
  </tr>
  <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='otoUserList.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
    
      
</body>
</center>
</main>
</div>
</html>      
