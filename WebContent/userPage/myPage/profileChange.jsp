<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.dto.MemberDTO" %>
<%@ page import="user.dao.myPageDAO" %>    
<title>회원정보 수정</title>

<%
	// 세션에 ID를 DB에서 검색 한다. 
	// 검색 결과를 DTO에 대입하여 리턴
	String id = (String)session.getAttribute("memId");
	myPageDAO dao = new myPageDAO();
	MemberDTO dto = dao.getUser(id); 
	
%>

<%@ include file ="../top.jsp" %>

<div class="myPage" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../aside.jsp" %>

<link href="myPage.css" rel="stylesheet" type="text/css">

<main>
<h2 class="myPageTitle">회원정보 수정</h2>
<br/><br/>
<table width='700'> <hr>

	<tr height='80' align='center'>
 		<td width='400' class='cg'><label for="name" onclick="window.location='/badgudu/userPage/myPage/changeName.jsp'" style="cursor:pointer"><b>이름</b></label></td>
    	<td><%=dto.getName()%><br/></td><hr>
  	</tr>
	<tr height='80' align='center'> 
		<td width='400'class='cg'><b>아이디</b><br/>(아이디는 수정이 불가합니다.)</td>
    	<td><%=dto.getId()%></br></td>
	</tr>
	<tr height='80' align='center'>
    	<td width='400' class='cg'><label for="pw" onclick="window.location='/badgudu/userPage/myPage/changePw.jsp'" style="cursor:pointer"><b>비밀번호</b></label></td>
    	<td><%=dto.getPw()%></br></td>
   <tr/>
   <tr height='80' align='center'> 	
    	<td width='400' class='cg'><label for="address" onclick="window.location='/badgudu/userPage/myPage/changeAddress.jsp'" style="cursor:pointer"><b>주소</b></label></td>
    	<td><%=dto.getAddress()%></br></td>
	</tr>
	<tr height='80' align='center'> 	
    	<td width='400' class='cg'><label for="phoneNumber" onclick="window.location='/badgudu/userPage/myPage/changePhoneNumber.jsp'" style="cursor:pointer"><b>전화번호</b></label></td>
    	<td><%=dto.getPhoneNumber()%></br></td>
	</tr>
	<tr align='center'>
		<td>
			<button type="button" class="delete" onclick="history.go(-1)" style="width:150px; height:50px;">돌아가기</button>
		</td>
		<td>
			<button type="button" class="delete" onclick="window.location='/badgudu/userPage/myPage/deleteUser.jsp'" style="width:150px; height:50px;">회원 탈퇴</button>
		</td>
</main>
</div>

</table></tr>