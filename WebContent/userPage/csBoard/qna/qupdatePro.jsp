<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "user.dao.QnaBoardDAO" %>
<%@ page import = "user.dto.QnaBoardDTO" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>   


    
<h1>QNA updatepro  </h1>

<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="article" scope="page" class="user.dto.QnaBoardDTO" />
 <jsp:setProperty name="article" property="*"/>


  <% String enc = "UTF-8"; //한글 인코딩 
  int num = Integer.parseInt(request.getParameter("num"));    
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	//article.setIp(request.getRemoteAddr());
    
	//QnaBoardDTO dto = new QnaBoardDTO();
	//dto.setNum(num);
	
    QnaBoardDAO dbPro = new QnaBoardDAO();
    dbPro.updateqnaBoard(article);
      
   // response.sendRedirect("qnalist.jsp");
    
%>

<script>
  alert("수정되었습니다!");
  window.location="qcontent.jsp?num=<%=num%>";
</script>

