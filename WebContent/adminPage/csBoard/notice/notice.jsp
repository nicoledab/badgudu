<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import="user.dao.noticeDAO" %>
<%@ page import="user.dto.noticeDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<link href="/badgudu/adminPage/loginStyle.css" rel="stylesheet" type="text/css">
<%@ include file ="../../adminTop.jsp" %>
<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../adminAside.jsp" %>
<%
    int pageSize = 10;	// 한 페이지에 보여질 게시물 수 
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	// 작성된 날짜의 형태를 바꿔줌.. 년-월-일 시:분.. 84라인에서 사용(sdf.format(article.getReg_date()))

    String pageNum = request.getParameter("pageNum");	// 리스트에서 페이지 번호를 클릭 시 받을 수 있다.(페이지를 처음에 클릭하지 않는다.)
    if (pageNum == null) {	// 페이지를 입력 안하면 1페이지.. 입력하면 null이 아니므로 if문 동작하지않는다.
        pageNum = "1";
    }
	// 페이지 내에서 보여질 게시물 갯수 계산 관련 
    int currentPage = Integer.parseInt(pageNum);		// 1.. 문자(string)타입으로 들어오니 변환
    int startRow = (currentPage - 1) * pageSize + 1;	// (1-1) * 10 + 1 = 1
    int endRow = currentPage * pageSize;				// 1 * 10 = 10
    int count = 0;	// 전체 게시물 수
    int number=0;	// 화면에 보이는 게시물 번호.. 입력한 번호와 다르다..삭제 시 시퀀스는 빈 번호를 채우지 않는다.. 즉, 내장된 번호가 아닌 보이는 번호

    List articleList = null;
    noticeDAO dbPro =new noticeDAO();
    count = dbPro.getArticleCount(); // 전체 게시물 수를  dbPro의 ArticleCount() 메서드에서 가져옴
    if (count > 0) {
        articleList = dbPro.getArticles(startRow, endRow);
    }

	number=count-(currentPage-1)*pageSize;	// 전체 게시물 수 - (페이지 - 1) * 10  = 
			

	String id = (String)session.getAttribute("memId");
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


<jsp:include page="Header.jsp"/>

<main>
<html>
<head>
<title>공지사항</title>
<link href="/userPage/style.css" rel="stylesheet" type="text/css">
</head>
<body">
<center><h1>공지사항</h1> <br /> (전체 글:<%=count%>)<br /><br />

<%if (count == 0) {%>
	<table width="700" border="1" cellpadding="0" cellspacing="0">
		<tr>
    		<td align="center">
    			게시판에 저장된 글이 없습니다.
    		</td>
    	</tr>
	</table>

<%  } else {    %>
<br /> <br /> 
<table class="table-dark  table-hover " width="1200" align="center"> 	<!-- border="1" width="700" cellpadding="0" cellspacing="0" align="center"줄마다의 여백 등의 옵션..디자인 -->
	<tr height="30"> 
		<td align="center"  width="50"  >번호</td> 
		<td align="center"  width="250" >제목</td> 
	    <td align="center"  width="100" >작성자</td>
	    <td align="center"  width="150" >작성일</td>
	    <td align="center"  width="50" >조회수</td> 
    </tr>
<%	for (int i = 0 ; i < articleList.size() ; i++) {
	noticeDTO article = (noticeDTO)articleList.get(i);
%>
	<tr height="30">
    	<td align="center"  width="50" > <%=number--%></td>
    	<td  width="250" >
     		 <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
           		<%=article.getSubject()%>
           	 </a> 
		</td>
    	<td align="center"  width="100"> 
    	<%=article.getWriter()%>
		</td>
    	<td align="center"  width="150"><%= sdf.format(article.getReg())%></td>	<!-- 날짜.. 포맷형태 -->
    	<td align="center"  width="50"><%=article.getReadcount()%></td>
	</tr>
    <%}%>
    
    
    <tr height="30">      
	    <td colspan="5" align="right" > 
		<%
			if(status == 10){%>
			
			<input type="button" value="글쓰기" onclick="window.location='writeForm.jsp'">
		<%}%>
		</td>
	</tr>
</table>
<%}%>

<%
    if (count > 0) {								// 삼항연산자
    	// 전체 게시물/10개(한페이지에서 보여지는 최대 게시물 수) + (전체 게시물/10의 나머지 값이 0이면 0 아니면 1)
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1); 
     	// 페이지를 int형으로 줘서 currentPage/10의 소숫점아래는 버리고 10페이지 단위로 자르기 위함 ex) 현재 5페이지인 경우 (5/10)*10+1 = 1 										
        int startPage = (int)(currentPage/10)*10+1;	
		int pageBlock=10;	// 페이지 갯수를 10개로 컷한다.
        int endPage = startPage + pageBlock-1;	// 10개 컷으로 하나의 페이지.. 10페이지부터 20페이지..ex) 페이지가 5인경우.. 1+10-1 = 10
        if (endPage > pageCount) endPage = pageCount;	// 마지막페이지가 열리는 페이지보다 큰 경우.. endPage에 열리는 페이지를 대입한다.
        
        if (startPage > 10) {    %>
        <a href="notice.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>			<!-- page가 돌아간다 -->
        	<a href="notice.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%		}
        if (endPage < pageCount) {  %>
        	<a href="notice.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%		}
    }
%><br>

	<form action = "searchList.jsp" method = "post">
		<select name = "col">
			<option value = "subject">제목</option>
			<option value = "content">내용</option>
		</select>
		<input type = "text" name = "search"/>
		<input type = "submit" value="검색"/>
	</form>
</center>
</body>
</html>
</main>
</div>
