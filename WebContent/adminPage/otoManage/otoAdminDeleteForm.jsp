<%@ page contentType="text/html; charset=UTF-8" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
  int otonum = Integer.parseInt(request.getParameter("otonum")); 
  int level = Integer.parseInt(request.getParameter("re_level"));
  String pageNum = request.getParameter("pageNum");
%>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="otoadmin" align="center">
<%@ include file="../adminAside.jsp" %>
<main>
<html>
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
<form method="POST" name="delForm"  action="otoDeletePro.jsp?num=<%=num %>&otonum=<%=otonum %>&pageNum=<%=pageNum%>&level=<%=level %>" onsubmit="return deleteSave()"> 
	<table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
		<tr height="30">
     		<td align=center ><b>비밀번호를 입력해 주세요.</b></td>
  		</tr>
  		<tr height="30">
			<td align=center >
				비밀번호 : <input type="password" name="passwd" size="8" maxlength="4">
						 <input type="hidden" name="num" value="<%=otonum%>">
						 
			</td>
		</tr>
 		<tr height="30">
    		<td align=center>
      			<input type="submit" value="글삭제" >
      			<input type="button" value="글목록" onclick="document.location.href='otoAdminList.jsp?pageNum=<%=pageNum%>'">     
   			</td>
 		</tr>  
	</table> 
</form>
</body>
</html> 
</main>
</div>