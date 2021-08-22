<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <title>BAD GUDU</title>
    
<%--top페이지 --%>
<%@ include file ="../top.jsp" %>

<link href="loginStyle.css" rel="stylesheet" type="text/css">
<%--사이드 메뉴 끌어오기 --%>
<div id="loginForm" align="center">
<%@ include file ="../aside.jsp" %>

<main>
  <form name="loginForm" action="loginPro.jsp" class="loginForm">
  <h1>로그인</h1>
    <hr>
    <br />
	<table>
	<tr>
		<td align='center'width='150'> <b>아이디 </b></td>
       	<td colspan='2'>
       		<input type="text" name="id" placeholder="아이디" required style="width:300px; height:50px; font-size:15px;">
       	</td>
	</tr>
	<tr>
		<td align='center' width='150' > <b>비밀번호</b> </td>
		<td colspan='2'> 
			<input type="password" name="pw" placeholder="비밀번호" required style="width:300px; height:50px; font-size:15px;">
		</td>
	</tr>
	<tr>
		<td colspan='3' align='center'>
			<input type="submit" value="Login" style="width:450px; height:40px; font-size:18pt; background-color:#4CAF50; opacity: 0.9">
		</td>
	</tr>
	<tr>
	</tr>
	<tr>
		<td align='center'> <input type="button" value="회원가입" onclick="window.location='signUp.jsp'" style="width:150px; height:40px; font-size:11pt"> </td>
		<td align='center'> <input type="button" value="아이디 찾기" onclick="window.location='findId.jsp'" style="width:150px; height:40px; font-size:11pt"> </td>
		<td align='center'> <input type="button" value="비밀번호 찾기" onclick="window.location='findPw.jsp'" style="width:150px; height:40px; font-size:11pt">  </td>
	</tr>
	</table>
 </form>
</main>
</div>
      
<%@ include file="../bottom.jsp" %>
