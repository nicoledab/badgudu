<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	int num = Integer.parseInt(request.getParameter("num")); // 글번호 받기 위함
%>
	<script> // "삭제하시겠습니까" 출력 후 삭제 진행...예 누르면 해당 글번호 삭제/ 아니오 누르면 뒤로
		var re = confirm("<%=num%>번 글을 삭제하시겠습니까?");
		<!--  예/아니오 .. true/false  -->
		if(re){
			window.location="deletePro.jsp?num=<%=num%>";
		}else{	
			history.go(-1);
		}
		
	</script> 