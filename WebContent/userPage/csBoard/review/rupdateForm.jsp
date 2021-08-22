<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="user.dto.ReviewBoardDTO" %>
<%@page import="user.dao.ReviewBoardDAO" %>

<%@ include file ="../../top.jsp" %>
<div class="review" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>
<link href="../csBoard.css" rel="stylesheet" type="text/css">

<script> 
document.writeform.subject.value = document.writeform.subject.value

</script>

<main>

<%
request.setCharacterEncoding("UTF-8");
String enc = "UTF-8"; //한글 인코딩 
String id = (String)session.getAttribute("memId");

int num = Integer.parseInt(request.getParameter("num"));
String writer = request.getParameter("writer");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
String save = request.getParameter("save");


%>
<html>
<head>
<title> 후기게시판 </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>


<jsp:include page="Header.jsp"/> 


</head>




<%-- --%>
<%
if(id == null){
 %>
     <script> 
       alert("로그인 후 글쓰기 가능합니다!");
       window.location='/jsp/0416/LoginForm.jsp';   
     </script>
     
<%}%>






<body>  
<center>  <div style="font-size: xx-large;"> 상품 후기 </div>  </center>
<br>
<form method="post" name="writeform" enctype="multipart/form-data" action="rupdatePro.jsp" onsubmit="return writeSave()">
<input type="hidden" name="num" value="<%=num%>">


 <table class="table table-striped">  
  
   <tr>
    <td align="right" colspan="2" >
	    <a href="reviewlist.jsp"> review로 돌아가기 </a> 
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
    <td  width="70"   align="center" > 상품명 </td>
    <td  width="330">
    <%if(request.getParameter("num")==null){%>
      <%--  <input type="text" size="40" maxlength="50" name="subject" value="<%=subject%>">
      
      <%if Request("subject")=전체 상품 Then%>selected<%End If%>
	--%>
	   <select name="subject">   
      		 <option value="전체 상품" ><%=subject%><option> 
</select>
	
	<%}else{%>
	
	<%-- 
	  <input type="text" size="40" maxlength="50" name="subject" value="<%=subject%>">
	  --%>
	    <select name="subject">   
      		 <option value="전체 상품" ><%=subject%><option>
      		 <%-- 
            <option value="루시아 앵클 삭스 스니커즈"><%=subject%><option> 
            <option value="골지 데일리 돌돌이 양말"><%=subject%><option> 
            <option value="휘트니 격자 슬링백"><%=subject%><option> 
            <option value="리브 스퀘어 버클 플랫"><%=subject%><option> 
            <option value="폴리 스틸레토 뮬 샌들"><%=subject%><option> 
            <option value="소다 키높이 스니커즈"><%=subject%><option> 
            <option value="샌디뉴 통굽 스니커즈"><%=subject%><option>--%> 
             </select>
	<%}%></td>
  </tr>
  
  
  <tr>
    <td  width="70"   align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="14" cols="70"><%=content%></textarea> </td>
  </tr>
 
   <tr>
    <td  width="70"   align="center" >파일 선택</td>
    <td  width="330" >
    <!--  <input type="file" name ="savePic" />    -->
     <input type="file" name="save" multiple/>
	 </td>
  </tr>
 

<tr>      
 <td colspan=2  align="center"> 
  <input type="submit" value="글쓰기" >  
  <input type="reset" value="다시작성">
  <input type="button" value="목록보기" OnClick="window.location='reviewlist.jsp'">
</td></tr></table>    
   
</form> 

     
</body>
</html> 
</main>
</div>
