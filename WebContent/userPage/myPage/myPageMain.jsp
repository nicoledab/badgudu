<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.dto.MemberDTO" %>
<%@ page import="user.dao.myPageDAO" %>    
    
<title>마이페이지</title>

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
<h1 class="myPageTitle">마이페이지</h1>
<table width='1000' class="myPageTable" border=1 cellpadding='2'>
	<tr height='150' align='center'>
		<td width="250" onclick="location.href='profileChange.jsp'" style="cursor:pointer;">회원정보 수정</td>
		<td width="250" onclick="location.href='/badgudu/userPage/order/cartView.jsp'" style="cursor:pointer;">장바구니</td>
		<td width="250" onclick="location.href='/badgudu/userPage/orderDetail/MyOrderListNew.jsp'" style="cursor:pointer;">주문내역</td>
		
	</tr>
	<tr height='150' align='center'>
		<td width="250" onclick="location.href='/badgudu/userPage/myPage/myReview.jsp?memId=<%=id %>'" style="cursor:pointer;">내가 쓴 리뷰</td>
		<td width="250" onclick="location.href='/badgudu/userPage/csBoard/oto/otoUserList.jsp'" style="cursor:pointer;">1:1문의</td>
		<td width="250" onclick="location.href='/badgudu/userPage/csBoard/qna/qnalist.jsp'" style="cursor:pointer;">자주묻는 질문</td>
	</tr>
</main>
</div>

</table>