<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "admin.dao.ProductDAO" %> <!-- 예은 DAO -->
<%@ page import = "admin.dao.ProductDAO2" %> <!-- 혜연 DAO (DAO 합치면 지울 것) -->
<%@ page import = "admin.dto.ProductDTO" %>
<%@ page import = "admin.dto.BoardDataBean" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file= "color.jsp" %>

<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="pdmng" align="center">
<%@ include file="../adminAside.jsp" %>
<main>
<%
	ProductDAO2 dao2 = new ProductDAO2();
	ArrayList<ProductDTO> list = dao2.getList();
	request.setCharacterEncoding("UTF-8");
%>

<%
	String id = (String)session.getAttribute("memId"); // 세션 연결
	
	int pageSize = 10; // 한 페이지에 보일 게시글 수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) { // 글 목록 번호 클릭 없을 때
		pageNum = "1"; // 1로 바꿔준다
	}

	// 검색할 때 쓴 col(상품번호, 상품종류, 상품명), 
	String col = request.getParameter("col");
	String search = request.getParameter("search");
	String category = request.getParameter("category");
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage -1) * pageSize +1;
	int endRow = currentPage * pageSize;
	int count = 0; // 검색 상품 수
	int number = 0; // 선택한 페이지의 글 번호
	
	List<ProductDTO> productList = null;
	List articleList = null;
	ProductDAO2 dbPro = new ProductDAO2();
	
	if(category==""){ // search로 검색했을 때
		count = dbPro.getProductCount(col, search); // 검색 상품 수
	} else{ // category로 검색했을 때
		count = dbPro.getProductCount(col, category);
	}
	
	if (count > 0) { // 글이 하나라도 있으면
		if(col.equals("pdCategory")) { // col이 category면
			productList = dbPro.getProducts(col, category, startRow, endRow);
		}else{
		productList = dbPro.getProducts(col, search, startRow, endRow); // getProducts 메소드 리턴값 List, 반복할 때마다 dto 만든 걸 List로 반환해둔 것
		}
	}
	
	
	
	number = count - (currentPage-1)*pageSize;

%>

<html>
<head>

<title>검색 결과</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<center><b><%=count%> 개의 검색 결과</b>

<table width="1200" border-color="transparent" cellpadding="0" cellspacing="0">
	<tr>
		<td align="right">
			<%if(id.equals("admin")) {%>
			<a href="productRegForm.jsp">상품등록</a>
			<%}else{ %>
			권한이 없습니다.
			<a href="/badbad/userPage/loginForm.jsp">로그인</a>
			<%} %>
		</td>
	</tr>
</table>

<%if (count == 0) {%> <!-- 글 없을 때 -->
	<table width="1500" border="1" cellpadding="0" cellspacing="0">
		<tr>
    		<td align="center">
    			검색 결과가 없습니다.
    		</td>
    	</tr>
	</table>

<%  } else {    %>
<table width="1200" border="1" cellpadding="0" cellspacing="0" align="center"> <!-- cellpadding: 글 사이에 약간의 여백이 있는데 그걸 없앤다는 뜻 (table border 있어서) -->
	<tr height="30" bgcolor="lightgray">
		<td align="center"  width="50"  >진열</td> 
		<td align="center"  width="50"  >상품번호</td> 
	    <td align="center"  width="100" >상품종류</td>
	    <td align="center"  width="200" >상품명</td> 
	    <td align="center"  width="200" >색상</td>
	    <td align="center"  width="200" >사이즈</td>
	    <td align="center"  width="100" >등록일</td>
    </tr>
<%	for (ProductDTO dto : productList) { // ArrayList<ProductDTO> list = dao2.getList();
%>
	<tr height="50">
    	<td align="center" width="50" > 
	    	<% 
				String display = dto.getDisplay();
				if(display.equals("true")){%>
					<%= 'O'%>
			<%
				}else{%>
					<%= 'X'%>
			<%}%>
	    </td> <!-- 진열 display -->
    	<td align="center" width="100" >
    		<%= dto.getPdCode() %> <!-- 1상품번호 -->
    	</td>
    	<td align="center" width="150" > 
    		<%= dao2.categoryName(dto.getPdCategory())%><!-- 2상품종류 -->
		</td>
    	<td align="center" width="300" > 
    		<a href="productUpdateForm.jsp?pdCode=<%=dto.getPdCode()%>&pageNum=<%=currentPage%>">
    			<%= dto.getProductName()%> <!-- 3상품명 -->
    		</a>
		</td>
		<td align="center" width="200" style="word-break:break-all" > 
    		<%= dto.getColor2()%> <!-- 4색상 -->
		</td>
		<td align="center" width="200" style="word-break:break-all" > 
    		<%= dto.getSize2()%> <!-- 5사이즈 -->
		</td>
		<td align="center" width="100" > 
    		<%= dto.getRegDate() %> <!-- 6등록일 -->
		</td>
	</tr>
    <%}%>
</table>
<%}%>

<%	// 전체 게시글 수가 0보다 크면 // 페이지 번호 보이는 개수 10개로 지정한 것 페이지 번호 11 이상이면 [이전]으로 나오게
   if(col.equals("pdCategory")){ // category로 검색할 때
	   if (count > 0) { // 직접 계산해보기 // 계산해서 페이지 번호 보여주는 것 // 10 넘어가면 [이전]으로 나오고 11부터 시작
    	// 페이지 번호 = 전체 게시글 수 / 한 페이지에 보일 게시글 수 + ( 전체 게시글 수 % 한 페이지에 보일 게시글 수 == 0일 경우 0, 아닐 경우 1)
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		
        int startPage = (int)(currentPage/10)*10+1; // (int)(사용자가 클릭한 현재 페이지 번호 / 10) * 10 + 1 // 
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
	        if (endPage > pageCount) endPage = pageCount;
	        
	        if (startPage > 10) {    %>
	        <a href="searchList.jsp?pageNum=<%= startPage - 10 %>&col=<%=col%>&category=<%=category%>">[이전]</a>
	<%      }
	        for (int i = startPage ; i <= endPage ; i++) {  %> <!-- 페이지 번호 1씩 증가 -->
	        	<a href="searchList.jsp?pageNum=<%= i %>&col=<%=col%>&category=<%=category%>">[<%= i %>]</a>
	<%		}
	        if (endPage < pageCount) {  %> 
	        	<a href="searchList.jsp?pageNum=<%= startPage + 10 %>&col=<%=col%>&category=<%=category%>">[다음]</a>
	<%		}
    	}
   }else{ // pdCode, productName으로 검색할 때
		if (count > 0) { // 직접 계산해보기 // 계산해서 페이지 번호 보여주는 것 // 10 넘어가면 [이전]으로 나오고 11부터 시작
	    	// 페이지 번호 = 전체 게시글 수 / 한 페이지에 보일 게시글 수 + ( 전체 게시글 수 % 한 페이지에 보일 게시글 수 == 0일 경우 0, 아닐 경우 1)
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
			
		int startPage = (int)(currentPage/10)*10+1; // (int)(사용자가 클릭한 현재 페이지 번호 / 10) * 10 + 1 // 
		int pageBlock=10;
		int endPage = startPage + pageBlock-1;
			if (endPage > pageCount) endPage = pageCount;
		        
			if (startPage > 10) {    %>
		        <a href="searchList.jsp?pageNum=<%= startPage - 10 %>&col=<%=col%>&search=<%=search%>">[이전]</a>
		<%      }
			for (int i = startPage ; i <= endPage ; i++) {  %> <!-- 페이지 번호 1씩 증가 -->
		        <a href="searchList.jsp?pageNum=<%= i %>&col=<%=col%>&search=<%=search%>">[<%= i %>]</a>
		<%		}
			if (endPage < pageCount) {  %> 
		        <a href="searchList.jsp?pageNum=<%= startPage + 10 %>&col=<%=col%>&search=<%=search%>">[다음]</a>
		<%	}
	    }
   }
		
%>

<form action="searchList.jsp" method="post">
	<select name="col">
		<option value="pdCode">상품번호</option>
		<option value="pdCategory">상품종류</option>
		<option value="productName">상품명</option>
	</select>
	<select name="category">
		<option></option>
		<option value="1">로퍼</option>
		<option value="2">플랫</option>
		<option value="3">펌프스/힐</option>
		<option value="4">슬링백/뮬</option>
		<option value="5">샌들/슬리퍼</option>
		<option value="6">스니커즈</option>
		<option value="7">액세서리/양말</option>
		<option value="8">세트상품</option>
	</select>
	<input type="text" name="search" />
	<input type="submit" value="검색" />
</form>

</center>
</body>
</html>

</main>
</div>