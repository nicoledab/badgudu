<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% 
    request.setCharacterEncoding("UTF-8"); %>
    
<%@ include file ="../../adminTop.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../adminAside.jsp" %>
<link href="../style.css" rel="stylesheet" type="text/css">


<main>
    
    
<html>
<head>
<title> Q&A 게시판 2222 </title>
<script language="JavaScript" src="script.js"></script>

<jsp:include page="Header.jsp"/> 

</head>

<!-- -->
<%
String enc = "UTF-8"; //한글 인코딩 
String id = (String)session.getAttribute("memId");
if(id == null){
 %>
     <script> 
       alert("로그인 후 글쓰기 가능합니다! ");
       window.location='/badgudu/userPage/login/loginForm.jsp';   
     </script>
     
<%}%> 




<% 
  int num=0,ref=1,re_step=0,re_level=0;
 
    if(request.getParameter("num")!=null){
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref")); 
		re_step=Integer.parseInt(request.getParameter("re_step"));
		re_level=Integer.parseInt(request.getParameter("re_level"));
	}
%>
   
<body>  
<center><b>  <div style="font-size: xx-large;"> Q&A 글쓰기 </div>  </b>
<br>
<form method="post" name="writeform" action="qwritePro.jsp" onsubmit="return writeSave()">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="ref" value="<%=ref%>">
<input type="hidden" name="re_step" value="<%=re_step%>">
<input type="hidden" name="re_level" value="<%=re_level%>">

<table  class="table table-striped">
   <tr>
    <td align="right" colspan="2" >
	    <a href="qnalist.jsp"> Q&A 게시판으로 </a> 
   </td>
   </tr>
   <tr>
    <td  width="70"   align="center">이 름</td>
    <td  width="330">
   		   <%=id%>    
        <input type="hidden" name="writer" value="<%=id%>">
       </td>
  </tr>
     <tr>
    <td  width="70"   align="center"> subject </td>
    <td  width="330">
   		   <select name="subject"> 
     			<option>배송문의</option>
     			<option>상품문의</option>
     			<option>교환/반품문의</option>
     			<option>기타</option>
     		</select>
       </td>
  </tr>
  <tr>											
    <td  width="70"   align="center" >제 목</td>
    <td  width="330">
    <%if(request.getParameter("num")==null){%>
       <input type="text" size="40" maxlength="50" name="title"></td>
	<%}else{%>
	   <input type="text" size="40" maxlength="50" name="title" value="[답변]">
	<%}%>
  </tr>

  <tr>
    <td  width="70"   align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="14" cols="70"></textarea> </td>
  </tr>
 
 
<tr>      
 <td colspan=2  align="center"> 
  <input type="submit" value="글쓰기" >  
 <!--  <input type="reset" value="다시작성"> --> 
  <input type="button" value="목록보기" OnClick="window.location='qnalist.jsp'">
</td></tr></table>    
   
</form>      
</body>
</html>  
</main>
</div>