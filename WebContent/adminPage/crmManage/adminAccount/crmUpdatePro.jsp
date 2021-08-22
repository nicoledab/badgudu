<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "user.dao.MemberDAO" %>
<%@ page import = "user.dto.MemberDTO" %>
<%@ page import = "java.sql.Timestamp" %>

<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="article" scope="page" class="user.dto.MemberDTO" />
<jsp:setProperty name="article" property="*"/>

<%
String pageNum = request.getParameter("pageNum");

	MemberDAO dbPro = new MemberDAO();
    int check = dbPro.updateArticle(article);  

    if(check==1){
%>
	  <meta http-equiv="Refresh" content="0;url=crmForm.jsp?pageNum=<%=pageNum%>" >
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

 