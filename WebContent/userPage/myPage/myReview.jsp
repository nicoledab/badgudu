<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dto.ReviewBoardDTO" %>
<%@page import="user.dao.ReviewBoardDAO" %>
<%@page import="java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<% request.setCharacterEncoding("UTF-8");%>

<%@ include file ="../top.jsp" %>
<div class="review" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../aside.jsp" %>
<link href="myPage.css" rel="stylesheet" type="text/css">


<main>

<%
String id =(String)session.getAttribute("memId");
String enc = "UTF-8"; //한글 인코딩 

int count = 0;	// 전체 게시물 수

ReviewBoardDAO dbPro =new ReviewBoardDAO();
count = dbPro.getMyReviewCount(id); // 전체 게시물 수를  dbPro의 ArticleCount() 메서드에서 가져옴

%>


<html>
<head>
<title> my review Board </title>

<jsp:include page="Header.jsp"/> 

</head>


    <h1>내가 쓴 후기</h1> <h5>(전체 글 : <%=count %>) </h5> <br />
    <%-- dto는 하나의 db 정보만...
     dto를 모두 보관하는 array list--%> 
     
     <%-- 
       <form action="rsearchList.jsp" method="post">
  		 <select name="col"> 
            
            <option value="product1" >전체 상품<option> 
            <option value="product2">루시아 앵클 삭스 스니커즈<option> 
            <option value="product3">골지 데일리 돌돌이 양말<option> 
            <option value="product4">휘트니 격자 슬링백<option> 
            <option value="product5">리브 스퀘어 버클 플랫<option> 
            <option value="product6">폴리 스틸레토 뮬 샌들<option> 
            <option value="product7">소다 키높이 스니커즈<option> 
            <option value="product8">샌디뉴 통굽 스니커즈<option> 
   		</select>
   		<input type="text" name="search" /> 
   		<input type="submit" value="검색" /> 
   </form>--%>
     <%
     ReviewBoardDAO dao = new ReviewBoardDAO();
     ArrayList<ReviewBoardDTO> list = dao.getMyReviewList(id); 
       %>    
   
  <%if (count == 0) {%>
	<table width="700" border="1" cellpadding="10" cellspacing="0" height="300">
		<tr>
    		<td align="center">
    			작성하신 후기가 없습니다 
    		</td>
    	</tr>
	</table>

<%  } else {    %> 
       
       
  <table  class="table table-striped">
  <tr>                   <%--상품명은 subject -즉 제목이 된다.  --%>
    <td>번호</td><td>작성자</td><td>상품명</td><td>내용</td><td>날짜</td><td>조회수</td>
  </tr>
  <%
     for(ReviewBoardDTO dto : list){ %>
     <tr>
        <td><%=dto.getNum()%></td>
         <td><%=dto.getWriter()%></td>
        <td>
         
          <%=dto.getSubject()%>  
           
        </td>
        
        <td>
        <a href="rcontent.jsp?num=<%=dto.getNum()%>"> <%=dto.getContent() %>  </a> 
        </td>
        
        <%-- <td>
           <%if(dto.getStatus() ==3){ %>
           해당 글은 삭제 되었습니다.
           <%}else{%>
         <a href="rcontent.jsp?num=<%=dto.getNum()%>">  <%=dto.getSubject()%>  </a> 
           <%}%>
           </td>
            --%>
        <td><%=dto.getReg_date() %></td>
        <td><%=dto.getReadcount()%></td>
      </tr>
   <%} %>
   

   
</table>
<%}%>

<%if(id != null ){ %>
<%--
    			<input type="button"  value="후기 작성" onclick="window.location='rwriteForm.jsp'"  />
    	 --%>		
    			
    		<%}else{ %>
    		<input type="button"  value="로그인하러 가기" onclick="window.location='/badgudu/userPage/login/loginForm.jsp'"  />
    		<%} %>
</html>
</main>
</div>


<%--
<%@ include file ="/userPage/bottom.jsp" %>
      --%>
      
   