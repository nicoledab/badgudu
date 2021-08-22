<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.dao.UserMenuDAO" %>
    <%@ page import = "user.dto.UserMenuDTO" %>
    <%@ page import = "java.util.*" %>
   <% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<title>order Form</title>
<%@ include file ="/userPage/top.jsp" %>

<div id="product" align="center">

<%--  유의점 !!!
1.  장바구니에 4개 상품이 들어있어도 개별 상품에 들어가 주문하기 클릭을 하면,
       그 상품만 주문이 된다는것. --%>

</head>


<%  
   
	//아이디 받기
   String id = (String)session.getAttribute("memId");
   String name = (String)session.getAttribute("name");
   
	//상품 코드 받기
	String productCode = request.getParameter("pdCode");
	if (productCode == null) {
		productCode = "0";
		}
	int pdCode = Integer.parseInt(productCode);
	
	//상품정보 가져오기
	UserMenuDAO dao = new UserMenuDAO();
	String productImg1 = dao.getCateThumbImg(pdCode); //이미지 가져오기
	UserMenuDTO dto = dao.productInfo(pdCode); //상품이름, 가격 가져오기
	
	
	/*
	List size = null; 
	List color = null; 
	size = dao.pdSize(pdCode);
	color = dao.pdColor(pdCode); //상품 옵션 가져오기
  */
	
	
	
	
if(id == null){
 %>
     <script type="text/javascript"> 
       alert("주문을 하려면 로그인이 필요합니다!");  //User1   12345 
       window.location='/badgudu/userPage/login/loginForm.jsp';   
    
       function check(){
    	   
    	   
       }
       
       
       </script>
     
<%}%>

<script>
/*
//새로운 주소 종류 클릭시 나오는 text.
function drawText()
{
    var found = null;
    var sel = document.getElementsByName("info"); // info 이름을 가진 모든 태그를 찾는 코드
    var img = document.getElementById("text"); // 찾고자하는 id 값을 찾는 코드 
 
    for(var i=0; i<sel.length; i++) 
    {
        if(sel[i].checked == true) 
        {
            found = sel[i];
            break; 
        }
    }
    img.src = found.value;*/
}

</script>


<%  
	 //주문폼 

%>

<body>
<form action="orderlist.jsp" id="orderform" name="orderform" method="post"
onsubmit="return check()">


	<h1> 주문서작성 </h1>
	<hr color="black"> <%-- 수평선 긋기 --%>
	 
	<table width="800">
	<tr> 
	<th>선택 </th> <th> 이미지/ 상품명 / 옵션정보 </th> <th> 단가 </th> <th> 수량 </th> <th> 합계 </th> <th> 삭제 </th>
	 </tr>
	 
	 <tr>  <%--<%=dto.getProductName() %>  --%>
	 <td></td>  
	 <td> <%=dto.getProductName() %>/<%=dto.getColor() %> / <%=dto.getSize() %> </td> <td> </td> <td> </td> <td> </td> <td> </td> 
	 </tr>
	 
	 <tr> 
	 <td> 기본배송 </td> <td></td> <td>상품구매금액 </td> <td> 합계 </td>
	  </tr>
	
	</table> 
	<br /> <br /> <br /> <hr>
	 <button type="submit" class="btn btn-danger" style="float: left;" >선택 삭제</button>	
	 <button type="submit" class="btn btn-danger" style="float: right;"  onClick="history.go(-1)">돌아가기</button>	
	 
	<br> <br> <br> 
	<h1> 배송정보 </h1>
	<hr color="black"> 
	 <table width="1000"> 
	 
	 <tr> 
	 <th>배송지 선택</th> 
	 <td>  <input type="radio" name="info" value="sameinfo" onchange="drawText()" checked> 회원정보와 동일 </td>
	 <td>  <input type="radio" name="info" value="sameinfo" onchange="drawText()"> 새로운 배송지 주소 </td>
	 <%-- 
	 div 방식..... 
	<td> <input type="radio" name="info" onclick="showDiv('newAdd');" value="newinfo"> 새로운 배송지 </td>--%>
	
	 </tr>
	 
	 
	<tr>
	  <td>
	  			<div id="newAdd" style='visibility:hidden' > 
	 				 <input type="text" name="newAdd">
	         		   <input type="text" name="newAdd2">
			  </div>
	  </td> 
	 
	 </tr> 
	
 
	 
	 <tr>
	 <th>받으시는 분</th> <td> <%=id%> </td>
	 </tr>
	 <tr>
	 <th>주소 </th> <td>  text </td> <td>  text </td>
	 </tr>
	
	 </table>
	 
	 	<br> <br> <br> 
	<h1> 결제수단 </h1>
	<hr color="black"> 
	 <input type="radio" name="paymt" value="newinfo" checked> 카드 결제 &emsp;
	 <input type="radio" name="paymt" value="newinfo"> 무통장 입금 &emsp;
	 <input type="radio" name="paymt" value="newinfo"> 휴대폰 결제 &emsp;
	 <input type="radio" name="paymt" value="newinfo"> 실시간 계좌이체 &emsp;
	 
	 <hr color="black"> 
	 <h2> 결제 예정 금액: </h2> 
	<br /> <br />
	 
	 <button type="submit" class="btn btn-danger" style="height:70px; width:300px; font-size: 18px;">
        		결제 하기                                                                                                                                              
        	</button>
	 
	 


</form>	
</body>
<%@ include file ="/userPage/bottom.jsp" %>
</html>