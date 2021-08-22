<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "admin.dao.ProductDAO" %> <!-- 예은 DAO -->
<%@ page import = "admin.dao.ProductDAO2" %> <!-- 혜연 DAO (DAO 합치면 지울 것) -->
<%@ page import = "admin.dto.ProductDTO" %>
<%@ page import = "admin.dto.BoardDataBean" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file= "color.jsp" %>

<!-- 관리자 상품등록 -> DB에 상품 정보 저장 -> DB에서 상품 정보 불러오기 -->

<%
	String pw = request.getParameter("pw");
	ProductDAO2 dao2 = new ProductDAO2();
%>

<%
	// 이 블럭 아예 똑같음
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage -1) * pageSize +1;
	int endRow = currentPage * pageSize;
	int count = 0; // 전체 상품 수
	int number = 0; // 선택한 페이지의 글 번호
	
	List productList = null;
	List articleList = null;
	ProductDAO2 dbPro = new ProductDAO2();
	count = dbPro.getProductCount();							// 전체 상품 수
	if (count > 0) { // 글이 하나라도 있으면
		productList = dbPro.getProducts(startRow, endRow); // getProducts 메소드 리턴값 List, 반복할 때마다 dto 만든 걸 List로 반환해둔 것
	}
	
	List list = null;
	list = dao2.getProducts(startRow, endRow);
	number = count - (currentPage-1)*pageSize;

%>
<link href="style.css" rel="stylesheet" type="text/css">
<%@ include file="../adminTop.jsp" %>
<div class="pdmng" align="center">
<%@ include file="../adminAside.jsp" %>

<title>상품 목록</title>

<main>
<center>
<h1>상품 목록</h1>
<h3>(전체 상품 : <%=count%>)</h3>

<table width="1200" border-color="transparent" cellpadding="0" cellspacing="0">
	<tr>
		<td align="right">
			<%if(Mid.equals("admin")) {%>
			<br />
			<a href="productRegForm.jsp">상품등록</a>
			<br />
			<%}else{ %>
			권한이 없습니다.
			<a href="/badbad/userPage/loginForm.jsp">로그인</a>
			<%} %>
		</td>
	</tr>

</table>

<%if (count == 0) {%> <!-- 글 없을 때 -->
	<table width="1200" border="1" cellpadding="0" cellspacing="0">
		<tr>
    		<td align="center">
    			등록된 상품이 없습니다.
    		</td>
    	</tr>
	</table>

<%  } else {    %>
<table width="1200" border="1" cellpadding="0" cellspacing="0" align="center"> <!-- cellpadding: 글 사이에 약간의 여백이 있는데 그걸 없앤다는 뜻 (table border 있어서) -->
	<tr height="30" bgcolor="lightgray">
		<td align="center"  width="50"  >진열</td> 
		<td align="center"  width="100"  >상품번호</td>
	    <td align="center"  width="150" >상품종류</td>
	    <td align="center"  width="300" >상품명</td> 
	    <td align="center"  width="250" >색상</td>
	    <td align="center"  width="250" >사이즈</td>
	    <td align="center"  width="100" >등록일</td> 
    </tr>
<%	for (int i = 0; i<list.size(); i++) { // ArrayList<ProductDTO> list = dao2.getList();
	ProductDTO dto = (ProductDTO)list.get(i);
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
    		<%= dto.getPdCode() %> <!-- 상품번호 -->
    	</td>
    	<td align="center" width="150" > 
    		<%= dao2.categoryName(dto.getPdCategory())%><!-- 상품종류 -->
		</td>
    	<td align="center" width="300" name="pdCode" > 
    		<a href="productUpdateForm.jsp?pdCode=<%=dto.getPdCode()%>&pageNum=<%=currentPage%>">
    			<%= dto.getProductName()%> <!-- 상품명 -->
    		</a>
		</td>
		<td align="center" width="200" style="word-break:break-all" > 
    		<%= dto.getColor2()%> <!-- 색상 -->
		</td>
		<td align="center" width="200" style="word-break:break-all" > 
    		<%= dto.getSize2()%> <!-- 사이즈 -->
		</td>
		<td align="center" width="100" > 
    		<%= dto.getRegDate() %> <!-- 등록일 -->
		</td>
	</tr>
    <%}%>
</table>
<%}%>


<%
System.out.println(pageSize);
System.out.println(startRow);
System.out.println(endRow);

// 전체 게시글 수가 0보다 크면 // 페이지 번호 보이는 개수 10개로 지정한 것 페이지 번호 11 이상이면 [이전]으로 나오게
    if (count > 0) { // 직접 계산해보기 // 계산해서 페이지 번호 보여주는 것 // 10 넘어가면 [이전]으로 나오고 11부터 시작
    	// 페이지 번호 = 전체 게시글 수 / 한 페이지에 보일 게시글 수 + ( 전체 게시글 수 % 한 페이지에 보일 게시글 수 == 0일 경우 0, 아닐 경우 1)
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		
        int startPage = (int)(currentPage/10)*10+1; // (int)(사용자가 클릭한 현재 페이지 번호 / 10) * 10 + 1 // 
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
        <a href="productListBoard.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %> <!-- 페이지 번호 1씩 증가 -->
        	<a href="productListBoard.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%		}
        if (endPage < pageCount) {  %> 
        	<a href="productListBoard.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%		}
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
</main>
</div>
</div>