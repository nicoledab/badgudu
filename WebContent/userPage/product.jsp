<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.dao.UserMenuDAO" %>
    <%@ page import = "user.dto.UserMenuDTO" %>
    <%@ page import = "user.dto.ReviewBoardDTO" %>
    <%@ page import = "user.dao.ReviewBoardDAO" %>
    <%@ page import = "java.util.*" %>
    <% request.setCharacterEncoding("UTF-8"); %>


<title>상품 보기</title>
<%@ include file ="top.jsp" %>
<div id="product" align="center">

<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="aside.jsp" %>

<link href="style.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

	<%--재고 확인하기 --%>
	function stockCheck(){
		var pdCode = document.productInfo.pdCode.value;
		
		open("stockCheck.jsp?pdCode="+pdCode, "stockCheck","width=500, height=600");
	}
	
	<%--상품 추가하기 --%>
	function addPd(){
		var str = '';
		var sendZone = document.getElementById("sendZone");
		var size = document.getElementsByName("size")[0].value;
		var color = document.getElementsByName("color")[0].value;
		var qty = document.getElementsByName("pdQuantity")[0].value;
	
		if(size==""||color==""||qty==""){
			str = "정확히 확인해주세요.";
		}else{
			str= size+" "+ color+" "+ qty+"개 "+ "<input type='button' value='x' style='width:20' onclick='delect();'/>";	
		}
		sendZone.innerHTML = str;
	}
	
	<%--상품 삭제하기 --%>
	function delect(){
		var sendZone = document.getElementById("sendZone");
		var main = document.main;
		main.removeChild(sendZone);
	}
	
	<%--장바구니--%>
	function addCart(){
		var sendZone = document.getElementById("sendZone").value;
		var size = document.getElementsByName("size")[0].value;
		var color = document.getElementsByName("color")[0].value;
		var qty = document.getElementsByName("pdQuantity")[0].value;
	
		if(size==""||color==""||qty==""){
			alert("옵션을 확인해주세요.");
			return false;
		} else{
			alert(size+" "+ color+" "+ qty+"개 "+"를 장바구니에 담았습니다. 장바구니로 이동합니다.");
		}
	}
	
	function directOrder(){
		var pdCode = document.getElementsByName("pdCode")[0].value;
		var id = document.getElementsByName("id")[0].value;
		var size = document.getElementsByName("size")[0].value;
		var color = document.getElementsByName("color")[0].value;
		var qty = document.getElementsByName("pdQuantity")[0].value;
	
		if(size==""||color==""||qty==""){
			alert("옵션을 확인해주세요.");
			return false;
		} else{                                   //cartorderForm.jsp
			alert("해당 상품을 주문합니다");
			window.location ="/badgudu/userPage/order/directOrderPro.jsp?id="+id+"&productCode="+pdCode+"&size="+size+"&color="+color+"&pdQuantity="+qty;
			//window.location ="/badgudu/userPage/order/cartorderForm.jsp?id="+id+"&productCode="+pdCode+"&size="+size+"&color="+color+"&pdQuantity="+qty;
		}
	}
	
</script>

<%
	//상품 코드 받기
	String productCode = request.getParameter("pdCode");
	int pdCode = Integer.parseInt(productCode);
	
	//상품정보 가져오기
	UserMenuDAO dao = new UserMenuDAO();
	String productImg1 = dao.getCateThumbImg(pdCode); //이미지 가져오기
	UserMenuDTO dto = dao.productInfo(pdCode); //상품이름, 가격 가져오기
	List size = null; 
	List color = null; 
	size = dao.pdSize(pdCode);
	color = dao.pdColor(pdCode); //상품 옵션 가져오기
	
%>

<main style="overflow:auto;">
<form name="productInfo" action="/badgudu/userPage/order/addCartPro.jsp" method="post" onsubmit="return addCart();" >
<input type="hidden" name="id" value="<%=Mid %>" />
<input type="hidden" name="pdCode" value="<%=pdCode %>" />
<input type="hidden" name="unitPrice" value="<%=dto.getSellingPrice() %>" />
<input type="hidden" name="productName" value="<%=dto.getProductName() %>" />
<input type="hidden" name="productImg1" value="<%=productImg1 %>" />
<br />
	<table>
		<tr>
			<td rowspan='5'>
				<img src="${pageContext.request.contextPath}\productImg\<%=productImg1 %>" width="700" height="700"/>
			</td>
			<td align="center" width='400' height='150'>
				<h3><%=dto.getProductName() %></h3><br /><br/>
				<h4><%=dto.getSellingPrice() %>원</h4>
			</td>
		</tr>
		<tr>
			<td align="center" width='400' height='50'>
				<input type="button" value="재고확인" onclick="stockCheck();" style="width:300px; height:40px; font-size:12pt" />
			</td>
		</tr>
		<tr>
			<td align="center" width='400' height='100'>
				사이즈 : 
				<select name="size">
					<option value="">사이즈 선택</option>
				<%
					for(int i = 0; i<size.size();i++){
						%><option value=<%=size.get(i) %>><%=size.get(i) %></option> <%
					}
				%>
				</select><br/><br/>
			
				색상: 
				<select name="color">
					<option value="">컬러 선택</option>
				<%
					for(int i = 0; i<color.size();i++){
						%><option value=<%=color.get(i) %>><%=color.get(i) %></option> <%
					}
				%>
				</select> <br/><br/>
				수량 : <input type="number" name="pdQuantity" min='1' max='30' value="1" style="width:40px"/>
				<br/><br/>
				<input type="button" name="add"  value="추가 하기" onclick="addPd();" style="width:300px; height:50px; font-size:12pt" />
			</td>
		</tr>
		<tr>
			<td align="center" width='400' height='50'>
				<div id="sendZone"></div>
			</td>
		</tr>
		<tr>
		<%
			if(Mid == "GUEST"){
				%> <td align="center" width="800" colspan='2'>
					<input type="button" name="goLogin" value="로그인하고 구매하기" onclick="window.location='/badgudu/userPage/login/loginForm.jsp'" style="width:300px; height:50px; font-size:12pt" />
				</td> <%
			} else{ %>
				<td align="center" width='400'>
				<input type="submit" value="장바구니 추가" style="width:150px; height:50px; font-size:12pt"/>
				<input type="button" name="order" value="주문하기" onclick="return directOrder();" style="width:150px; height:50px; font-size:12pt"/>
			</td> <%
			}
		%>
		</tr>
	
	</table>
	</form>
	<%-- //------------    -----설명 && 해당 상품 이미지 불러오기~~~ --%>
	<br /><br /><br /><br /><br /><br /><br />
		<%
	String productImg2 = dao.getCateThumbImg2(pdCode); //다른 이미지2 
	String productImg3 = dao.getCateThumbImg3(pdCode); //다른 이미지3
	String productImg4 = dao.getCateThumbImg4(pdCode); //다른 이미지4
	String productImg5 = dao.getCateThumbImg5(pdCode); //다른 이미지5
	%>
	                           
	 <img src="${pageContext.request.contextPath}\productImg\<%=productImg1 %>" width="auto" height="auto"/><br />
	 <img src="${pageContext.request.contextPath}\productImg\<%=productImg2 %>" width="auto" height="auto"/><br />
	 <img src="${pageContext.request.contextPath}\productImg\<%=productImg3 %>" width="auto" height="auto"/><br />
	 <img src="${pageContext.request.contextPath}\productImg\<%=productImg4 %>" width="auto" height="auto"/><br />
	 <img src="${pageContext.request.contextPath}\productImg\<%=productImg5 %>" width="auto" height="auto"/><br />
		
	
	<br /><br /><br />
	<hr width="70%">
	<br /><br />
	 <b color="gray"> 측정방법에 따라 1cm 정도 오차가 있을 수 있습니다.<br />
		개인의 발모양에 따라 사이즈 선택 기준은 다양하며,<br /> 별도의 사이즈 추천은 드리지 않고 있는 점 양해 부탁드립니다.<br />
		상품의 상세사이즈를 참고하여 평소 신으시는 신발과 실측 비교해보시는 것을 추천드립니다.</b>
	<br /><br /><br /><br /><br /><br /><br />
	<hr width="70%">
	<br /><br />
		<b>제조사 :</b> badgudu<br />
		<b>제조국 :</b> 한국<br />
		<b>제조일 :</b> 2020. 02. 22<br />
		<b>품질보증기간 :</b> 소비자분쟁해결 기준에 따름<br />
		<b>A/S책임자 및 연락처 :</b> badgudu 고객센터 1600-8541<br />
		<br /><br /><br />
	<hr width="70%">
	<br /><br />
   
     <%-- //-------------------------------        --~~~~~해당 상품 리뷰 보기  --%>
	
	<%
	String id = (String)session.getAttribute("memId"); 
	String subject = request.getParameter("pdname"); //파라미터 이름 잘 받기 
	
	int count = 0;	// 전체 게시물 수

	ReviewBoardDAO dbPro =new ReviewBoardDAO();
	count = dbPro.getPdReviewCount(subject); // 전체 게시물 수를  dbPro의 ArticleCount() 메서드에서 가져옴

	
	
	%>
	<br /> <br /> <br /> 
	<br /> <br />  
	
	<h2>상품 후기</h2><h4> [<%=count %>]개 </h4><br />  
	
	 <button type="button" class="backBT" style="float: center;"  onClick="window.location='/badgudu/userPage/csBoard/review/reviewlist.jsp'"> 리뷰게시판 </button>	&ensp;
	 
	 <%if(id != null ){ %>
	  <button type="button" class="backBT" style="float: center;"  onClick="window.location='/badgudu/userPage/csBoard/review/rwriteFromOd.jsp?writer=<%=id %>&pdcode=<%=productCode %>'">후기쓰기</button>	
	<%} %>
	<br /> <br /> <br /> 
	 <%
     ReviewBoardDAO reviewda = new ReviewBoardDAO();
     ArrayList<ReviewBoardDTO> list = reviewda.getPdReviewList(subject); 
       %>  
         
         
    <%if (count == 0) {%>
	<table width="1100" border="1" bordercolor="#D3D3D3" cellpadding="10" cellspacing="0" height="300">
		<tr>
    		<td align="center">
    			상품 후기가 없습니다.
    		</td>
    	</tr>
	</table>

<%  } else {    %>      
         
         
	<table cellpadding="80" cellspacing="0" align="center" style=" border:1px solid gray;" height="400" width="1100" >
		
		
		 <tr bgcolor="ededed">                   <%--상품명은 subject -즉 제목이 된다.  조회수 많은 걸 위로 가게  --%>
     <td>번호</td><td>작성자</td><td>상품명</td><td>내용</td><td>날짜</td><td>조회수</td>
  </tr>
  <%
     for(ReviewBoardDTO RRdto : list){ %>
     <tr>
   		  <td><%=RRdto.getNum()%></td>
         <td><%=RRdto.getWriter()%></td>
         
         
        <td>
        <%-- 
         <a href="rcontent.jsp?num=<%=RRdto.getNum()%>">   </a>  
         --%>
         <%=RRdto.getSubject()%>
        </td>
        
        <td>
         <a href="/badgudu/userPage/csBoard/review/rcontent.jsp?num=<%=RRdto.getNum()%>"> <%=RRdto.getContent() %> </a>  
         </td>
       
        <td><%=RRdto.getReg_date() %></td>
        <td><%=RRdto.getReadcount()%></td>
      </tr>
   <%} %>
   

	</table>
<%}%>
 <br /> <br /> 

</main>
</div>

<%@ include file="bottom.jsp" %>