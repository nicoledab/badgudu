<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.dao.UserMenuDAO" %>
    <%@ page import = "user.dto.UserMenuDTO" %>
    <%@ page import = "user.dao.CartDAO" %>
    <%@ page import = "user.dto.CartDTO" %>
    <%@ page import = "java.util.*" %>
    <%@ page import = "user.dao.OrderDAO" %>
    <%@ page import = "user.dto.OrderDTO" %>
    <%@ page import = "user.dto.OrderDetailDTO" %>
    <%@ page import = "admin.dto.StockDTO" %>
    
   <% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<title>order Form</title>
<%@ include file ="/userPage/top.jsp" %>
<div id="product" align="center">
</head>

<%	
	String id = (String)session.getAttribute("memId");  
	String name = (String)session.getAttribute("name"); 
	
	// 선택한 상품을 배열로 받음..  
	String [] cart_no = request.getParameterValues("cart_no");
	
	CartDAO dao = new CartDAO();
	OrderDAO odao = new OrderDAO();
	
	 // 배열로 받은 선택상품을 db 에서 가져옴 
	List cart = dao.getOrderCart(cart_no); 
	int orderAmount = 0;

	if(id == null){
%>
  <script type="text/javascript"> 
       alert("주문을 하려면 로그인이 필요합니다!");  //User1   12345 
       window.location='/badgudu/userPage/login/loginForm.jsp';   
       function check(){
       }
       </script>
     
<%}

%>


<script>
function sp(){
	alert("상품 수량이 부족합니다.");
	history.go(-1);
}	

function selectDelete() {
	var cartno = $("input[name='cart_no']").length
	var str = '';
	for(var i = 0; i<cartno; i++){
		if(document.getElementsByName("cart_no")[i].checked==true){
			var cart_no = document.getElementsByName("cart_no")[i].value;
			if(i==cartno-1){
				str += "cart_no="+cart_no;
			}else{
				str += "cart_no="+cart_no+"&";
			}
		}
	}
	if(cartno == 0){
		alert("선택된 상품이 없습니다.");
	} else{
		open("cartDelete.jsp?"+str, "seleteDelete", "width=300, height=200");
	}




//---------------------주소 클릭시 나오는 
function yesnoCheck() { 
    if (document.getElementById('yesnoCheck()').checked) {   
        document.getElementById('address').style.visibility = 'visible';
        document.getElementById('Naddress').style.visibility = 'hidden';
    }
    document.getElementById('address').style.visibility = 'hidden';
    else document.getElementById('Naddress').style.visibility = 'visible';

}



function checkOrder(){

	if (confirm("상품을 구매하시겠습니까?") == true){    //확인 onclick="checkOrder()"
	    document.form.submit();
	}else{   //취소
	    return;
		}
	}
	


</script>

<style> 

#address:checked~.address
{
display:block;
}

#Naddress:checked~.Naddress
{
display:block;
}
</style>
<link href="order.css" rel="stylesheet" type="text/css">
<div id="product" align="center">


<body>
<form action="cartorderFormPro.jsp" id="orderform" name="orderform" method="post" onsubmit="return check()" >
  	<br /><br /><br />
  	<h1> 주문서작성 </h1>
	<hr color="black"> <%-- 수평선 긋기 --%>
	 
	<table width="800" >
	<tr> 
	<th> 상품명 / 옵션정보 </th> <th> 단가 </th> <th> 수량 </th> <th> 합계 </th> 
	 </tr>
	 
	 	<%if(cart_no == null){ //-------------------------------주문하기 버튼을 눌렀을때
	 		
	 		
	 		/**/ 
	 		//상품번호   =User1&productCode=2&size=235&color=brown&pdQuantity=1
	 		String productCode = request.getParameter("productCode");
	 		int pdCode = Integer.parseInt(productCode);
	 		//사이즈
	 		String sizes = request.getParameter("size");
	 		//색상
	 		String color= request.getParameter("color");
	 		//수량
	 		String qty = request.getParameter("pdQuantity");
	 		int pdQuantity = Integer.parseInt(qty);
	 		//System.out.println(pdCode+"=="+color+"=="+sizes+"=="+pdQuantity);
	 		OrderDAO od = new OrderDAO();
	 		StockDTO odto = od.directOrder(pdCode, color, sizes, pdQuantity);
	 		//orderAmount+=odto.getAmount();  // 총합
	 		
	 		//product dto ? 
	 		int Amount = odto.getSellingPrice()*pdQuantity;
	 		
	 		%>
	 		
	 		<tr>  
	 			
				<td align='center'><%=odto.getProductName() %>/<%=odto.getColor() %> / <%=odto.getSize() %></td> 
				<td align='right'><%=odto.getSellingPrice() %>원</td>
				
	 		    <td align ="center"> <%=pdQuantity %>EA </td> 
				<td align ="right">  <%=Amount %>원       </td>
				
				<input type="hidden" name="productCode" value="<%=pdCode %>"/>
	 			<input type="hidden" name="productName" value="<%=odto.getProductName() %>"/>
	 			<input type="hidden" name="sizes" value="<%=sizes %>"/>
	 			<input type="hidden" name="color" value="<%=color %>"/>
	 			<input type="hidden" name="sellingPrice" value="<%=odto.getSellingPrice() %>"/>
	 			<input type="hidden" name="pdQuantity" value="<%=pdQuantity %>"/>
	 			
				<%
				orderAmount= Amount;  
				
				%>
				<%-- <%=odto.getAmount() %>
				<input type="hidden" name="cart_no" value="<%=odto.getCart_no() %>" /> -장바구니 번호-
	 		--%>
	 		
	 		 </tr>
	 		
	 	
	 		
	 		
	 	<%}else{ //---------------------------장바구니에서 받을때!! cart_no 로 받음 
	 		if(cart.size() == 0){%>
	 			<tr align='center'>
	 				<td colspan='8' style="height:170px; font-size:15pt">주문내역이 없습니다.</td>
	 			</tr>
	 	<% }else{
				for(int i = 0; i < cart.size(); i++){ 
	 				CartDTO dto = (CartDTO)cart.get(i);
	 				orderAmount+=dto.getAmount(); %>
	 		 <tr>  
				<td align='center'><%=dto.getProductName() %>/<%=dto.getColor() %> / <%=dto.getSize() %></td> 
				<td align='right'><%=dto.getUnitPrice() %>원</td>
	 		    <td align='center'><%=dto.getPdQuantity() %>EA</td> 
				<td align='right'><%=dto.getAmount() %>원</td>
				<input type="hidden" name="cart_no" value="<%=dto.getCart_no() %>" /> <%--장바구니 번호--%>
	 		 </tr>
				<%}
	 			}	 		
	 		}%>
	 		<tr><td><br></td></tr>
	 		<tr> 
	 			<td></td><td></td>  <td></td> <td style="font-weight:bold" align='right'> 총 <%=orderAmount %> 원 </td>
	  		</tr>
		</table> 
	<br /> <br /> <br /> <hr>
	
	 <button type="button" class="backBT" style="float: left;"  onClick="history.back()">돌아가기</button>	
	 
	<br> <br> <br> 
	<h1> 배송정보 </h1>
	<hr color="black"> 
	<br /><h3> 기존 배송정보 </h3>
	 <table width="1000"> 
	 <tr> 
	 <th>배송지</th> 					
	 <td>  <input type="radio" name="info"  id="address" value="sameinfo" checked> 회원정보와 동일 </td>
	
	 </tr>
	 <tr>
	 <th>연락처</th> <td><%=odao.getMemberPhNum(id) %> <input type="hidden" name="phonenumber" value=<%=odao.getMemberPhNum(id) %> />
	 </td>
	 </tr>
	 <tr>
	 <th>받으시는 분</th> <td><%=id %>  </td>
	 </tr>
	 <tr>
	 <th>주소 </th><td><%=odao.getMemberAddress(id) %> <input type="hidden" name="address" value=<%=odao.getMemberAddress(id).replace(" ", "&nbsp;") %> />
	 </td>
	 </tr>
	 </table>
	 
	 <br /> <hr> <br /><h3> 새로운 배송정보 </h3>
	  <table width="1000"> 
	 <tr>                                
	 <th>배송지</th>                            
	 <td>  <input type="radio" name="info"  value="newAddr" onchange="drawText()"> 새로운 배송지 선택 </td>
	 </tr>
	 <tr>
	 <th>받으시는 분</th> <td><%=id %></td>	
	 </tr>
	 <tr>												
	 <th>연락처</th><td><input type="text" placeholder="새로운 번호입력" size="70" name="newphnumber">  </td>
	 </tr>					
	 <tr>												
	 <th>주소 </th><td><input type="text" placeholder="새로운 주소입력" size="70" name="newaddress">  </td>
	 </tr>
	 </table>
	 <%-- 
	 <table width="1000">
	  <tr> 
	 <th>새로운 배송지</th> 
	 <td>  <input type="radio" name="info" onclick="javascript:yesnoCheck();"  id="address" value="sameinfo" checked> 새로운 배송지 </td>
	 </tr>
	 <tr>
	 <td> 주소 </td>
	 <td> <input type="text"placeholder="새로운 주소입력"> </td>
	  </tr>
	 </table>
	 --%>
	 	<br> <br> <br> 
	<h1> 결제수단 </h1>
	<hr color="black" > 
	<br /><br />
	 <input type="radio" name="paymt" value="카드 결제" checked> 카드 결제 &emsp;
	 <input type="radio" name="paymt" value="무통장 입금"> 무통장 입금 &emsp;
	 <input type="radio" name="paymt" value="휴대폰 결제"> 휴대폰 결제 &emsp;
	 <input type="radio" name="paymt" value="실시간 계좌이체"> 실시간 계좌이체 &emsp;
	 <br /><br />
	 <hr color="black"> 
	 <br /><br />
	 <h2> 결제 예정 금액: <%=orderAmount %> 원 </h2> 
	 <br /><br />
	 <input type="hidden" name="orderAmount" value="<%=orderAmount %>" />  <%--총합 보내기 --%>
	 <br /> <br />
	                                                <%--onclick="checkOrder()" --%>
	 <button type="submit" class="btndanger"  onclick="window.location='/badgudu/userPage/order/cartorderFormPro.jsp'"
 style="height:70px; width:300px; font-size: 18px;">
        		결제 하기                                                                                                                                              
        	</button>


	<input type="hidden" name="cartorderForm" />
</form>
</body>
</div>
<br /><br /><br /><br /><br />
<%@ include file ="/userPage/bottom.jsp" %>
</html>




