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
<h2 class="myPageTitle">비밀번호 변경</h2>
<br /><br/>  


<script>
   function back(){
      history.go(-1);
    
   }
   function confirmPw() {
      	var pw = document.changePw.pw.value;
      	var pwc = document.changePw.pwc.value;
      	
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

<form name = "changePw" action="changePwPro.jsp" method="post" onsubmit="return confirmPw();">

<table>

	<tr align='center' height='50'>
    	<td width='300'><label for="pw"><b>비밀번호</b></label></td>
    	<td width='300'><input type="text" placeholder="비밀번호 입력" name="pw" value="<%=dto.getPw()%>"required><br/></td>
   <tr/>
   	<tr align='center' height='50'>
    	<td width='300'><label for="pwc"><b>비밀번호 확인</b></label></td>
    	<td width='300'><input type="text" placeholder="비밀번호 입력" name="pwc" value="<%=dto.getPw()%>"required><br/></td>
	</tr>
	<tr align='center' height='50'>
		<td width='300'><input type="button" value="뒤로가기" onclick="back();" style="width:100px; height:30px;"/> </td>
		<td width='300'><input type= "submit" value="수정" style="width:100px; height:30px;"/></td>
	</tr>
</form>
</table>
</form>
</main>
</div>

