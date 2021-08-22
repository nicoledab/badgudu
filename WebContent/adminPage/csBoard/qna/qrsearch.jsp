<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.dto.QnaBoardDTO" %>
<%@page import="user.dao.QnaBoardDAO" %>
<%@page import="java.util.ArrayList" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<% request.setCharacterEncoding("UTF-8");%>

<%@ include file ="../../adminTop.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../adminAside.jsp" %>
<link href="../style.css" rel="stylesheet" type="text/css">


<main>


<% 
//--일반 검색 !!!----------------------------------
String col = request.getParameter("col");
String search = request.getParameter("search");


int pageSize = 10;   // 한페이지에 보여질 게시물수 ! 
// 작성날짜 해당 형식으로 보기 위함:아래 95라인에서 사용
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 

String pageNum = request.getParameter("pageNum"); // 리스트에서 페이지번호 클릭시 받을수있다.
if (pageNum == null) {
pageNum = "1";     //    페이지 번호. 1페이지~n페이지
}


int currentPage = Integer.parseInt(pageNum);  // 1   /   2 
int startRow = (currentPage - 1) * pageSize + 1; //(1-1) * 10 + 1 = 1  // 11
int endRow = currentPage * pageSize; //1 * 10 = 10   // 2*10=20
int count = 0;     // 전체 게시물수 ... 
int number=0;      //화면의 글 번호(DB의 글번호가 아님)

List<QnaBoardDTO> articleList = null;
QnaBoardDAO dbPro =new QnaBoardDAO();


count = dbPro.getArticleCount(); //ctrl +마우스 대면 해당 메소드로 이동
count = dbPro.getqnaCount(col, search); //ctrl +마우스 대면 해당 메소드로 이동
// 전체 

// 게시글수(10개)  > 0 
if (count > 0) {                 //    1,       10 
articleList = dbPro.getArticles(startRow, endRow);
articleList = dbPro.getqna(col, search, startRow, endRow);

}

number=count-(currentPage-1)*pageSize; // count(10)-(1-1)*10 = 10

			
	String id =(String)session.getAttribute("memId");
	int status = 0;	// 로그인이 아닌경우 status =  0
	Object obj = session.getAttribute("memSt");	// 로그인인 경우 status를 obj라는 이름으로 가져옴 
	// System.out.println(obj); 입력받은 status 확인
	if(id == null || obj == null)	// id 혹은 status가 입력되지 않은경우. 즉, 비회원
	{
		id = "GUEST";
		// System.out.println("status = " + status); 입력받은 status 확인
	}
	else
	{
		status = (int)obj; // status를 obj(받아온 status) 재설정
	}
%>


<html>
<head>
<title> Q&A 게시판 </title>
<script language="JavaScript" src="script.js"></script>
<jsp:include page="Header.jsp"/> 
</head>


    <h1> Q&A  List</h1>
    
    <%--반품문의 기타문의  class="table table-striped" --%>
    <table width="500" height="70"> 
    <tr>
      <th>
      <a class="btn btn-info" href="qnalist.jsp">전체 문의</a> 
      </th> 
      <th>									<!--  각 버튼 누르면 search 1 2 3 4 로 구분해서 넘어감  -->
      <a class="btn btn-info" href="qrsearchList.jsp?col=subject&search=1">배송 문의</a> 
      </th> 
      <th>
      <a class="btn btn-info" href="qrsearchList.jsp?col=subject&search=2">상품 문의</a>
      </th> 
      <th>
      <a class="btn btn-info" href="qrsearchList.jsp?col=subject&search=3">교환/반품 문의</a>
      </th>
     <th>
      <a class="btn btn-info" href="qrsearchList.jsp?col=subject&search=4">기타</a>
      </th> 
     </tr>
     <tr> </tr>
    </table>
   
    <%-- dto는 하나의 db 정보만...
     dto를 모두 보관하는 array list--%> 
     
       <form action="qrsearch.jsp" method="post">
  		 <select name="col"> 
            <option value="title">제목<option> 
            <option value="writer">작성자<option> 
            <option value="content">내용<option> 
            
   		</select> 
   		<input type="text" name="search" /> 
   		<input type="submit" value="검색" /> 
   </form>
   
   
  
  
  <%if (count == 0) {%>
	<table class="table table-striped">

		<tr>
    		<td align="center">
    			게시판에 저장된 글이 없습니다.
    		</td>
    	</tr>
	</table>

<%}else{%>     

  <table  class="table table-striped">
  <tr>
    <th>번호</th> <th>제목</th> <th>작성자</th>   <th>날짜</th><th>조회수</th>
  </tr>
  <%for (int i = 0 ; i < articleList.size() ; i++) {
	  QnaBoardDTO dto = (QnaBoardDTO)articleList.get(i);
%>

  <tr>
  <td><%=dto.getNum()%></td>
       
  <td> 
     <%int wid=0; 
		      if(dto.getRe_level()>0){
		      	wid=2*(dto.getRe_level()); %>
		  		<img src="images/level.gif" width="<%=wid%>" height="16">
		  		<img src="images/re.gif">
			<%}else{%>
		  		<img src="images/level.gif" width="<%=wid%>" height="16">
			<%}%>
           		 <a href="qcontent.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle() %> 
           	 </a> 
          <% if(dto.getReadcount()>=20){%>
         	<img src="images/hot.gif" border="0"  height="16">
           <%}%> 
  
  </td>
  <td><%=dto.getWriter()%></td>
  <td><%=dto.getReg_date() %></td>
  <td><%=dto.getReadcount()%></td>
    	

   </tr>
     <%}%>
  </table>
<%}%>
  
 
		<%
			if(status == 10){%>
			
			<input type="button" value="글쓰기" onclick="window.location='qwriteForm.jsp'">
		<%}%> 	
<%-- 
<%if(id != null){ %>
    		<a href="qwriteForm.jsp">후기 작성 </a> 
    			<input type="button"  value="후기 작성" onclick="window.location='qwriteForm.jsp'"  />
    		<%}else{ %>
    		<input type="button"  value="로그인하러 가기" onclick="window.location='/jsp/0416/LoginForm.jsp'"  />
    		<%}%>
--%>
<br><br>
  <% 
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		 
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="qrsearch.jsp?pageNum=<%= startPage - 10 %>&col=<%=col%>&search=<%=search%>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        	<a href="qrsearch.jsp?pageNum=<%= i %>&col=<%=col%>&search=<%=search%>">[<%= i %>]</a>
<%		}
        if (endPage < pageCount) {  %>
        	<a href="qrsearch.jsp?pageNum=<%= startPage + 10 %>&col=<%=col%>&search=<%=search%>">[다음]</a>
<%		}
    }
%>
<br />
</html>
</main>
</div>
 <%@ include file ="/userPage/bottom.jsp" %>
     