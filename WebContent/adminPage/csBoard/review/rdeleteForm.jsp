<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1> 후기 삭제 </h1>

<% 
   String num = request.getParameter("num");
  //숫자를 받는다 
		
%>

//삭제하시겠습니까?" 출력 후 삭제 진행 
<script> 
	var re = confirm("<%=num%>번 글을 삭제하시겠습니까?");
	// confirm - 확인/ 취소 버튼 있음 
     //alert는 확인 버튼만 나옴 
     
     if(re){
    	 window.location="rdeletePro.jsp?num=<%=num%>";
     } else{
    	 history.go(-1); 
     }
     
     
     
</script>