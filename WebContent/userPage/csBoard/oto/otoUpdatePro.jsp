<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="article" scope="page" class="user.dto.otoBoardDataBean" />
<jsp:setProperty name="article" property="*"/>

<%
String pageNum = request.getParameter("pageNum");

	otoBoardDBBean dbPro = new otoBoardDBBean();
    int check = dbPro.updateArticle(article);

    if(check==1){
%>
	  <meta http-equiv="Refresh" content="0;url=otoUserList.jsp?pageNum=<%=pageNum%>" >
<% }else{%>
      <script language="JavaScript">      
      <!--      
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
      -->
     </script>
<%
    }
 %>  

 