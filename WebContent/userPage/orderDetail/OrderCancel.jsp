<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <% request.setCharacterEncoding("UTF-8");%>
<% int odcode = Integer.parseInt(request.getParameter("odcode")); 

%>

<script> 


	function OrderDelete(){
		 var re = confirm("정말로 주문을 취소하시겠습니까 ? ");
	     if(re){
	    	 window.location="OrderCancelPro.jsp?odcode=<%=odcode%>";
	     } else{
	    	 return false;
	     }
	     
	}

</script>
<script>OrderDelete();</script>