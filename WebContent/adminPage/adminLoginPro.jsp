<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "admin.dao.adminMemberDAO" %>
<%@ page import = "user.dto.MemberDTO" %>

<h1>loginPro</h1>

<%
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   String ch = request.getParameter("remember2");
   
   Cookie [] cookies = request.getCookies();
   for(Cookie c : cookies){
   	if(c.getName().equals("cooId")){
   		id=c.getValue();
   	}
   	if(c.getName().equals("cooPw")) {
   		pw=c.getValue();
   	}
   	if(c.getName().equals("cooCh")) {
   		ch=c.getValue();
   	}	
   }
   
   //DB 에서 id/pw 입력하여 검색해본다...
   //검색 결과가 나오면 로그인 성공 / 안나오면 로그인 실패
   adminMemberDAO dao = new adminMemberDAO();
   boolean result = dao.adminloginCheck(id,pw);
   int idCode = dao.adminCode(id);
   
   if(idCode==10){
	   if(result==true){
		   if (ch==null) {
			   
				session.setAttribute("memId", id);
				 MemberDTO memberDto = new MemberDTO();
			      
			      memberDto = dao.selectMemberInfo(id);
			      session.setAttribute("memId", id);
			      session.setAttribute("memSt", memberDto.getStatus());   // status
			      response.sendRedirect("adminMain.jsp");
				
				}else{
					
					session.setAttribute("memId", id);
					Cookie coo1 = new Cookie("cooId", id);  // 쿠 cooId , 값-id 
					coo1.setMaxAge(6000);  //쿠키 유효기간 설정  60초후 쿠키 자동삭제
					response.addCookie(coo1);
					
					Cookie coo2 = new Cookie("cooPw", pw);
					coo2.setMaxAge(6000);  //쿠키 유효기간 설정  60초후 쿠키 자동삭제
					response.addCookie(coo2);
					
					Cookie coo3 = new Cookie("cooCh", ch);
					coo3.setMaxAge(6000);  //쿠키 유효기간 설정  60초후 쿠키 자동삭제
					response.addCookie(coo3); // 사용자에 전달
					
					 MemberDTO memberDto = new MemberDTO();
				      memberDto = dao.selectMemberInfo(id);
				      session.setAttribute("memSt", memberDto.getStatus());   // status
				      response.sendRedirect("adminMain.jsp");
				}
		     
		%>
		<% }else if(result==false){ %>
		      <script>
		         alert("id/pw 를 확인하세요");
		         history.go(-1);

		      </script>

		<% }
   } else if(idCode==1||idCode==2||idCode==3){ %>
	   <script>
		alert("현재는 BadGudu의 관리자 페이지입니다.\n고객님은 쇼핑몰로 이동해서 로그인해주세요.");
		history.go(-1);
		</script> <%
   } else {  %>
	   <script>
       alert("id/pw 를 확인하세요");
       history.go(-1);

    	</script> <%
   }
   
%>