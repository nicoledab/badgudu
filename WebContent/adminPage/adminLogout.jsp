<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>logout</h1>
<%
session.invalidate();

Cookie [] cookies = request.getCookies();
for(Cookie c : cookies){
	if(c.getName().equals("cooId")){
		c.setMaxAge(0);  
		response.addCookie(c);
	}
	if(c.getName().equals("cooPw")) {
 		c.setMaxAge(0);  
		response.addCookie(c);
	}
	if(c.getName().equals("cooCh")) {
 		c.setMaxAge(0);  
		response.addCookie(c);
	}	
}
	response.sendRedirect("adminMain.jsp");
%>