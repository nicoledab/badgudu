<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "user.dao.otoBoardDBBean" %>
<%@ page import = "user.dto.otoBoardDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
request.setCharacterEncoding("UTF-8");
%>

<%
int num = Integer.parseInt(request.getParameter("num"));
int otonum = Integer.parseInt(request.getParameter("otonum"));
int level = Integer.parseInt(request.getParameter("level"));
  String pageNum = request.getParameter("pageNum");
  String passwd = request.getParameter("passwd");

  int check = 0;
  
  otoBoardDBBean dbPro = new otoBoardDBBean();
  if(level==0){
	 check = dbPro.deleteArticle(num, passwd); // 원글+답글 함께 삭제.	  
  } else if(level != 0){
	 check = dbPro.deleteArticleOne(num, passwd);
  }

  if(check==1){
%>
	  <meta http-equiv="Refresh" content="0;url=otoUserList.jsp?pageNum=<%=pageNum%>" >
<%}else{%>
       <script language="JavaScript">         
         alert("비밀번호가 맞지 않습니다");
         history.go(-1);
      </script>
<%}%>