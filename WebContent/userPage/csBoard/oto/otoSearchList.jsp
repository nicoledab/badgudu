<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
request.setCharacterEncoding("UTF-8");

	String col = request.getParameter("col");
	String search = request.getParameter("search");

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
    
    count = dbPro.getArticleCount(col,search);
    
    if (count > 0) {
        articleList = dbPro.getArticles(col,search,startRow, endRow);
    }

	number=count-(currentPage-1)*pageSize;  
	
	String id = (String)session.getAttribute("memId");
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<center><b>글목록(전체 글:<%=count%>)</b>
<table width="700">
	<tr>
    	<td align="right">
    		<%
    		if(id != null){
    		%>
    			<a href="otoWrite.jsp">글쓰기</a>
    			<a href="otoUserList.jsp">나의 작성글 목록</a>
    		<%
    		}else{
    		%>
    			<a href="/badgudu/member/loginForm.jsp">로그인후 글쓰기</a>
    		<%
    		}
    		%>
    	</td>
    </tr>
</table>

<%
if (count == 0) {
%>
	<table width="700" border="1" cellpadding="0" cellspacing="0">
		<tr>
    		<td align="center">
    			게시판에 저장된 글이 없습니다.
    		</td>
    	</tr>
	</table>

<%
} else {
%>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
	<tr height="30" > 
		<td align="center"  width="50"  >번 호</td> 
		<td align="center"  width="250" >제   목</td> 
	    <td align="center"  width="100" >작성자</td>
	    <td align="center"  width="150" >작성일</td> 
	    <td align="center"  width="50" >조 회</td> 
	    <td align="center"  width="100" >IP</td>    
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
		  		<img src="images/level.gif" width="<%=wid%>" height="16">
		  		<img src="images/re.gif">
			<%}else{%>
		  		<img src="images/level.gif" width="<%=wid%>" height="16">
			<%}%>
     		 <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           		<%=article.getSubject()%>
           	 </a> 
          <% if(article.getReadcount()>=20){%>
         	<img src="images/hot.gif" border="0"  height="16">
           <%}%> 
		</td>
		
		
		
		
    	<td align="center"  width="100"> 
			<a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a>
		</td>
    	<td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
    	<td align="center"  width="50"><%=article.getReadcount()%></td>
    	<td align="center" width="100" ><%=article.getIp()%></td>
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
<%		}
        if (endPage < pageCount) {  %>
        	<a href="otoUserList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%		}
    }
%>
		<form action="otoSearchList.jsp" method="post">
			<select name="col">
				<option value="subject">제목</option>
				<option value="writer">작성자</option>
			</select>
			<input type="text" name="search" />
			<input type="submit" value="검색" />
		</form>
</center>
</body>
</html>
