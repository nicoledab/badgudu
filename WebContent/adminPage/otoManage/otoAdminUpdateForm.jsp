<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="otoadmin" align="center">
<%@ include file="../adminAside.jsp" %>
<main>

<jsp:include page="Header.jsp"/>
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

 <input type="hidden" name="otonum" value=<%=num %> />
<center><b>글수정</b>
<br>
<form method="post" name="writeform" action="otoUpdatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<table class="table-dark " width="900" align="center">
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
     <input type="file" name="save" value="<%=article.getSave()%>" /> <br />
	 </td>
  </tr>
  <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='otoAdminList.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
    
      
</body>
</html>      
</main>
</div>
