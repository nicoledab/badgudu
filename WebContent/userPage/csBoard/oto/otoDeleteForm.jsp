<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%
  int num = Integer.parseInt(request.getParameter("num"));
	int level = Integer.parseInt(request.getParameter("re_level"));
	int otonum = Integer.parseInt(request.getParameter("otonum"));
  String pageNum = request.getParameter("pageNum");
  
  otoBoardDBBean dbPro = new otoBoardDBBean();
  otoBoardDataBean article =  dbPro.updateGetArticle(num);
%>
<html>

<%@ include file ="../../top.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">


<main>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">      
  function deleteSave(){	
	if(document.delForm.passwd.value==''){
		alert("비밀번호를 입력하십시요.");
		document.delForm.passwd.focus();
		return false;
 	}
}          
</script>
</head>

<center><b>글삭제</b>
<br>
<form method="POST" name="delForm"  action="otoDeletePro.jsp?num=<%=num %>&otonum=<%=otonum %>&pageNum=<%=pageNum%>&level=<%=level%>" onsubmit="return deleteSave()"> 
	<table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
		<tr height="30">
     		<td align=center ><b>비밀번호를 입력해 주세요.</b></td>
  		</tr>
  		<tr height="30">
			<td align=center >
				비밀번호 : <input type="password" name="passwd" size="8" maxlength="4">
						 <input type="hidden" name="num" value="<%=num%>">
			</td>
		</tr>
 		<tr height="30">
    		<td align=center>
      			<input type="submit" value="글삭제" >
      			<input type="button" value="글목록" onclick="document.location.href='otoUserList.jsp?pageNum=<%=pageNum%>'">     
   			</td>
 		</tr>  
	</table> 
</form>
</body>
</html> 
