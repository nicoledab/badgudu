<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.dto.MemberDTO" %>
<%@ page import="user.dao.myPageDAO" %>    

<%@ include file ="../top.jsp" %>

<div class="myPage" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../aside.jsp" %>

<link href="myPage.css" rel="stylesheet" type="text/css">
<main>
<h2 class="myPageTitle">이름 변경</h2>
<br /><br/>
<script>
   function back(){
      history.go(-1);
    
   }

</script>
<%
	// 세션에 ID를 DB에서 검색 한다. 
	// 검색 결과를 DTO에 대입하여 리턴
	String id = (String)session.getAttribute("memId");
	myPageDAO dao = new myPageDAO();
	MemberDTO dto = dao.getUser(id); 
	
%>

<form name = "changeName" action="changeNamePro.jsp" method="post">

<table>
	<tr align='center' height='50'>
 		<td width='300'><label for="name" ><b>이름</b></label></td>
    	<td width='300'><input type="text" placeholder="이름 입력" name="name" value="<%=dto.getName()%>" required> </td>
  	</tr>
  	<tr align='center' height='50'>
  		<td><button type="button" class="delete" onclick="history.go(-1)" style="width:100px; height:30px;">돌아가기</button></td>
  		<td><input type= "submit" value="수정" style="width:100px; height:30px;"/></td>
  	</tr>
</table>
</form>

</main>
</div>