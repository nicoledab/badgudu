<%@ page contentType="text/html; charset=UTF-8" %>
<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="otoadmin" align="center">
<%@ include file="../adminAside.jsp" %>
<main>

<html>
<head>
<title>문의글쓰기</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
<%
	String id = (String)session.getAttribute("memId");
	if(id == null){
%>		<script>
			alert("로그인후 문의 가능합니다.!!");
			window.location='/badgudu/member/loginForm.jsp'; // 비회원 로그인 페이지 이동경로
		</script>
<%  }%>

<% 
  int num=0,ref=1,re_step=0,re_level=0;
 
    if(request.getParameter("num")!=null){
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref"));
		re_step=Integer.parseInt(request.getParameter("re_step"));
		re_level=Integer.parseInt(request.getParameter("re_level"));
		
	}
    
%>
   
<jsp:include page="Header.jsp"/>
<center><b>문의내용</b>
<br>
<form method="post" name="writeform" action="otoWritePro.jsp" onsubmit="return writeSave()">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="ref" value="<%=ref%>">
<input type="hidden" name="re_step" value="<%=re_step%>">
<input type="hidden" name="re_level" value="<%=re_level%>">

<table class="table-dark " width="900" align="center">
<input type="hidden" name="otonum" value=<%=num %> />
   <tr>
    <td align="right" colspan="2">
	    <a href="otoAdminList.jsp"> 문의목록</a> 
   </td>
   </tr>
   <tr>
    <td  width="70"  align="center">이 름</td>
    <td  width="330">
        <%=id%>
        <input type="hidden" name="writer" value="<%=id%>">
    </td>
  </tr>
  <tr>
    <td  width="70"  align="center" >제 목</td>
    <td  width="330">
    <%if(request.getParameter("num")==null){%>
       <input type="text" size="40" maxlength="50" name="subject"></td>
	<%}else{%>
	   <input type="text" size="40" maxlength="50" name="subject" value="[답변]">
	<%}%>
  </tr>
  <tr>
    <td  width="70"  align="center">Email</td>
    <td  width="330">
       <input type="text" size="40" maxlength="30" name="email" ></td>
  </tr>
  <tr>
    <td  width="70"  align="center">휴대폰번호</td>
    <td  width="330">
       <input type="text" size="40" maxlength="30" name="ph" ></td>
  </tr>
  <tr>
    <td  width="70"  align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"></textarea> </td>
  </tr>
  <tr>
    <td  width="70"  align="center" >비밀번호</td>
    <td  width="330" >
     <input type="password" size="8" maxlength="4" name="passwd"> 
	 </td>
  </tr>
<tr> 
  <tr>
    <td  width="70"  align="center" >첨부파일</td>
    <td  width="330" >
      <input type="file" name="save" />
	 </td>
  </tr>
<tr> 

 <td colspan=2 align="center"> 
  <input type="submit" value="문의쓰기" >  
  <input type="reset" value="다시작성">
  <input type="button" value="목록보기" OnClick="window.location='otoAdminList.jsp'">
</td></tr></table>    
   
</form>      
</body>
</html>      
</main>
</div>
