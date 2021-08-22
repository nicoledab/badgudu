<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="otoadmin" align="center">
<%@ include file="../adminAside.jsp" %>
<main>
<html>
<head>
<title>1:1문의</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<jsp:include page="Header.jsp"/>
<%
int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String id = (String)session.getAttribute("memId");
	
	otoBoardDBBean dbPro = new otoBoardDBBean();
	otoBoardDataBean article =  dbPro.getArticle(num, id);
  
	int ref=article.getRef();
	int re_step=article.getRe_step();
	int re_level=article.getRe_level();
%>
<body>  
<center><b>문의내용 보기</b>
<br>
<table class="table-dark " width="900" align="center">  
	<tr height="30">
		<td align="center" width="125" >문의번호</td>
		<td align="center" width="125" align="center"><%=article.getNum()%>
		<input type="hidden" name="otonum" value="<%=article.getNum() %>"/></td>
	    <td align="center" width="125" >문의상태</td>
	    <td align="center" width="125" align="center">
        <%if(article.getReadcount()>0 && article.getRe_level()>0){%>
           <b>문의답변</b>
           <%}else if(article.getReadcount()>0 && article.getRe_level()==0){%>
           <b>문의확인</b>
           <%}else{%>
           <b>문의대기</b> 
           </td>
           <%}%> 
           </td>
   </tr>
  <tr height="30">
	    <td align="center" width="125" >작성자</td>
	    <td align="center" width="125" align="center"><%=article.getWriter()%></td>
	    <td align="center" width="125"  >작성일</td>
	    <td align="center" width="125" align="center"><%= sdf.format(article.getReg_date())%></td>
  </tr>
  
  <tr height="30">
	    <td align="center" width="125" >문의제목</td>
	    <td align="center" width="125" align="center"><%=article.getSubject()%></td>
	    <td align="center" width="125"  >휴대폰번호</td>
	    <td align="center" width="125" align="center"><%=article.getPh() %></td>
  </tr>
  <tr>
	    <td align="center" width="125">문의내용</td>
	    <td align="left" width="375" colspan="3"><pre><%=article.getContent()%></pre></td>
  </tr>
    <tr>
	    <td align="center" width="125">첨부파일</td>
	   <td align="left" width="375" colspan="3"><pre> <img src="/badgudu/save/<%=article.getSave()%>" /> <br />
  </tr>
  <tr height="30">      
	    <td colspan="4" align="right" > 
			<input type="button" value="문의수정" onclick="window.location='otoAdminUpdateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			<input type="button" value="문의삭제" onclick="window.location='otoAdminDeleteForm.jsp?num=<%=article.getNum()%>&otonum=<%=article.getOtonum()%>&pageNum=<%=pageNum%>&re_level=<%=article.getRe_level() %>'">
			<input type="button" value="답변쓰기" onclick="window.location='otoAdminWrite.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
			<input type="button" value="문의목록" onclick="window.location='otoAdminList.jsp?pageNum=<%=pageNum%>'">
	    </td>
  </tr>
</table>
</body>
</html>  
</main>
</div>    
