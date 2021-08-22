<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  String passwd = request.getParameter("passwd");

  otoBoardDBBean dbPro = new otoBoardDBBean();
  int check = dbPro.passwdCheck(num, passwd);

  if(check==1){%>
	  <meta http-equiv="Refresh" content="0;url=content.jsp?num=<%=num%>&pageNum=<%=pageNum%>" >
<%}else{%>
       <script language="JavaScript">         
         alert("비밀번호가 맞지 않습니다");
         history.go(-1);
      </script>
<%}%>