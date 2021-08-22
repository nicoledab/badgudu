<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <% request.setCharacterEncoding("UTF-8"); %>

<%@ include file ="../../adminTop.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../adminAside.jsp" %>
<div class="review" align="center">
<%--사이드 메뉴 끌어오기 
<%@ include file ="../../aside.jsp" %>--%>
<link href="../style.css" rel="stylesheet" type="text/css">


<main>

<html>
<head>
<title> 후기게시판 </title>
<script language="JavaScript" src="script.js"></script>




<jsp:include page="Header.jsp"/> 

</head>

<!--  
<%
String id = (String)session.getAttribute("memId");
if(id == null){
 %>
     <script> 
       alert("로그인 후 글쓰기 가능합니다!");
       window.location='/jsp/0416/LoginForm.jsp';   
     </script>
     
<%}%>

-->


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
<center><b>~후기~</b>  <div style="font-size: xx-large;"> Review </div>  </center>
<br>
<form method="post" name="writeform" enctype="multipart/form-data" action="rwritePro.jsp" onsubmit="return writeSave()">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="ref" value="<%=ref%>">
<input type="hidden" name="re_step" value="<%=re_step%>">
<input type="hidden" name="re_level" value="<%=re_level%>">

<%--<table width="400" border="1" cellspacing="0" cellpadding="0"  align="center"> --%>

  
 <table class="table table-striped">  
  
   <tr>
    <td align="right" colspan="2" >
	    <a href="reviewlist.jsp"> review로 돌아가기 </a> 
   </td>
   </tr>
   <tr>
    <td  width="70"   align="center">이 름</td>
    <td  width="230">
   		   <%=id%>    
        <input type="hidden" name="writer" value="<%=id%>">
       </td>
  </tr>
   <%--   
  <tr>
  <td  width="70"   align="center"> 상품 종류 </td>
  <td  width="230"> 
     <select name="product"> 
      		 <option value="product1" >전체 상품<option> 
            <option value="product2">루시아 앵클 삭스 스니커즈<option> 
            <option value="product3">골지 데일리 돌돌이 양말<option> 
            <option value="product4">휘트니 격자 슬링백<option> 
            <option value="product5">리브 스퀘어 버클 플랫<option> 
            <option value="product6">폴리 스틸레토 뮬 샌들<option> 
            <option value="product7">소다 키높이 스니커즈<option> 
            <option value="product8">샌디뉴 통굽 스니커즈<option> </select>
  </td>
  </tr>--%>
  <tr>
    <td  width="70"   align="center" > 상품명 </td>
    <td  width="330">
    <%if(request.getParameter("num")==null){%>
    <%--
       <input type="text" size="40" maxlength="50" name="subject"></td>
        --%>
             <select name="subject"> 
      		 <option value="전체 상품" >전체 상품<option> 
            <option value="루시아 앵클 삭스 스니커즈">루시아 앵클 삭스 스니커즈<option> 
            <option value="골지 데일리 돌돌이 양말">골지 데일리 돌돌이 양말<option> 
            <option value="휘트니 격자 슬링백">휘트니 격자 슬링백<option> 
            <option value="리브 스퀘어 버클 플랫">리브 스퀘어 버클 플랫<option> 
            <option value="폴리 스틸레토 뮬 샌들">폴리 스틸레토 뮬 샌들<option> 
            <option value="소다 키높이 스니커즈">소다 키높이 스니커즈<option> 
            <option value="샌디뉴 통굽 스니커즈">샌디뉴 통굽 스니커즈<option> </select>
        
	<%}else{%>
	   <input type="text" size="40" maxlength="50" name="subject" value="[답변]">
	<%}%>
  </tr>

  <tr>
    <td  width="70"   align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="14" cols="70"></textarea>
   
  
 
      </td>
  </tr>

   <tr>
    <td  width="70"   align="center" >파일 선택</td>
    <td  width="330" >
    <%--  <input type="file" name ="savePic" />    --%>
     <input type="file" name="save" multiple/>
	 </td>
  </tr>
    <!--  <tr>
    <td  width="70"   align="center" >파일 선택2</td>
    <td  width="330" >
     <input type="file" name ="save2" />
	 </td>
  </tr> -->

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

