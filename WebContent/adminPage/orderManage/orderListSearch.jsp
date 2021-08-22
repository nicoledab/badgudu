<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "admin.dao.OrderDAO" %>
<%@ page import = "admin.dto.OrderListDTO" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="ormng" align="center">
<%@ include file="../adminAside.jsp" %>
<main>

<!-- 관리자 상품등록 -> DB에 상품 정보 저장 -> DB에서 상품 정보 불러오기 -->

<%
	request.setCharacterEncoding("UTF-8");

	OrderDAO dao2 = new OrderDAO();
	ArrayList<OrderListDTO> list = dao2.getOrderList();
%>
<%
 	
	String col = request.getParameter("col"); 		// col 파라미터를 받음
	String search = request.getParameter("search"); // search 파라미터를 받음
	//System.out.println("col = " + col);
	//System.out.println("search = " + search);

	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);	// 페이지
	int startRow = (currentPage -1) * 10 +1;
	int endRow = currentPage * pageSize;
	int count = 0; // 전체 상품 수
	int number = 0; // 선택한 페이지의 글 번호
	
	List orderList = null;
	List articleList = null;
	OrderDAO dbPro = new OrderDAO();
	count = dbPro.getArticleCount(col,search);							// 전체 상품 수
	if (count > 0) { // 글이 하나라도 있으면
		orderList = dbPro.getArticles(col, search, startRow, endRow); // getProducts 메소드 리턴값 List, 반복할 때마다 dto 만든 걸 List로 반환해둔 것
	}
	
	number = count - (currentPage-1)*pageSize;
	
	String id = (String)session.getAttribute("memId"); // 세션 연결
	
	int status = 0;	// 로그인이 아닌경우 status =  0
	Object obj = session.getAttribute("memSt");	// 로그인인 경우 status를 obj라는 이름으로 가져옴 
	// System.out.println(obj); 입력받은 status 확인
	if(id == null || obj == null)	// id 혹은 status가 입력되지 않은경우. 즉, 비회원
	{
		id = "GUEST";
		// System.out.println("status = " + status); 입력받은 status 확인
	}
	else
	{
		status = (int)obj; // 회원인 경우, status를 obj(받아온 status)값으로 재설정
	}
	
%>


<html>
<head>

<script>
//송장번호 기입
function orderStatus2(invoice, odcode, pageNum){ // 함수명(@, #) 던져준 값
	var selectInvoice = document.getElementById(invoice).value;	// id= invoice(invoice_@ 몇번째)의 값을 받아옴
	window.location = "orderStatus2.jsp?odcode="+odcode+"&invoice="+selectInvoice+"&pageNum="+pageNum; // url 뒤에 odcode invoice
}

// 송장번호 수정
function orderStatus3(invoiceUp, odcode, pageNum){ // 함수명(@, #) 던져준 값
	var selectInvoice2 = document.getElementById(invoiceUp).value;	// id= invoiceUp(invoiceUp_@ 몇번째)의 값을 받아옴
	window.location = "orderStatus3.jsp?odcode="+odcode+"&invoiceUp="+selectInvoice2+"&pageNum="+pageNum; // url 뒤에 odcode invoiceUp
}
</script>

<body>
<center><b>주문 목록 (전체 주문:<%=count%>)</b>


<%if (count == 0) {%> <!-- 글 없을 때 -->
	<table width="1500" border="1" cellpadding="0" cellspacing="0">
		<tr>
    		<td align="center">
    			등록된 주문이 없습니다.
    		</td>
    	</tr>
	</table>

<%  } else {    %>
<table width="1500" border="1" cellpadding="0" cellspacing="0" align="center"> <!-- cellpadding: 글 사이에 약간의 여백이 있는데 그걸 없앤다는 뜻 (table border 있어서) -->
	<tr height="30" > 
		<td align="center"  width="50"  >번호</td> 
		<td align="center"  width="100" >판매일자</td>
	    <td align="center"  width="100" >구매자 ID</td>
	    <td align="center"  width="100" >구매자 연락처</td>
	    <td align="center"  width="100" >주문번호</td>
	    <td align="center"  width="350" >주문명</td>
	    <td align="center"  width="350" >주소</td>
	    <td align="center"  width="100" >총 구매금액</td>
	    <td align="center"  width="100" >지불방법</td>
	    <td align="center"  width="150" >주문확인</td>
	    <td align="center"  width="100" >주문상태</td>
   	    <td align="center"  width="100" >취소</td>   
    </tr>
<%	for (int i = 0; i < orderList.size(); i++) {  
	
	OrderListDTO dto = (OrderListDTO)orderList.get(i);%>
	<tr height="50">
    	<td align="center" width="50" > <%=number--%></td> <!-- 감소하고 있음, 글 번호는 최신글일수록 숫자가 커야 하기 때문에 글 번호는 위에서 아래로 내려갈수록 감소 -->
    	<td align="center" width="100" > 
    		<%=sdf.format(dto.getOrderDate())%> <!-- 판매일자 -->
    	</td>
    	<td align="center" width="100" name="Userid" >
    			<%= dto.getUserid()%> 	<!-- 구매자ID -->
 		</td>
 		<td align="center" width="100" name="Userid" >
    			<%= dto.getPhonenumber()%> 	<!-- 구매자 연락처 -->
 		</td>
 		<td align="center" width="100">
 			<%=dto.getOdcode() %>	<!-- 주문번호 -->
		</td>
		<td align="center" width="350" style="word-break:break-all" > <!-- style="word-break:break-all"  길어지면 줄바꿈처리 -->
			<a href="detailCheck.jsp?odcode=<%=dto.getOdcode() %>" onclick="window.open(this.href, '_blanck','width=1600, height=400'); return false"> 
			<%= dto.getProductname()%> <!-- 주문명 --></a>
		</td>
		<td align="center" width="350" style="word-break:break-all"> 
    		<%= dto.getUserAddr()%> <!-- 주소 -->
		</td>
		<td align="center" width="150"  > 
    		<%= dto.getAmount()%> <!-- 총 구매금액 -->
		</td>
		<td align="center" width="100" > 
    		<%= dto.getPaymethod()%> <!-- 지불방법 -->
		</td>
		<%
		if(dto.getOrderStatus().equals("대기중")){
			%>
			<td align="center" width="100" > 
    		 <input type="button" value="확인" onclick="window.location='orderStatus.jsp?odcode=<%=dto.getOdcode() %>&pageNum=<%=pageNum%>'"/>
 			</td> <!-- 주문확인(대기중 상태에서 확인 버튼 보임) -->
 			<%
		}else if(dto.getOrderStatus().equals("배송준비")){%>
		<td  align="center" width="100" >
				<input type="text" name="invoice" id="invoice_<%=i%>" placeholder="송장번호"/> <!-- 전송버튼 id값을 지정(몇번째 전송버튼인지) -->
				<button onclick="orderStatus2('invoice_<%=i%>','<%=dto.getOdcode() %>', <%=pageNum%>)">전송</button>
				<!-- orderStatus2함수 실행시키고 값 두개를 전송한다. --> 
		</td><%
		}else if (dto.getOrderStatus().equals("배송중")){%>
		<td  align="center" width="100" >
			<input type="text" name="invoiceUp" id="invoiceUp_<%=i%>" placeholder="<%=dto.getInvoice()%>"/> <!-- 전송버튼 id값을 지정(몇번째 전송버튼인지) -->
				<button onclick="orderStatus3('invoiceUp_<%=i%>','<%=dto.getOdcode() %>', <%=pageNum%>)">수정</button> 
		</td>
		<%}else if (dto.getOrderStatus().equals("판매자 취소")){%>
			<td  align="center" width="100" >
				판매자 취소
		</td>
		</td>
		<%}else if (dto.getOrderStatus().equals("구매자 취소") || dto.getOrderStatus().equals("구매자취소")){%> 
			<td  align="center" width="100" >
				구매자 취소
		</td>
		</td>
		<%}else if (dto.getOrderStatus().equals("배송완료")){%> 
			<td  align="center" width="100" >
				배송완료
		</td>
		<%}else{
		%> <td  align="center" width="100" >
			확인중
		</td>
		<%} %>
		<td align="center" width="100" > 
    		<%= dto.getOrderStatus()%> <!-- 주문상태 -->
		</td>
		<%if(dto.getOrderStatus().equals("판매자 취소") || dto.getOrderStatus().equals("판매자 취소")){ %>
			<td align="center" width="100" >
				<font color="red"><b>판매자 취소</b></font>
		<%}else if(dto.getOrderStatus().equals("구매자 취소") || dto.getOrderStatus().equals("구매자취소")){ %>
			<td align="center" width="100" > 
				<font color="green"><b>구매자 취소</b></font>
		<%}else if(dto.getOrderStatus().equals("배송완료")){ %>
			<td align="center" width="100" > 
				<b>배송완료</b>
		<%}else{ %>
			<td align="center" width="100" >
    		<input type='button' value='판매취소' onclick="window.location='orderDelete.jsp?pageNum=<%=pageNum%>&odcode=<%=dto.getOdcode() %>'"/> <!-- 판매취소 -->
    		<%} %>
	</tr>
    <%}%>
</table>
<%}%>


<%	// 전체 게시글 수가 0보다 크면 // 페이지 번호 보이는 개수 10개로 지정한 것 페이지 번호 11 이상이면 [이전]으로 나오게
    if (count > 0) { // 직접 계산해보기 // 계산해서 페이지 번호 보여주는 것 // 10 넘어가면 [이전]으로 나오고 11부터 시작
    	// 페이지 번호 = 전체 게시글 수 / 한 페이지에 보일 게시글 수 + ( 전체 게시글 수 % 한 페이지에 보일 게시글 수 == 0일 경우 0, 아닐 경우 1)
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
        int startPage = (int)(currentPage/10)*10+1; // (int)(사용자가 클릭한 현재 페이지 번호 / 10) * 10 + 1 // 
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="orderListSearch.jsp?pageNum=<%= startPage - 10 %>&col=<%=col%>&search=<%=search%>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %> <!-- 페이지 번호 1씩 증가 -->
        	<a href="orderListSearch.jsp?pageNum=<%= i %>&col=<%=col%>&search=<%=search%>">[<%= i %>]</a>
<%		}
        if (endPage < pageCount) {  %> 
        	<a href="orderListSearch.jsp?pageNum=<%= startPage + 10 %>&col=<%=col%>&search=<%=search%>">[다음]</a>
<%		}
    }
%><br>

<form action="orderListSearch.jsp" method="post">
	<select name="col">
		<option value="OdCode">주문번호</option>
		<option value="UserId">고객 ID</option>
		<option value="UserAddr">고객 주소</option>
	</select>
	<input type="text" name="search" />
	<input type="submit" value="검색" />
</form>
</center>
</body>
</html>