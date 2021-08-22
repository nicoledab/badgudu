<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "admin.dao.adminMemberDAO" %>
<%@ page import = "user.dto.MemberDTO" %>

<h1>loginPro</h1>

<%
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   
   //DB 에서 id/pw 입력하여 검색해본다...
   //검색 결과가 나오면 로그인 성공 / 안나오면 로그인 실패
   adminMemberDAO dao = new adminMemberDAO();
   boolean result = dao.adminloginCheck(id,pw);
   
   if(result){
      MemberDTO memberDto = new MemberDTO();
      
      memberDto = dao.selectMemberInfo(id);
      session.setAttribute("memId", id);
      session.setAttribute("memSt", memberDto.getStatus());   // status
      response.sendRedirect("../adminMain.jsp");
%>
<% }else{ %>
      <script>
         alert("id/pw 를 확인하세요");
         history.go(-1);

      </script>

<% } %>