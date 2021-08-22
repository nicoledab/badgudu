<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.MemberDAO" %>
<%@ page import = "user.dto.MemberDTO" %>

<link href="../style.css" rel="stylesheet" type="text/css">
<%@ include file="../../adminTop.jsp" %>
<div class="crmmng" align="center">
<%@ include file="../../adminAside.jsp" %>
<main>
<style>
input[type=number] {
  width: 20%;
  }
</style>


<html>
<head>
<title>고객수정페이지</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>

<%

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

      MemberDAO dbPro = new MemberDAO();
      MemberDTO article =  dbPro.updateGetArticle(num);
%>

 
<center><b>고객수정</b>
<br>
<form method="post" name="writeform" action="crmUpdatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<table width="400" border="1" cellspacing="0" cellpadding="0"  align="center">
  <tr>
    <td  width="70"  align="center">이 름</td>
    <td align="left" width="330">        
       <input type="text" size="10" maxlength="10" name="name" value="<%=article.getName()%>">   
	    <input type="hidden" name="num" value="<%=num%>"></td>
  </tr>
  <tr>
    <td  width="70"  align="center" >아 이 디</td>
    <td align="left" width="330">
       <input type="hidden" size="40" maxlength="50" name="id" value="<%=article.getId()%>"><%=article.getId()%></td>
  </tr>
  <tr>
    <td  width="70" align="center">상 태</td>
    <td align="left" width="330">
       <select name="status">
    				<option value="1" <%if(article.getStatus()==1){%>selected<%}%>>유저</option>
    				<option value="2" <%if(article.getStatus()==2){%>selected<%}%>>휴면</option>
    				<option value="3" <%if(article.getStatus()==3){%>selected<%}%>>탈퇴</option>
    				<option value="10" <%if(article.getStatus()==10){%>selected<%}%>>어드민</option>
    			</select>
  </tr>
    <tr>
    <td  width="70" align="center">가 입 날 짜</td>
    <td align="left" width="330">
       <%= sdf.format(article.getSignupdate()) %></td>
  </tr>
  </tr>
  <tr>
    <td  width="70"  align="center" >주 소</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="address" value="<%=article.getAddress()%>"></td>    
  </tr>
  <tr>
    <td  width="70"  align="center" >전화번호</td>
    <td align="left" width="330">
       <input type="number" name="ph1" required  value="<%=article.getPh1() %>">-
    								<input type="number" name="ph2"  value="<%=article.getPh2() %>" required>-
    								<input type="number" name="ph3"  value="<%=article.getPh3() %>" required></td>    
  </tr>
  <tr>
    <td  width="70"  align="center" >비밀번호</td>
    <td align="left" width="330" >
     <input type="password" size="20" maxlength="20" name="pw" value="<%=article.getPw()%>">
	 </td>
  </tr>
  <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="고객수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" onclick="document.location.href='crmForm.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
    
      
</body>
</html>  
</main>
</div>    
