<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="user.dao.UserMenuDAO" %>
<html>

	<style> 
 	 .one { font-family: serif; }
 	 
 	</style>
<div id=top>
<body>
 
    <!-- 세션을 이용한 로그인 처리 -->
    <!-- 세션으로 받아온 값은 오브젝트 타입이기 때문에 String 타입으로 컨버팅 한다. -->
    
    
 <%-- 얘가 없으면 잘됨. --%>
    <% 
    String Mid = (String) session.getAttribute("memId");
    String MidPw = null;
    String MidCh = null;
    
 
    //로그인이 되어있지 않다면 id에 "GUEST"값을 준다
    if(Mid==null)
    {
    	// 여기서 쿠키 확인
    	Mid="GUEST";
    	
    	//만들어진 쿠키 확인하는 코드 
    	// 쿠키 는 여러가지 만들수있기때문에. 쿠키를 모두 다 꺼내서 
    	// 로그인시 내가 만든 쿠키를 비교해서 찾아야됨  그래서
   	    
    	if (Mid!=null && MidPw!=null && MidCh!=null) {
    		response.sendRedirect("loginPro.jsp");
    	}
	}
  
    UserMenuDAO tdao = new UserMenuDAO();
    int st = tdao.checkMember(Mid);
    
    
%>

 
    <table width="1550" >
    <tr>
    	<td colspan='6' align='center' onclick="location.href='/badgudu/userPage/main.jsp'" style="cursor:pointer;"> 
    		<img src="/badgudu/productImg/로고.jpg" style="width:250px;">
   		</td>
   	</tr>
   	<tr>
    	<td colspan="6" align="right">
    		<b>[<%=Mid%>]</b>님 반갑습니다.
       </td>
    </tr> 
        <%
        if(st==0){%>
        	 <tr height="30">    
       			 <td align="right" width="1000" bgcolor="white"></td>
         		 <td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3">  <a
                     href="\badgudu\userPage\login\loginForm.jsp" style="text-decoration: none">  로그인  </a></font>
            	</td>
 
            	<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="\badgudu\userPage\login\signUp.jsp" style="text-decoration: none"> 회원가입 </a></font>
            	</td>
             </tr>
        <%} else if(st==10){ %>
        	<tr height="30">    
        		<td align="right" width="600" bgcolor="white"></td>
          		<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3">  <a
                     href="\badgudu\userPage\login\logout.jsp" style="text-decoration: none">  로그아웃  </a></font>
            	</td>
            	<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="\badgudu\userPage\myPage\myPageMain.jsp" style="text-decoration: none"> 마이페이지 </a></font>
            	</td>
 
            	<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="#" style="text-decoration: none"> 주문내역 </a></font>
           		</td>
 
           		<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="/badgudu/userPage/order/cartView.jsp" style="text-decoration: none"> 장바구니 </a></font>
            	</td>
            	<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="/badgudu/adminPage/adminMain.jsp" style="text-decoration: none"> 관리자페이지로 </a></font>
            	</td>
        </tr>
        <%} else {%>
        	 <tr height="30">    
        		<td align="right" width="800" bgcolor="white"></td>
          		<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3">  <a
                     href="\badgudu\userPage\login\logout.jsp" style="text-decoration: none">  로그아웃  </a></font>
            	</td>
            	<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="\badgudu\userPage\myPage\myPageMain.jsp" style="text-decoration: none"> 마이페이지 </a></font>
            	</td>
 
            	<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="\badgudu\userPage\orderDetail\MyOrderListNew.jsp" style="text-decoration: none"> 주문내역 </a></font>
           		</td>
 
           		<td align="right" width="200" bgcolor="white">
                <!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="3"><a
                    href="/badgudu/userPage/order/cartView.jsp" style="text-decoration: none"> 장바구니 </a></font>
            	</td>
        </tr>
        <%}%>
    </table>
    <hr color="888888" size="2"> 
</body>
</html>
</div>
