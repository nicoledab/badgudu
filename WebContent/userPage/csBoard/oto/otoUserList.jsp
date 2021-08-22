<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
	String id = (String)session.getAttribute("memId");

    int pageSize = 10;  // 한페이지에 보여질 게시물수
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); // 작성날짜 해당 형식으로 보기위함  아래 91라인에서 sdf.format(article.getReg_date()) 사용 

    String pageNum = request.getParameter("pageNum");  // 리스트에서 페이지번호 클릭시 받을수있다. 
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);  // 1
    int startRow = (currentPage - 1) * pageSize + 1;  // (1-1) * 10 + 1 = 11
    int endRow = currentPage * pageSize;  // 1 * 10 = 10
    int count = 0;  // 전체 게시물수.. 
    int number=0;  // 화면 글번호 

    List articleList = null;
    otoBoardDBBean dbPro =new otoBoardDBBean();
    
    count = dbPro.userGetArticleCount(id); // id 값이 같은 사람만 보임. 
    
    if (count > 0) {
        articleList = dbPro.userGetArticles(id,startRow, endRow);
    }

   number=count-(currentPage-1)*pageSize;  
   
//   String id = (String)session.getAttribute("memId");
%>
<%@ include file ="../../top.jsp" %>

<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../aside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">
<jsp:include page="Header.jsp"/>


<main>
					<h1>1:1문의</h1> <br /> 
					<p>궁금하신 점은 1:1 문의를 남겨주세요. 친절하게 답변 드리겠습니다.</p>
					<p>평일 09:00 ~ 18:00/ 토요일 09:00 ~ 13:00 (일요일/공휴일 휴무)</p>
					<p>궁금하신 점은 1:1 문의를 남겨주세요. </p>
					<p>(1:1 문의는 로그인 후 문의 가능합니다.)</p>
					<!-- <p>문의 남겨주시면 고객님의 이메일 또는 휴대폰 번호로 빠르게 답변 드리겠습니다. </p> -->
					<p>간단한 문의라면 문의주시기 전에 자주 묻는 질문을 먼저 체크해보세요.</p>
<title>1:1문의페이지</title>
<html>
<head>

</head>

<br /> <br /> 
<center><h3>(전체 글:<%=count%>)</h3>
<table width="700">
   <tr>
		<td align="right">
          <%
          if(id != null){
          %>
             <a href="otoWrite.jsp">1:1 문의하기</a>
          <%
          }else{
          %>
             <a href="/badgudu/userPage/user/LoginForm.jsp">로그인후 글쓰기</a>
          <%
          }
          %>
       </td>
    </tr>
</table>

<%
if (count == 0) {
%>
   <table class="table   table-bordered">
		<tr>
    		<td align="center">
    			작성된 문의가 없습니다. 
    		</td>
    	</tr>
	</table>


<%
} else { // border="1" width="700" cellpadding="0" cellspacing="0" align="center"
%>
<table class="table  table-dark  table-hover"> 
   	<tr height="30" > 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제   목</td> 
       <td align="center"  width="100" >작성자</td>
       <td align="center"  width="150" >작성일</td> 
       <td align="center"  width="50" >문의 상태</td>   
    </tr>
<%
for (int i = 0 ; i < articleList.size() ; i++) {
    	otoBoardDataBean article = (otoBoardDataBean)articleList.get(i);
%>
	<tr height="30">
    	<td align="center"  width="50" > <%=number--%></td>
    	<td  width="250" >
			<%int wid=0; 
		      if(article.getRe_level()>0){
		      	wid=15*(article.getRe_level()); %>
		  		<img src="images/re.gif">
			<%}else{%>
			<%}%>
     		 <a href="otoContent.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           		<%=article.getSubject()%>
           	 </a> 
		</td>	
    	<td align="center"  width="100"> 
			<%=article.getWriter()%></a>
		</td>
    	<td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
       <td align="center"  width="50">
       
        <%if(article.getRe_level()>0){%>
           <b>문의답변</b>
           <%}else if(article.getReadcount()>0 && article.getRe_level()==0){%>
           <b>문의확인</b>
           <%}else{%>
           <b>문의대기</b> 
           </td>
           <%} %>
   </tr>
    <%}%>
</table>
<%}%>


<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
       
        int startPage = (int)(currentPage/10)*10+1;
      int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) 
           endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="otoUserList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
           <a href="otoUserList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%      }
        if (endPage < pageCount) {  %>
           <a href="otoUserList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%      }
    }
%>
</center>
</body>
</html>
</main>
</div>