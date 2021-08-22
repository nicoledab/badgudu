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
<h2 class="myPageTitle">전화번호 변경</h2>
<br /><br/>
<style>
input[type=number] {
  width: 30%;
  }
</style>

<script>
   function back(){
      history.go(-1);
    
   }
   function loginNext() {
      	var pw = document.updateUser.pw.value;
      	var pwc = document.updateUser.pwc.value;
      	
      	if(pw != pwc) {
      		alert("비밀번호가 다릅니다");
      		return false;
      	}
   }
</script>
<%
	// 세션에 ID를 DB에서 검색 한다. 
	// 검색 결과를 DTO에 대입하여 리턴
	String id = (String)session.getAttribute("memId");
	myPageDAO dao = new myPageDAO();
	MemberDTO dto = dao.getUser(id); 
	
%>

<form name = "changePhoneNumber" action="changePhoneNumberPro.jsp" method="post">

<table>

    <tr align='center' height='50'> 	
    	<td width='300'><label for="address"><b>전화번호</b></label></td>
    	<td width='500'><input type="number" name="ph1" required  value="<%=dto.getPh1() %>">-
    								<input type="number" name="ph2"  value="<%=dto.getPh2() %>" required>-
    								<input type="number" name="ph3"  value="<%=dto.getPh3() %>" required><br/></td>
    	
	</tr >
	<tr align='center' height='50'>
		<td width='300'><input type="button" value="뒤로가기" onclick="back();" style="width:100px; height:30px;"/></td>
		<td width='300'><input type= "submit" value="수정" style="width:100px; height:30px;"/></td>
	</tr>
</table>
</form>
</main>
</div>
