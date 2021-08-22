<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ page import = "admin.dto.StockDTO" %>
    <%@ page import = "user.dao.CartDAO" %>
    <%@ page import = "user.dto.CartDTO" %>
    
    <%@ page import = "user.dto.OrderDTO" %>
    <%@ page import = "user.dao.OrderDAO" %>
    <%@ page import = "user.dto.OrderDetailDTO" %>
    <%@ page import = "java.util.*" %>
   <% request.setCharacterEncoding("UTF-8");%>
 

 
 
 <%
 
	String id = (String)session.getAttribute("memId");  // 유저ID
	String orAm = request.getParameter("orderAmount"); // 총합 
	int orderAmount = Integer.parseInt(orAm);
	String paymt = request.getParameter("paymt"); // 결제 방식
	String address = request.getParameter("address");// 기존 주소
	String newaddress = request.getParameter("newaddress");// 새로운 주소
	String phonenumber = request.getParameter("phonenumber"); // 기존 연락처 
	String newphnumber = request.getParameter("newphnumber"); // 새로운 연락처
	String info = request.getParameter("info");
	String [] cart_no = null;
	if(request.getParameter("cart_no")==null){
		cart_no = null;
	} else{
		cart_no = request.getParameterValues("cart_no");
	}
	
	OrderDAO orderDAO = new OrderDAO();
	int odcode = orderDAO.maxOdcode();
	
	CartDAO dao = new CartDAO();
	//------------------------------------------------order_detail table에 넣기 
	OrderDetailDTO odDTO = new OrderDetailDTO();
	odDTO.setPaymethod(paymt);   // 결제방식
	odDTO.setUserid(id); // id
	odDTO.setOdcode(odcode);  // 그룹 번호 

	if(info.equals("sameinfo")){
		odDTO.setUseraddr(address); // 기존 주소 
		odDTO.setPhonenumber(phonenumber); // 기존 연락처
	}else{
		odDTO.setUseraddr(newaddress); // 새로운 주소
		odDTO.setPhonenumber(newphnumber); // 새로운 연락처
	}
	
	System.out.println(address);
	//------------------------------------------------shoporder table에 넣기 
	OrderDTO odb = new OrderDTO();
	odb.setUserid(id);
	if(info.equals("sameinfo")){
		odb.setUserAddr(address);
		odb.setPhonenumber(phonenumber);
	}else{
		odb.setUserAddr(newaddress);
		odb.setPhonenumber(newphnumber);
	}
	
	odb.setAmount(orderAmount);
	odb.setPaymethod(paymt);
	odb.setOdcode(odcode);
	
	
	
	String productName = "";
	String orderName=""; 
	int i =1;
	List cart = dao.getOrderCart(cart_no);  // 장바구니에서 가저오기	
	
	if(cart_no != null && cart.size() > 0){  
		for(i = 0 ; i < cart.size(); i++){
			//-----------db를 order_detail table 에 넣기!!
			CartDTO dto = (CartDTO)cart.get(i);
			odDTO.setSupplyPrice(dto.getUnitPrice());
			odDTO.setAmount(dto.getAmount());     // 수량*가격
			
			// odDTO.setPdexplain(dto.getColor()+"/"+dto.getSize()+"/"+dto.getPdQuantity()); // explain  
			odDTO.setColor(dto.getColor());
			odDTO.setSizes(dto.getSize());
			odDTO.setPdQuantity(dto.getPdQuantity());
			
			odDTO.setProductname(dto.getProductName()); // 상품명
			odDTO.setPdcode(dto.getPdCode()); // 상품코드 
			orderDAO.insertOrder(odDTO);
			
			
			
			//------------------------------------db를 shoporder table 에 넣기!!
			
			productName += dto.getProductName()+",";
			if(i==0){
				orderName = dto.getProductName();
			}
		}
		
	}else if(cart_no==null){
		// ----------------------------------------------상품페이지에서 바로주문 했을때 
		String pdCode = request.getParameter("productCode");
		productName = request.getParameter("productName");
		orderName = productName;
		String sizes = request.getParameter("sizes");
 		String color= request.getParameter("color");
 		String sp = request.getParameter("sellingPrice");
 		int sellingPrice = Integer.parseInt(sp);
 		String qty = request.getParameter("pdQuantity");
 		int pdQuantity = Integer.parseInt(qty);
		
 		odDTO.setPdcode(Integer.parseInt(pdCode));
 		odDTO.setProductname(productName);
 		odDTO.setSupplyPrice(sellingPrice);
 		odDTO.setSizes(sizes);
 		odDTO.setColor(color);
 		odDTO.setPdQuantity(pdQuantity);
 		odDTO.setAmount(orderAmount);
 		orderDAO.directInsertOrder(odDTO);
 		
	}
	
	
	
	
	
	i=i-1;
	if (i==0){
		odb.setProductname(orderName);
	}else{
		odb.setProductname(orderName+"외 "+i+"건");
	}
	orderDAO.insertShopOrder(odb);
	
	
	

	
 %>
	
	
	
<%@ include file ="../top.jsp" %>
<div id="cartView" align="center">

<%@ include file ="../aside.jsp" %>

<link href="order.css" rel="stylesheet" type="text/css">

<main> 

<section align="center"> 
<br /> <br /> <br /> <br /> 
<h1>결제 완료! </h1>
주문일자[주문번호] : <%=odcode%> <br />
주문자(id) : <%=id%> <br />


상품 정보 : <%=productName %> <br />
지불 가격 : <%=orderAmount%> <br />
지불 방법 : <%=paymt %> <br />
주문 상태 : 대기중 <br />

</section>
<br /><br />
   <h3>  주문내역을 작성중입니다. </h3>   <br /><br />
   <h4> 5초 후 이동 </h4>
</main>
</div>


<script>
     
    setTimeout("location.href='/badgudu/userPage/orderDetail/orderDetail.jsp?odcode=<%=odcode%>'",5000);
</script>





