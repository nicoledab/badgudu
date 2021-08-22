<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ page import = "user.dto.ReviewBoardDTO" %>
    <%@ page import = "user.dao.ReviewBoardDAO" %>
      
   <% request.setCharacterEncoding("UTF-8"); %>
<%@ include file ="../../top.jsp" %>
<div class="review" align="center">
<%--사이드 메뉴 끌어오기 
<%@ include file ="../../aside.jsp" %>--%>
<link href="../csBoard.css" rel="stylesheet" type="text/css">


<main>

<html>
<head>
<title> 후기게시판 </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>




<jsp:include page="Header.jsp"/> 

</head>

<!--  
<%
String id = (String)session.getAttribute("memId");

//String productCode = request.getParameter("pdCode");
//int pdCode = Integer.parseInt(productCode);

String pdCode = (String)request.getParameter("pdcode"); // 대문자 때문에 pdcode를 못 받아온거였음... ()
//System.out.println(pdCode);
ReviewBoardDAO DAO = new ReviewBoardDAO();

//DAO.BringpdName(pdCode);




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
    
    String idOdCheck = DAO.idOdCheck(id,pdCode); //본인이 구매한 상품만 리뷰쓰게 .. 하는건데.. .안돼...계속 NULL이 나온다 
    System.out.println(idOdCheck);
    
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
  
     <tr>
    <td  width="70"   align="center"> 상품명 </td>
    <td  width="230">
    		<%=DAO.BringpdName(pdCode) %>
    		 <input type="hidden" name="subject" value="<%=DAO.BringpdName(pdCode) %>">
    		<%-- System.out.println(pdCode);
    			System.out.println(DAO.BringpdName(pdCode));
   		  <input type="text" size="40" maxlength="50" name="subject"></td>
       </td>--%>
  </tr>   
 <%-- 
  <tr>
    <td  width="70"   align="center" > 상품명 </td>
    <td  width="330">
    <%if(request.getParameter("num")==null){%>
      
       <input type="text" size="40" maxlength="50" name="subject"></td>
       
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
  </tr>--%>

  <tr>
    <td  width="70"   align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="14" cols="70"></textarea>
   
  
 
      </td>
  </tr>
 <!--   <tr>
    <td  width="70"   align="center" >비밀번호</td>
    <td  width="330" >
     <input type="password" size="8" maxlength="12" name="passwd"> 
	 </td>
  </tr>-->
   <tr>
    <td  width="70"   align="center" >파일 선택</td>
    <td  width="330" >
    <%--  <input type="file" name ="savePic" />    --%>
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


  <%-- 
     
 <script type="text/javascript">
		CKEDITOR.replace('content', {
			
			 width:'100%',
			    height:'350'                                                  
});
	</script>
     
--%>
     
</body>


</html> 
</main>
</div>

