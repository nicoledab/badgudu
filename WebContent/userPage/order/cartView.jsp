<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "user.dao.CartDAO" %>
    <%@ page import = "user.dto.CartDTO" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
<script>
function choisePri(){
	var ctlength = document.getElementsByName("cart_no").length;
	var cn = "";
	if(ctlength<1){
		alert("장바구니에 상품이 없습니다.");
		return false;
	} else if(ctlength>0){
		for(var i = 0; i<ctlength; i++){
			if (document.getElementsByName("cart_no")[i].checked==true){
				cn+=1;
			}
		}
		if(cn==""){
			alert("선택된 상품이 없습니다.");
			return false;
		}
	}
	
	document.cartForm.submit();
}

//전체선택, 전체해제
$(function(){
	var cartno = document.getElementsByName("cart_no");
	var count = cartno.length;
	
	$("#allCheck").click(function(){
		var cnList = $("input[name=cart_no]");
		for(var i = 0; i<cnList.length; i++){
			cnList[i].checked = this.checked;
		} 
	});
	$("input[name='cart_no']").click(function(){
		if($("input[name='cart_no']:checked").length == count){
			$("#allCheck")[0].checked= true;
		}
		else {
			$("#allCheck")[0].checked= false;
		}
	});
	
});

//전체주문
function allOrder(){
	var ctlength = document.getElementsByName("cart_no").length;
	console.log(ctlength);
	if (ctlength>0){
		for(var i = 0; i<ctlength; i++){
			var cn = document.getElementsByName("cart_no")[i].checked=true;
		} 
	} else if(ctlength<1){
		alert("장바구니에 상품이 없습니다.");
		return false;
	}
	
}


//선택 삭제
function selectDelete() {
	var cartno = $("input[name='cart_no']").length;
	var cn="";
	var str = '';
	for(var i = 0; i<cartno; i++){
		if(document.getElementsByName("cart_no")[i].checked==true){
			cn +=1;
			var cart_no = document.getElementsByName("cart_no")[i].value;
			if(i==cartno-1){
				str += "cart_no="+cart_no;
			}else{
				str += "cart_no="+cart_no+"&";
			}
		}
	}
	console.log(cn);
	if(cn == ""){
		alert("선택된 상품이 없습니다.");
		return false;
	} else{
		open("cartDelete.jsp?"+str, "seleteDelete", "width=300, height=200");
	}
		
}
//장바구니 비우기
function allDelete(){
	var cartno = $("input[name='cart_no']").length
	var str = '';
	for(var i = 0; i<cartno; i++){
		if(document.getElementsByName("cart_no")[i]){
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
		
	
}

</script>


<%@ include file ="../top.jsp" %>

<div id="cartView" align="center" style="overflow:auto;">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="../aside.jsp" %>

<link href="order.css" rel="stylesheet" type="text/css">

<%
	//장바구니 가져오기
	CartDAO dao = new CartDAO();
	List cart = null;
	cart = dao.getCart(Mid);
	int orderAmount = 0;
	int arraySize = cart.size();
%>
	<input type="hidden" name="arraySize" value=<%=arraySize %>/>

<main>
<form name="cartForm" action="cartorderForm.jsp" method="post" onsubmit="return allOrder();">
<table id="cartTable" width='1100'>
	<tr height='100'> <td align="left" colspan='8' style="font-size:20pt"><b>장바구니</b></td></tr>
	<tr align='center' height='70'>
		<td width='50'><input type="checkbox" id="allCheck"/></td>
		<td width='200'><b>이미지</b></td>
		<td width='250'><b>상품명</b></td>
		<td width='100'><b>옵션정보</b></td>
		<td width='100'><b>단가</b></td>
		<td width='100'><b>수량</b></td>
		<td width='100'><b>금액</b></td>
		<td width='70'><b>삭제</b></td>
	</tr>
	<%
	if(cart.size() == 0){
		%><tr align='center'><td colspan='8' style="height:170px; font-size:15pt">장바구니에 담긴 상품이 없습니다.</td></tr><%
	} else{
		for(int i = 0; i<cart.size(); i++){
			CartDTO dto = (CartDTO)cart.get(i);
			orderAmount+=dto.getAmount();
			%><tr align='center' height='160'>
			<%--<input type="hidden" name="cart_no" id="cart_no"+i value=<%=dto.getCart_no() %>/> --%>
         
        	<td> <input type="checkbox" name="cart_no" value="<%=dto.getCart_no() %>" checked/></td>

			<td onClick="location.href='/badgudu/userPage/product.jsp?pdCode=<%=dto.getPdCode() %>'" style="cursor:pointer;">
			 <img src="${pageContext.request.contextPath}\productImg\<%=dto.getProductImg1() %>" width="150" height="150"/></td>
			<td onClick="location.href='/badgudu/userPage/product.jsp?pdCode=<%=dto.getPdCode() %>'" style="cursor:pointer;">
			<%=dto.getProductName() %></td>
			<td> <%=dto.getColor() %> / <%=dto.getSize() %></td>
			<td align="right"> <%=dto.getUnitPrice() %>원</td>
			
			<td>
				<a href="cartQtyDown.jsp?cart_no=<%=dto.getCart_no() %>" >
				<img src = "/badgudu/productImg/minus.png" style="width:12px; height:12px" />
				</a>
				<%=dto.getPdQuantity() %>
				<a href="cartQtyUp.jsp?cart_no=<%=dto.getCart_no() %>" >
				<img src = "/badgudu/productImg/plus.png" style="width:12px; height:12px"/>
				</a>
			</td>
			<td align="right"> <%=dto.getAmount() %>원</td>
			
			<td> 
				<a href="cartDelete.jsp?cart_no=<%=dto.getCart_no() %>" onClick="window.open(this.href, '','width=300 height=200'); return false;">
				<img src = "/badgudu/productImg/delete.png" style="width:30px; height:30px;" />
				</a>
			</td>
			</tr>
		<%}
	}%>
		<tr height='100'> 
			<td colspan='4' align="left"><input type="button" value="선택삭제" style="width:80px; height:35px;" onclick="selectDelete();" /></td>
			<td colspan='4' align="right"><input type="button" value="장바구니 비우기" style="width:150px; height:35px;" onclick="allDelete()" /></td>
		</tr>
		<tr>
			<td colspan='8' align='right' style="height:50px; font-size:13pt"><b>총 <%=orderAmount %>원</b></td>
		</tr>
		<tr>
			<td colspan='8' align='center'>
			<input type="submit" value="전체상품주문" style="width:160px; height:50px; font-weight:bold; font-size:13pt;" />
			<input type="button" value="선택상품주문" onclick="choisePri();" style="width:160px; height:50px; font-weight:bold; font-size:13pt;" />
			</td>
		</tr>
</table>
</form>
</main>
</div>
<%@ include file="../bottom.jsp" %>

