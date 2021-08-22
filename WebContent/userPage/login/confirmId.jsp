<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.dao.MemberDAO" %>

    <h1>아이디 중복검사</h1>
<% 
	String id =request.getParameter("id");
	MemberDAO dao= new MemberDAO();
	boolean result = dao.confirmId(id);
	if(result) { %>
		<h1> 입력한 [<%=id%>] 사용중입니다</h1>
		<input type="button" value="close" onclick="test()" />
	<%}else {%>
		<h1> 입력한 [<%=id%>] 사용 가능합니다</h1>
		<input type="button" value="close" onclick="test2()" />
	<% } %>
 
  
  <script>
  function test(){
		opener.document.signUp.id.value="";
		opener.document.signUp.id.focus();
		self.close();
	}
  function test2(){
	  self.close();
  }
  	
  </script>
  
   	
   	