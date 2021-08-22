<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="article" scope="page" class="user.dto.otoBoardDataBean" />
<jsp:setProperty name="article" property="*"/>

<%
article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	article.setIp(request.getRemoteAddr());

    otoBoardDBBean dbPro = new otoBoardDBBean();
    dbPro.insertArticle(article);

    response.sendRedirect("otoUserList.jsp");
%>
