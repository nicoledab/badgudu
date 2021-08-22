<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dto.ReviewBoardDTO" %>
<%@page import="user.dao.ReviewBoardDAO" %>
<%@page import="java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<% request.setCharacterEncoding("UTF-8");%>

<%@ include file ="../../top.jsp" %>
<div class="review" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>
<link href="../csBoard.css" rel="stylesheet" type="text/css">


<main>

<%
//--일반 검색 !!!----------------------------------
String search = request.getParameter("search");

int pageSize = 10;   // 한페이지에 보여질 게시물수 ! 
	String id =(String)session.getAttribute("memId");

	String pageNum = request.getParameter("pageNum"); 
String enc = "UTF-8"; //한글 인코딩 
if (pageNum == null) {
pageNum = "1";     //    페이지 번호. 1페이지~n페이지
}


int currentPage = Integer.parseInt(pageNum);  // 1   /   2 
int startRow = (currentPage - 1) * pageSize + 1; //(1-1) * 10 + 1 = 1  // 11
int endRow = currentPage * pageSize; //1 * 10 = 10   // 2*10=20
int count = 0;     // 전체 게시물수 ... 
int number=0;      //화면의 글 번호(DB의 글번호가 아님)
List articleList = null;

ReviewBoardDAO dao = new ReviewBoardDAO();

//서치했을때 카운트
//count = dao.getreviewCount();
count = dao.getreviewCount(search);

//게시글수(10개)  > 0 
if (count > 0) {                 //    1,       10 
articleList = dao.getreview(search, startRow, endRow);
}

System.out.println(articleList);  
number=count-(currentPage-1)*pageSize; // count(10)-(1-1)*10 = 10


%>


<html style=" float:left;">
<head>
<title> 후기게시판 </title>

<script></script>
<jsp:include page="Header.jsp"/>  <%-- 부트스트랩 --%>

</head>


    <h1> 상품 후기 </h1>
  
       <form action="rsearchList.jsp" method="post" align='left'>
       상품명 : 
   		<input type="text" name="search" /> 
   		<input type="submit" value="검색" /> 
   </form>
     <br /><br />
    <%if (count == 0) {%>
	<table class="table table-striped">

		<tr> <%-- 잠시만여  --%>
    		<td align="center">
    			게시판에 저장된 글이 없습니다.
    		</td>
    	</tr>
	</table>

<%}else{%> 
   
     <% ArrayList<ReviewBoardDTO> list = dao.getList(); %>    
       
       
  <table  class="table  table-dark  table-hover">
  <tr>                   <%--상품명은 subject -즉 제목이 된다.  --%>
    <td>번호</td><td>작성자</td><td>상품명</td><td width='450'>내용</td><td>날짜</td><td>조회수</td>
  </tr>
  <%--  --%>
   <%for (int i = 0 ; i < articleList.size() ; i++) {
	  ReviewBoardDTO dto = (ReviewBoardDTO)articleList.get(i); %>
  
  
   
    <%-- 
  <%for(ReviewBoardDTO dto : list){ %>
   --%>
  
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
  


  <% 
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="reviewlist.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        	<a href="reviewlist.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%		}
        if (endPage < pageCount) {  %>
        	<a href="reviewlist.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%		}
    }
%>

<br /> <br /><br />
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
      
   