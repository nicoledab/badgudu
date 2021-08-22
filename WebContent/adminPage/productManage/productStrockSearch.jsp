<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "admin.dao.ProductDAO2" %> <!-- 혜연 DAO (DAO 합치면 지울 것) -->
<%@ page import = "admin.dto.StockDTO" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="pdmng" align="center">
<%@ include file="../adminAside.jsp" %>
<main>

<!-- 관리자 상품등록 -> DB에 상품 정보 저장 -> DB에서 상품 정보 불러오기 -->

<%
	request.setCharacterEncoding("UTF-8");

	ProductDAO2 dao2 = new ProductDAO2();
	ArrayList<StockDTO> list = dao2.getStockList();
%>

<%
	String col = request.getParameter("col"); 		// col 파라미터를 받음
	String search = request.getParameter("search"); // search 파라미터를 받음
	//System.out.println("search" + search); // search 값이 잘 넘어오는지 확인 위해 
	//System.out.println("col" + col);		  // col 값이 잘 넘어오는지 확인 위해

	// 이 블럭 아예 똑같음
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
	
	List productList = null;
	ProductDAO2 dbPro = new ProductDAO2();
	count = dbPro.getArticleCount(col,search);							// 전체 상품 수
	if (count > 0) { // 글이 하나라도 있으면
		productList = dbPro.getArticles(col, search, startRow, endRow);
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

<title>재고 목록</title>
<link href="style.css" type="text/css">
</head>

<body>
<center><b>재고 목록 (전체 상품:<%=count%>)</b>

<%if (count == 0) {%> <!-- 글 없을 때 -->
	<table width="1300" border="1" cellpadding="0" cellspacing="0">
		<tr>
    		<td align="center">
    			등록된 상품이 없습니다.
    		</td>
    	</tr>
	</table>

<%  } else {    %>
<table width="1300" border="1" cellpadding="0" cellspacing="0" align="center"> <!-- cellpadding: 글 사이에 약간의 여백이 있는데 그걸 없앤다는 뜻 (table border 있어서) -->
	<tr height="30" > 
		<td align="center"  width="50"  >번호</td> 
		<td align="center"  width="100" >상품번호</td>
	    <td align="center"  width="300" >상품명</td>
	    <td align="center"  width="100" >색상</td>
	    <td align="center"  width="100" >사이즈</td>
	    <td align="center"  width="170" >공급가</td>
	    <td align="center"  width="170" >판매단가</td>
	    <td align="center"  width="170" >기초수량</td>
	    <td align="center"  width="170" >판매수량</td>  
	    <td align="center"  width="170" >잔여수량</td>
	    <td align="center"  width="100" >재고현황</td>
    </tr>
<%	for (int i = 0; i < productList.size(); i++) {  
	
	StockDTO dto = (StockDTO)productList.get(i);%>
	<tr height="50">
    	<td align="center" width="50" > <%=number--%></td> <!-- 감소하고 있음, 글 번호는 최신글일수록 숫자가 커야 하기 때문에 글 번호는 위에서 아래로 내려갈수록 감소 -->
    	<td align="center" width="100" > 
    		<%= dto.getPdCode() %> <!-- 상품번호 -->
    	</td>
    	<%if(status == 10) {%> <!-- status가 10일 경우 상품등록 가능. 즉, 관리자 계정일 경우 --> 
    	<td align="center" width="300" name="pdCode" >
    		<a href="productUpdateForm.jsp?pdCode=<%=dto.getPdCode()%>&pageNum=<%=currentPage%>">
    			<%= dto.getProductName()%> </a>	<!-- 상품명 -->
 		</td>
 		<%}else{ %>	<!-- 관리자 권한이 없을 경우 상품명 클릭 불가능 -->
 		<td align="center" width="300" name="pdCode" >
 			<%=dto.getProductName() %>	<!-- 상품명 -->
		</td>
		<%} %>    		
		<td align="center" width="100" style="word-break:break-all" > 
    		<%= dto.getColor()%> <!-- 색상 -->
		</td>
		<td align="center" width="100" style="word-break:break-all" > 
    		<%= dto.getSize()%> <!-- 사이즈 -->
		</td>
		<td align="center" width="170" > 
    		<%= dto.getSupplyPrice()%> <!-- 공급가 -->
		</td>
		<td align="center" width="170" > 
    		<%= dto.getSellingPrice()%> <!-- 판매단가 -->
		</td>
		<td align="center" width="170" > 
    		<%= dto.getPdQuantity()%> <!-- 기초수량 -->
		</td>
		<td align="center" width="170" > 
    		<%= dto.getOrderquant()%> <!-- 판매수량 -->
		</td>
		<td align="center" width="170" > 
    		<%= dto.getRemainquant()%> <!-- 잔여수량 -->
		</td>
		<td align="center" width="100" > 
    		<%if(dto.getRemainquant() < 1){%>
	    		<font color="red"><b>품절</b></font>
	    	<%}else if(dto.getRemainquant() <= 10){%>
	    		품절임박
	    	<%}else{%>
	    		여유
	    	<%} %>			<!-- 재고현황 -->
		</td>
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
        <a href="productStrockSearch.jsp?pageNum=<%= startPage - 10 %>&col=<%=col%>&search=<%=search%>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %> <!-- 페이지 번호 1씩 증가 -->
        	<a href="productStrockSearch.jsp?pageNum=<%= i %>&col=<%=col%>&search=<%=search%>">[<%= i %>]</a>
<%		}
        if (endPage < pageCount) {  %> 
        	<a href="productStrockSearch.jsp?pageNum=<%= startPage + 10 %>&col=<%=col%>&search=<%=search%>">[다음]</a>
<%		}
    }
%>

<form action="productStrockSearch.jsp" method="post">
	<select name="col">
		<option value="pdCode">상품번호</option>
		<option value="productName">상품명</option>
	</select>
	<input type="text" name="search" />
	<input type="submit" value="검색" />
</form>
</center>
</body>
</html>
</main>
</div>