<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<link href="/badgudu/adminPage/loginStyle.css" rel="stylesheet" type="text/css">

<%@ include file="../adminTop.jsp" %>
<div class="otoadmin" align="center">
<%@ include file="../adminAside.jsp" %>
<main>

					<h2>1:1문의</h2>
					<p>궁금하신 점은 1:1 문의를 남겨주세요. 친절하게 답변 드리겠습니다.</p>
					<p>평일 09:00 ~ 18:00/ 토요일 09:00 ~ 13:00 (일요일/공휴일 휴무)</p>
					<p>궁금하신 점은 1:1 문의를 남겨주세요. </p>
					<p>(1:1 문의는 로그인 후 문의 가능합니다.)</p>
					<!-- <p>문의 남겨주시면 고객님의 이메일 또는 휴대폰 번호로 빠르게 답변 드리겠습니다. </p> -->
					<p>간단한 문의라면 문의주시기 전에 자주 묻는 질문을 먼저 체크해보세요.</p>

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
    
    count = dbPro.getArticleCount();
    
    if (count > 0) {
        articleList = dbPro.getArticles(id, startRow, endRow);
    }
    

	number=count-(currentPage-1)*pageSize;  
	
%>


<html>
<head>
<title>1:1문의게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="Header.jsp"/>
<body>
<center><b>(전체 글:<%=count%>)</b>

<%
if (count == 0) {
%>
   <table class="table-dark  table-hover " width="1200" align="center">
      <tr>
          <td align="center">
             게시판에 작성된 문의가 없습니다.
          </td>
       </tr>
   </table>


<%
} else {
%>
<table class="table-dark  table-hover " width="1200" align="center"> 
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
			<%
			int wid=0; 
					      if(article.getRe_level()>0){
					      	wid=15*(article.getRe_level());
			%>
		  		<img src="images/re.gif">
			<%
			}else{
			%>
			<%
			}
			%>
     		 <a href="otoAdminContent.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           		<%=article.getSubject()%>
           	 </a> 
		</td>	
    	<td align="center"  width="100"> 
			<%=article.getWriter()%></a>
		</td>
    	<td align="center"  width="150"><%=sdf.format(article.getReg_date())%></td>
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
        <a href="otoAdminList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
        	<a href="otoAdminList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%		}
        if (endPage < pageCount) {  %>
        	<a href="otoAdminList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%		}
    }
%>

</center>
</body>
</html>
</main>
</div>