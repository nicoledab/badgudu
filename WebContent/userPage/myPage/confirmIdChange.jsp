<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.dao.myPageDAO" %>

    <h1>아이디 중복검사</h1>
<% 
	String id =request.getParameter("id");
	myPageDAO dao= new myPageDAO();
	boolean result = dao.confirmIdChange(id);
	if(result) { %>
		<h1> 입력한 [<%=id%>] 사용중입니다</h1>
		<input type="button" value="close" onclick="confirmId1()" />
	<%}else {%>
		<h1> 입력한 [<%=id%>] 사용 가능합니다</h1>
		<input type="button" value="close" onclick="confirmId2()" />
	<% } %>
  
 <script>
 function confirmId1(){
		opener.document.changeId.id.value="";
		opener.document.changeId.id.focus();
		self.close();
	}
  function confirmId2(){
	  self.close();
  }
  	
  </script>