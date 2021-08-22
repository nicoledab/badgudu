<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import="user.dao.noticeDAO" %>
<%@ page import="user.dto.noticeDTO" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<link href="/badgudu/adminPage/loginStyle.css" rel="stylesheet" type="text/css">
<%@ include file ="../../adminTop.jsp" %>
<div class="cs" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../../adminAside.jsp" %>

<link href="../csBoard.css" rel="stylesheet" type="text/css">
<jsp:include page="Header.jsp"/>

<main>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
	noticeDAO dbPro = new noticeDAO();
	noticeDTO article =  dbPro.getArticle(num);
%>
<body>  
<center><h1>글내용 보기</h1>
<br /><br />
<table class="table-dark " width="900" align="center">  
	<tr height="30">
		<td align="center" width="125" >글번호</td>
		<td align="center" width="125" align="center"><%=article.getNum()%></td>
	    <td align="center" width="125" >조회수</td>
	    <td align="center" width="125" align="center"><%=article.getReadcount()%></td>
  </tr>
  <tr height="30">
	    <td align="center" width="125" >작성자</td>
	    <td align="center" width="125" align="center"><%=article.getWriter()%></td>
	    <td align="center" width="125" >작성일</td>
	    <td align="center" width="125" align="center"><%= sdf.format(article.getReg())%></td>
  </tr>
  <tr height="30">
		<td align="center" width="125" >글제목</td>
		<td align="center" width="375" align="center" colspan="3"><%=article.getSubject()%></td>
  </tr>
  <tr>
	    <td align="center" width="125" >글내용</td>
	    <td align="left" width="375" colspan="3">
	    <pre><%=article.getContent()%></pre>
	    <%if(article.getSave() != null){%>	<!-- 이미지가 없으면 안나타남 -->
	    	<img width="375" src="${pageContext.request.contextPath}\userPage\csBoard\notice\img\<%=article.getSave()%>"/>
	    
    	<%}%>
	    
	    </td>
  </tr>
  <tr height="30">      
	    <td colspan="4" align="right" > 
	    	
			<%
				int status = 0;	// status = 로그인이 아닌경우 0
				Object obj = session.getAttribute("memSt");	// 로그인인 경우 status를 obj라는 이름으로 가져옴
				if(obj != null)	// obj 값을 가져오면 status에 넣는다.
				{
					status = (int)obj;
				}
				if(status == 10){%>
						<input type="button" value="글수정" onclick="window.location='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
						<input type="button" value="글삭제" onclick="window.location='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
					<%}%>


			<input type="button" value="글목록" onclick="window.location='notice.jsp?pageNum=<%=pageNum%>'">
	    </td>
  </tr>
</table>
</body>
</html>      
</main>
</div>


